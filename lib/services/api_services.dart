import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Map<String, dynamic>? _cachedExchangeRates;

  static Future<List<List<String>>> getCurrencyCodes() async {
    final String apiKey = dotenv.env['API_KEY']!;
    final String apiUrl = 'https://v6.exchangerate-api.com/v6/$apiKey/codes';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<List<String>> supportedCodes =
          List.from(data['supported_codes'])
              .map((dynamic item) => List<String>.from(item))
              .toList();
      return supportedCodes;
    } else {
      throw Exception('Failed to load currency codes');
    }
  }

  static Future<Map<String, dynamic>> getExchangeRates(
      String fromCurrency) async {
    final String apiKey = dotenv.env['API_KEY']!;
    final String apiUrl =
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/$fromCurrency';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> exchangeRates = jsonDecode(response.body);
      _cachedExchangeRates = exchangeRates;
      return exchangeRates;
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  static Map<String, dynamic>? getCachedExchangeRates() {
    return _cachedExchangeRates;
  }
}
