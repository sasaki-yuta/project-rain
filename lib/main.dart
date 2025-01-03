import 'package:flutter/material.dart';
// map
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
// admob
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // エミュレーター右上の「debug」という帯を消す
      debugShowCheckedModeBanner: false,
      title: '御朱印 Quest',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '御朱印 Quest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Marker> addMarkers = [];
  // 現在位置
//  List<CircleMarker> circleMarkers = [];
  LatLng currentPosition = LatLng(35.6815366,139.7655055); // 初期位置（東京駅）
  // MapControllerのインスタンス作成
  late final _animatedMapController = AnimatedMapController(vsync: this);

  void _addMarker(LatLng latlng) {
    setState(() {
      addMarkers.add(
        Marker(
          width: 30.0,
          height: 30.0,
          point: latlng,
          child: GestureDetector(
            onTap: () {
              _animatedMapController.animateTo(dest: latlng);
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 50,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // admob
    final bannerId = getAdBannerUnitId();
    BannerAd myBanner = BannerAd(
        adUnitId: bannerId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: const BannerAdListener()
    );
    myBanner.load();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10, // 割合
            child: FlutterMap(
              // mapControllerをFlutterMapに指定
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                // GPS受ける前の初期現在地を設定（東京駅）
                initialCenter: LatLng(35.6815366,139.7655055),
                initialZoom: 10.0,
                maxZoom: 20.0,
                minZoom: 8.0,
                onTap: (tapPosition, point) {
                  _addMarker(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: LatLng(currentPosition.latitude, currentPosition.longitude),//currentPosition,
                      child: Icon(
                        Icons.directions_walk, // 自車位置マークとして車のアイコンを使用
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                MarkerLayer(markers: addMarkers),
              ],
            ),
          ),
          Container(
            width: myBanner.size.width.toDouble(),
            height: myBanner.size.height.toDouble(),
            alignment: Alignment.center,
            child: AdWidget(ad: myBanner),
          ),
          const SafeArea(
            // admobのバナーをSafeAreaで表示するため
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenToLocationUpdates();
    // admob
    addBanner();
  }

  // 現在地の取得
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // サービスが有効か確認
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // サービスが無効な場合、ユーザーに知らせる
      return;
    }

    // パーミッションの確認
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // ユーザーがパーミッションを永続的に拒否している場合
      return;
    } else if (permission == LocationPermission.denied) {
      // ユーザーがパーミッションを拒否した場合
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    // 現在地を取得
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    // マップの中心位置を更新
    _animatedMapController.mapController.move(currentPosition, 13);
  }

  // 位置情報の更新をリスン
  void _listenToLocationUpdates() {
    Geolocator.getPositionStream(locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // 10メートルごとに位置更新
    )).listen((Position position) {
      // 指定したメートルを移動するとここに突入する
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });

      // マップの位置を更新
      _animatedMapController.mapController.move(currentPosition, 13);
    });
  }
}
