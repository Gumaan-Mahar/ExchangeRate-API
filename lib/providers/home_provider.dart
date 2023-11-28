import 'dart:developer';

import 'package:flutter/material.dart';

import '../services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();
  List<List<String>> currencyCodes = [];
  String selectedFromCurrency = '';
  String selectedToCurrency = '';
  String selectedBaseCurrency = 'PKR';
  double convertedAmount = 0.0;
  Map<String, dynamic>? baseCurrencyExchangeRates;

  Future<void> loadCurrencyCodes() async {
    try {
      final List<List<String>> codes = await ApiServices.getCurrencyCodes();
      currencyCodes = codes;
      selectedFromCurrency =
          currencyCodes.isNotEmpty ? currencyCodes[111][0] : '';
      selectedToCurrency =
          currencyCodes.isNotEmpty ? currencyCodes[146][0] : '';
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  HomeProvider() {
    initialize();
  }

  Future<void> initialize() async {
    try {
      baseCurrencyExchangeRates = await getBaseCurrencyExchangeRrates();
      await loadCurrencyCodes();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> convertCurrency() async {
    try {
      final Map<String, dynamic> exchangeRates =
          await ApiServices.getExchangeRates(selectedFromCurrency);
      final double conversionRate =
          exchangeRates['conversion_rates'][selectedToCurrency];
      final double amountToConvert = double.parse(amountController.text);
      final double result = amountToConvert * conversionRate;

      convertedAmount = result;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>> getBaseCurrencyExchangeRrates() async {
    try {
      final Map<String, dynamic> exchangeRates =
          await ApiServices.getExchangeRates(selectedBaseCurrency);
      final Map<String, dynamic> conversionRate =
          exchangeRates['conversion_rates'];
      return conversionRate;
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  getCachedExchangeRate(String fromCurrency, String toCurrency) {
    final Map<String, dynamic>? exchangeRates =
        ApiServices.getCachedExchangeRates();
    if (exchangeRates != null &&
        exchangeRates.containsKey('conversion_rates')) {
      final conversionRate = exchangeRates['conversion_rates'][toCurrency];
      return conversionRate;
    } else {
      return 0.0;
    }
  }

  void updateFromCurrency(String? newValue) {
    if (newValue != null) {
      selectedFromCurrency = newValue;
      notifyListeners();
    }
  }

  void updateToCurrency(String? newValue) {
    if (newValue != null) {
      selectedToCurrency = newValue;
      notifyListeners();
    }
  }

  Future<void> updateSelectedBaseCurrency(String? newValue) async {
    if (newValue != null) {
      selectedBaseCurrency = newValue;
      baseCurrencyExchangeRates = await getBaseCurrencyExchangeRrates();
      notifyListeners();
    }
  }

}
