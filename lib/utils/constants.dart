import 'package:flutter_dotenv/flutter_dotenv.dart' as fd;

const baseUrl = "https://api.openweathermap.org/data/2.5";
final apiKey = fd.dotenv.get('API_KEY', fallback: '');

