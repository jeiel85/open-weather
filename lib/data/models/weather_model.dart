import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.temperature,
    required super.weatherCode,
    required super.humidity,
    required super.windSpeed,
    required super.apparentTemperature,
    required super.isDay,
    required super.maxTemp,
    required super.minTemp,
    required super.locationName,
    required super.time,
    required super.hourlyForecast,
    required super.dailyForecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String locationName) {
    final current = json['current'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;

    final List<HourlyWeather> hourlyList = [];
    final List<dynamic> hourlyTime = hourly['time'];
    final List<dynamic> hourlyTemp = hourly['temperature_2m'];
    final List<dynamic> hourlyCode = hourly['weather_code'];

    // 향후 24시간 데이터만 추출
    for (int i = 0; i < 24; i++) {
      hourlyList.add(HourlyWeather(
        time: DateTime.parse(hourlyTime[i]),
        temperature: (hourlyTemp[i] as num).toDouble(),
        weatherCode: (hourlyCode[i] as num).toInt(),
      ));
    }

    final List<DailyWeather> dailyList = [];
    final List<dynamic> dailyTime = daily['time'];
    final List<dynamic> dailyMax = daily['temperature_2m_max'];
    final List<dynamic> dailyMin = daily['temperature_2m_min'];
    final List<dynamic> dailyCode = daily['weather_code'];

    for (int i = 0; i < dailyTime.length; i++) {
      dailyList.add(DailyWeather(
        time: DateTime.parse(dailyTime[i]),
        maxTemp: (dailyMax[i] as num).toDouble(),
        minTemp: (dailyMin[i] as num).toDouble(),
        weatherCode: (dailyCode[i] as num).toInt(),
      ));
    }

    return WeatherModel(
      temperature: (current['temperature_2m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      humidity: (current['relative_humidity_2m'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      apparentTemperature: (current['apparent_temperature'] as num).toDouble(),
      isDay: (current['is_day'] as num) == 1,
      maxTemp: (daily['temperature_2m_max'][0] as num).toDouble(),
      minTemp: (daily['temperature_2m_min'][0] as num).toDouble(),
      locationName: locationName,
      time: DateTime.parse(current['time'] as String),
      hourlyForecast: hourlyList,
      dailyForecast: dailyList,
    );
  }
}
