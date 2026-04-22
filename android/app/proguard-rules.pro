# Flutter 관련 설정
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# flutter_local_notifications 관련 설정
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Google Fonts 및 기타 필요한 라이브러리 설정
-keep class com.google.fonts.** { *; }

# AndroidX 관련 설정
-keep class androidx.lifecycle.** { *; }
-keep class androidx.core.** { *; }

# geolocator 및 geocoding 관련 설정
-keep class com.baseflow.geolocator.** { *; }
-keep class com.baseflow.geocoding.** { *; }

# Flutter Play Store Split 관련 경고 무시 (엔진 내부 참조용)
-dontwarn com.google.android.play.core.**
-dontwarn com.baseflow.geocoding.**
-dontwarn com.baseflow.geolocator.**
