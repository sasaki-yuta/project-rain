import 'package:flutter/material.dart';
// map
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// admob
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admob.dart';
// data
import 'data.dart';

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
      title: '御朱印 Quest（一宮編）',
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
      home: const MyHomePage(title: '御朱印 Quest（一宮編）'),
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
  late Position _currentPosition;
  bool _isMapMoving = false; // 地図がスクロール中かどうかのフラグ
  double _currentZoom = 13.0; // 現在のズームレベルを保持
  double _currentHeading = 0; // 進行方向（ヘディングアップで地図更新する場合）

  LatLng currentPosition = LatLng(35.6815366,139.7655055); // 初期位置（東京駅）
  // MapControllerのインスタンス作成
  late final _animatedMapController = AnimatedMapController(vsync: this);

  // 神社データクラス
  DataMnager _dataMnager = DataMnager();

  void _addMarker(IchinomiyaMonJinja ichinomiya) {
    LatLng latlng = LatLng(ichinomiya.latitude, ichinomiya.longitude);
    Text title = Text(ichinomiya.name);
    Text content = Text("よみ：${ichinomiya.yomi}\n地方：${ichinomiya.area}\n旧国名：${ichinomiya.kyuukokumei}\n住所：${ichinomiya.address}\n祭神：${ichinomiya.saijin}\n御神徳：${ichinomiya.goshintoku}");

    setState(() {
      addMarkers.add(
        Marker(
          width: 30.0,
          height: 30.0,
          point: latlng,
          child: GestureDetector(
            onTap: () {
              _animatedMapController.animateTo(dest: latlng);
              // マーカーがタップされたときにダイアログを表示
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: title,//const Text("Marker Tapped"),
                    content: content,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ダイアログを閉じる
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
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
                initialZoom: 8.0,
                maxZoom: 20.0,
                minZoom: 8.0,
                onTap: (tapPosition, point) {
//                  _addMarker(point);
                },
                onPositionChanged: _onPositionChanged, // 位置変更のコールバック
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                _isPositionInitialized() == false? Center(child: CircularProgressIndicator()) :
                LocationMarkerLayer( // ここで現在地を表示
                  position: LocationMarkerPosition(
                    latitude: _currentPosition.latitude,
                    longitude: _currentPosition.longitude,
                    accuracy: _currentPosition.accuracy, // 位置精度を追加
                  ),
                  style: LocationMarkerStyle(
                    marker: Icon(Icons.my_location, color: Colors.blue, size: 30), // 現在地のアイコンを変更
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: _moveToCurrentLocation, // 現在地に戻す処理
                    child: Icon(Icons.my_location),
                    tooltip: 'Go to Current Location',
                  ),
                ),
                Positioned(
                  top: 90,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: _moveToCurrentLocation, // 現在地に戻す処理
                    child: Icon(Icons.my_library_books),
                    tooltip: 'Go to Current Location',
                  ),
                ),
                // _addMarker()で登録されたマーカを表示する
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
    _setIchinomiyaMarker();
    // admob
    addBanner();
  }

  void _setIchinomiyaMarker() {
    List<IchinomiyaMonJinja> ichinomiyaJinjaList = _dataMnager.getIchinomiyaJinja();
    for (var jinja in ichinomiyaJinjaList) {
      LatLng latlon = LatLng(jinja.latitude, jinja.longitude);
      _addMarker(jinja);
    }
  }

  // 地図の位置が変わった際の処理
  void _onPositionChanged(MapCamera position, bool hasMoved) {
    setState(() {
      _isMapMoving = hasMoved; // 地図がスクロール中かどうかを更新
      _currentZoom = position.zoom;
    });
  }

  // 現在地に戻すボタンが押された時の処理
  void _moveToCurrentLocation() {
    _isMapMoving = false;
    // ノースアップに戻す
    _animatedMapController.mapController.rotate(0);
    // 地図の中心位置を現在位置にする
    _animatedMapController.mapController.move(currentPosition, _currentZoom);
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
      _currentPosition = position;
    });

    // 地図スクロールしていない時だけマップの中心位置を更新
    if (false == _isMapMoving) {
      _animatedMapController.mapController.move(currentPosition, _currentZoom);
    }
  }

  // 位置情報の更新をリスン
  void _listenToLocationUpdates() {
    Geolocator.getPositionStream(locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // 10メートルごとに位置更新
    )).listen((Position position) {
      // 指定したメートルを移動するとここに突入する
      setState(() {
        // 現在位置
        currentPosition = LatLng(position.latitude, position.longitude);
        // 現在のヘディング（進行方向）
        _currentHeading = position.heading;
        _currentPosition = position;
      });

      // 地図スクロールしていない時だけマップの中心位置を更新
      if (false == _isMapMoving) {
// ヘディングアップで地図更新する場合
//      _animatedMapController.mapController.rotate(_currentHeading)
        _animatedMapController.mapController.move(currentPosition, _currentZoom);
      }
    });
  }

  bool _isPositionInitialized() {
    try {
      // late変数が初期化されていないとき、エラーをキャッチ
      _currentPosition;
      return true;  // 初期化されていればtrue
    } catch (e) {
      return false; // 初期化されていなければfalse
    }
  }
}
