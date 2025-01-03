// 神社の情報を格納するクラス
class IchinomiyaMonJinja {
  // エリア
  final String area;
  // 名称
  final String name;
  // よみ
  final String yomi;
  // 住所
  final String address;
  // 詳細
  final String description;
  // 緯度
  final double latitude;
  // 軽度
  final double longitude;
  // 旧国名
  final String kyuukokumei;
  // 祭神
  final String saijin;
  // 御神徳
  final String goshintoku;
  // 参拝可否
  final bool iscomp;

  // コンストラクタ
  const IchinomiyaMonJinja({
    required this.area,
    required this.name,
    required this.yomi,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.kyuukokumei,
    required this.saijin,
    required this.goshintoku,
    required this.iscomp,
  });
}

// データを管理するクラス
class DataMnager {
  List<IchinomiyaMonJinja> ichinomiyaJinjaList = [
    // 1
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '石都々古和気神社',
      yomi: 'いわつつこわけじんじゃ',
      address: '〒963-7858 石川郡石川町字下泉150',
      description: '',
      latitude: 37.144977,
      longitude: 140.450946,
      kyuukokumei: '陸奥国',
      saijin: '味耜高彦根命・大国主命',
      goshintoku: '殖産興業・武運長久・安産守護',
      iscomp: false,
    ),
    // 2
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '都々古別神社(八槻)',
      yomi: 'やつきつつこわけじんじゃ',
      address: '〒963-5672 福島県東白川郡棚倉町八槻大宮 224',
      description: '',
      latitude: 36.99453,
      longitude: 140.392099,
      kyuukokumei: '陸奥国',
      saijin: '味耜高彦根命・日本武尊',
      goshintoku: '交通安全・五穀豊穣・家内安全',
      iscomp: false,
    ),
    // 3
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '都々古別神社(馬場)',
      yomi: 'ばばつつこわけじんじゃ',
      address: '〒963-6131 福島県東白川郡棚倉町棚倉字馬場 39',
      description: '',
      latitude: 37.032058,
      longitude: 140.375912,
      kyuukokumei: '陸奥国',
      saijin: '味耜高彦根命・日本武尊',
      goshintoku: '殖産興業・家内安全・戦勝祈願',
      iscomp: false,
    ),
    // 4
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '伊佐須美神社',
      yomi: 'いさすみじんじゃ',
      address: '〒969-6263 福島県大沼郡会津美里町宮林甲 4377',
      description: '',
      latitude: 37.456776,
      longitude: 139.840682,
      kyuukokumei: '岩代国',
      saijin: '伊弉諾尊・伊弉冉尊・大毘古命・建沼河別命',
      goshintoku: '事業育成・方除開運・厄除健康',
      iscomp: false,
    ),
    // 5
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '鳥海山大物忌神社(蕨岡口之宮)',
      yomi: 'ちょうかいざんおおものいみじんじゃ',
      address: '〒999-8314 山形県飽海郡遊佐町上蕨岡字松ヶ岡51',
      description: '',
      latitude: 38.9966981,
      longitude: 139.9412633,
      kyuukokumei: '出羽国',
      saijin: '大物忌神',
      goshintoku: '五穀豊穣・海上安全・厄除開運',
      iscomp: false,
    ),
    // 6
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '鳥海山大物忌神社(吹浦口之宮)',
      yomi: 'ちょうかいざんおおものいみじんじゃ',
      address: '〒999-8521 山形県飽海郡遊佐町吹浦字布倉1',
      description: '',
      latitude: 39.0743599,
      longitude: 139.8762564,
      kyuukokumei: '出羽国',
      saijin: '大物忌神',
      goshintoku: '五穀豊穣・海上安全・厄除開運',
      iscomp: false,
    ),
    // 7
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '鹽竈神社・志波彦神社',
      yomi: 'しおがまじんじゃ・しわひこじんじゃ',
      address: '〒985-8510 宮城県塩竈市一森山 1-1',
      description: '',
      latitude: 38.319056,
      longitude: 141.013625,
      kyuukokumei: '陸奥国',
      saijin: '鹽土老翁神・武甕槌神・経津主神・志波彦神',
      goshintoku: '安産守護・延命長寿・大漁',
      iscomp: false,
    ),
    // 8
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '駒形神社',
      yomi: 'こまがたじんじゃ',
      address: '〒023-0857 岩手県奥州市水沢区中上野町 1-83',
      description: '',
      latitude: 39.136552,
      longitude: 141.138086,
      kyuukokumei: '陸中国',
      saijin: '駒形大神',
      goshintoku: '産業開発・交通安全・必勝祈願',
      iscomp: false,
    ),
    // 9
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '岩木山神社',
      yomi: 'いわきやまじんじゃ',
      address: '〒036-1343 青森県弘前市百沢字寺沢 27',
      description: '',
      latitude: 40.621852,
      longitude: 140.340684,
      kyuukokumei: '津軽国',
      saijin: '顕國魂神・多都比姫神',
      goshintoku: '津軽守護・五穀豊穣・開運',
      iscomp: false,
    ),
    // 10
    IchinomiyaMonJinja(
      area: '北海道・東北',
      name: '北海道神宮',
      yomi: 'ほっかいどうじんぐう',
      address: '〒064-8505 北海道札幌市中央区宮ヶ丘 474',
      description: '',
      latitude: 43.054273,
      longitude: 141.307659,
      kyuukokumei: '蝦夷国',
      saijin: '大国魂神・大那牟遲神',
      goshintoku: '北海道開拓・医薬守護・醸造守護',
      iscomp: false,
    ),
    // 11
    IchinomiyaMonJinja(
      area: '関東',
      name: '寒川神社',
      yomi: 'さむかわじんじゃ',
      address: '〒253-0195 神奈川県高座郡寒川町宮山 3916',
      description: '',
      latitude: 35.3798092,
      longitude: 139.3808825,
      kyuukokumei: '相模国',
      saijin: '寒川比古命・寒川比女命',
      goshintoku: '八方除け・厄除け・家内安全',
      iscomp: false,
    ),
    // 12
    IchinomiyaMonJinja(
      area: '関東',
      name: '鶴岡八幡宮',
      yomi: 'つるがおかはちまんぐう',
      address: '〒248-8588 神奈川県鎌倉市雪ノ下 2-1-31',
      description: '',
      latitude: 35.3261492,
      longitude: 139.5547113,
      kyuukokumei: '相模国',
      saijin: '応神天皇・比売神・神功皇后',
      goshintoku: '出世開運・合格祈願・縁結び',
      iscomp: false,
    ),
  ];

  List<IchinomiyaMonJinja> getIchinomiyaJinja() {
    return ichinomiyaJinjaList;
  }
}