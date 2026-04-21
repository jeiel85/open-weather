import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_weather/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // SharedPreferences 모킹 초기화
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: OpenWeatherApp(),
      ),
    );

    // 앱이 정상적으로 로드되었는지 확인
    expect(find.byType(OpenWeatherApp), findsOneWidget);
  });
}
