
extension StringX on String {
  String get toIconPath {
    switch (this) {
      case "Clouds":
        return "assets/icons/cloudy.png";
      case "Clear":
        return "assets/icons/sunny.png";
      case "Rain":
        return "assets/icons/rain.png";
      case "Drizzle":
        return "assets/icons/rain.png";
      case "Thunderstorm":
        return "assets/icons/rain.png";
      case "Snow":
        return "assets/icons/snow.png";
      default:
        return "assets/icons/cloudy.png";
    }
  }
}
