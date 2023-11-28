import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class IndicativeExchangeRateContainer extends StatelessWidget {
  const IndicativeExchangeRateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    if (homeProvider.selectedFromCurrency.isNotEmpty &&
        homeProvider.selectedToCurrency.isNotEmpty) {
      final exchangeRateFromTo = homeProvider.getCachedExchangeRate(
          homeProvider.selectedFromCurrency, homeProvider.selectedToCurrency);
      final exchangeRateToFrom = 1 / exchangeRateFromTo;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: '1 ',
              style: const TextStyle(color: Colors.cyan),
              children: [
                TextSpan(
                  text: '${homeProvider.selectedFromCurrency} =',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' ${exchangeRateFromTo.toStringAsFixed(4)} ',
                  style: const TextStyle(
                    color: Colors.cyan,
                  ),
                  children: [
                    TextSpan(
                      text: homeProvider.selectedToCurrency,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '1 ',
              style: const TextStyle(color: Colors.cyan),
              children: [
                TextSpan(
                  text: '${homeProvider.selectedToCurrency} =',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' ${exchangeRateToFrom.toStringAsFixed(4)} ',
                  style: const TextStyle(
                    color: Colors.cyan,
                  ),
                  children: [
                    TextSpan(
                      text: homeProvider.selectedFromCurrency,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
