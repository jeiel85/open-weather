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
    super.airQualityIndex,
    super.uvIndex,
    super.precipitationProbability,
    super.sunrise,
    super.sunset,
    super.pressure,
    super.visibility,
    super.dewPoint,
    super.cloudCover,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String locationName) {
    final current = json['current'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;

    // 시간별 예보 (48시간)
    final List<HourlyWeather> hourlyList = [];
    final List<dynamic> hourlyTime = hourly['time'];
    final List<dynamic> hourlyTemp = hourly['temperature_2m'];
    final List<dynamic> hourlyCode = hourly['weather_code'];
    final List<dynamic> hourlyPrecip = hourly['precipitation_probability'] ?? [];

    final hourlyCount = hourlyTime.length >= 48 ? 48 : hourlyTime.length;
    for (int i = 0; i < hourlyCount; i++) {
      hourlyList.add(HourlyWeather(
        time: DateTime.parse(hourlyTime[i]),
        temperature: (hourlyTemp[i] as num).toDouble(),
        weatherCode: (hourlyCode[i] as num).toInt(),
        precipitationProbability: hourlyPrecip.isNotEmpty ? (hourlyPrecip[i] as num?)?.toDouble() : null,
      ));
    }

    // 일별 예보 (16일)
    final List<DailyWeather> dailyList = [];
    final List<dynamic> dailyTime = daily['time'];
    final List<dynamic> dailyMax = daily['temperature_2m_max'];
    final List<dynamic> dailyMin = daily['temperature_2m_min'];
    final List<dynamic> dailyCode = daily['weather_code'];
    final List<dynamic> dailyPrecip = daily['precipitation_probability_max'] ?? [];
    final List<dynamic> dailyUv = daily['uv_index_max'] ?? [];

    final dailyCount = dailyTime.length >= 16 ? 16 : dailyTime.length;
    for (int i = 0; i < dailyCount; i++) {
      dailyList.add(DailyWeather(
        time: DateTime.parse(dailyTime[i]),
        maxTemp: (dailyMax[i] as num).toDouble(),
        minTemp: (dailyMin[i] as num).toDouble(),
        weatherCode: (dailyCode[i] as num).toInt(),
        precipitationProbability: dailyPrecip.isNotEmpty ? (dailyPrecip[i] as num?)?.toDouble() : null,
        uvIndex: dailyUv.isNotEmpty ? (dailyUv[i] as num?)?.toDouble() : null,
      ));
    }

    // 일출/일몰 시간
    DateTime? sunrise;
    DateTime? sunset;
    if (daily['sunrise'] != null && (daily['sunrise'] as List).isNotEmpty) {
      final sunriseList = daily['sunrise'] as List;
      if (sunriseList.isNotEmpty && sunriseList[0] != null) {
        sunrise = DateTime.tryParse(sunriseList[0].toString());
      }
    }
    if (daily['sunset'] != null && (daily['sunset'] as List).isNotEmpty) {
      final sunsetList = daily['sunset'] as List;
      if (sunsetList.isNotEmpty && sunsetList[0] != null) {
        sunset = DateTime.tryParse(sunsetList[0].toString());
      }
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
      // 확장 데이터
      uvIndex: (current['uv_index'] as num?)?.toDouble(),
      precipitationProbability: (hourlyPrecip.isNotEmpty) ? (hourlyPrecip[0] as num?)?.toDouble() : null,
      sunrise: sunrise,
      sunset: sunset,
      pressure: (current['pressure_msl'] as num?)?.toDouble(),
      visibility: (current['visibility'] as num?)?.toDouble(),
      dewPoint: (current['dew_point_2m'] as num?)?.toDouble(),
      cloudCover: (current['cloud_cover'] as num?)?.toInt(),
      airQualityIndex: null, // 별도 API 호출 필요
    );
  }
}
