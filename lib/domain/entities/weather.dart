class Weather {
  final double temperature;
  final int weatherCode;
  final double humidity;
  final double windSpeed;
  final double apparentTemperature;
  final bool isDay;
  final double maxTemp;
  final double minTemp;
  final String locationName;
  final DateTime time;
  final List<HourlyWeather> hourlyForecast;
  final List<DailyWeather> dailyForecast;

  Weather({
    required this.temperature,
    required this.weatherCode,
    required this.humidity,
    required this.windSpeed,
    required this.apparentTemperature,
    required this.isDay,
    required this.maxTemp,
    required this.minTemp,
    required this.locationName,
    required this.time,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  String get weatherDescription => getWeatherDescription(weatherCode);

  static String getWeatherDescription(int code) {
    switch (code) {
      case 0: return '맑음';
      case 1: case 2: case 3: return '대체로 맑음';
      case 45: case 48: return '안개';
      case 51: case 53: case 55: return '이슬비';
      case 61: case 63: case 65: return '비';
      case 71: case 73: case 75: return '눈';
      case 95: return '뇌우';
      default: return '알 수 없음';
    }
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final int weatherCode;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });
}

class DailyWeather {
  final DateTime time;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;

  DailyWeather({
    required this.time,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCode,
  });
}
