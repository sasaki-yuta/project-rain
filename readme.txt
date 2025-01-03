readme GoshuinQuest

環境構築

■flutter_mapのインストール
コマンドプロンプトでプロジェクトのカレントに移動する
インストール
C:\proj\flutter\project_rain>flutter pub add flutter_map

■latlong2(緯度経度をセットにした型が使用できるようになるパッケージ)のインストール
コマンドプロンプトでプロジェクトのカレントに移動する
インストール
C:\proj\flutter\project_rain>flutter pub add latlong2

■flutter_map_animationsのインストール
コマンドプロンプトでプロジェクトのカレントに移動する
インストール
C:\proj\flutter\project_rain>flutter pub add flutter_map_animations

■geolocator（現在位置取得）のインストール
コマンドプロンプトでプロジェクトのカレントに移動する
インストール
C:\proj\flutter\project_rain>flutter pub add geolocator

■Google AdMobのインストール
コマンドプロンプトでプロジェクトのカレントに移動する
インストール
C:\proj\flutter\project_rain>flutter pub add google_mobile_ads

■flutter_map_location_marker （現在位置アイコン）
コマンドプロンプトでプロジェクトのカレントに移動する
インストール
C:\proj\flutter\project_rain>flutter pub add flutter_map_location_marker 

------------------------
■エラー対応（google admob インストールしたらエラーが出た）

Launching lib\main.dart on sdk gphone64 x86 64 in debug mode...
Running Gradle task 'assembleDebug'...

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':webview_flutter_android:compileDebugJavaWithJavac'.
> Could not resolve all files for configuration ':webview_flutter_android:androidJdkImage'.
   > Failed to transform core-for-system-modules.jar to match attributes {artifactType=_internal_android_jdk_image, org.gradle.libraryelements=jar, org.gradle.usage=java-runtime}.
      > Execution failed for JdkImageTransform: C:\Users\rain0\AppData\Local\Android\sdk\platforms\android-34\core-for-system-modules.jar.
         > Error while executing process C:\Program Files\Android\Android Studio\jbr\bin\jlink.exe with arguments {--module-path C:\Users\rain0\.gradle\caches\transforms-3\fb247f22548bfd545efa0cbc10d96775\transformed\output\temp\jmod --add-modules java.base --output C:\Users\rain0\.gradle\caches\transforms-3\fb247f22548bfd545efa0cbc10d96775\transformed\output\jdkImage --disable-plugin system-modules}

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
> Get more help at https://help.gradle.org.

BUILD FAILED in 6s

┌─ Flutter Fix ────────────────────────────────────────────────────────────────────────────────────┐
│ [!] This is likely due to a known bug in Android Gradle Plugin (AGP) versions less than 8.2.1,   │
│ when                                                                                             │
│   1. setting a value for SourceCompatibility and                                                 │
│   2. using Java 21 or above.                                                                     │
│ To fix this error, please upgrade your AGP version to at least 8.2.1. The version of AGP that    │
│ your project uses is likely defined in:                                                          │
│ C:\proj\flutter\fluttertest\android\settings.gradle,                                             │
│ in the 'plugins' closure (by the number following "com.android.application").                    │
│  Alternatively, if your project was created with an older version of the templates, it is likely │
│ in the buildscript.dependencies closure of the top-level build.gradle:                           │
│ C:\proj\flutter\fluttertest\android\build.gradle,                                                │
│ as the number following "com.android.tools.build:gradle:".                                       │
│                                                                                                  │
│ For more information, see:                                                                       │
│ https://issuetracker.google.com/issues/294137077                                                 │
│ https://github.com/flutter/flutter/issues/156304                                                 │
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
Error: Gradle task assembleDebug failed with exit code 1

■解決方法
┌─ Flutter Fix ────────────────────────────────────────────────────────────────────────────────────┐
意向をchatGPTにくわして解決法を聞いて対応

①
C:\proj\flutter\project_rain\android\gradle\wrapper\gradle-wrapper.properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-all.zip ★バージョンをアップした

②
C:\proj\flutter\project_rain\android\settings.gradle
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.7.0" apply false ★バージョンをアップした


------------------------
