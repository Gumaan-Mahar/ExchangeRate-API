import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class BaseCurrencyConversions extends StatelessWidget {
  const BaseCurrencyConversions({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Select Base Currency',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
              ),
              DropdownButton<String>(
                underline: const SizedBox.shrink(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade700,
                ),
                value: homeProvider.selectedBaseCurrency,
                items: homeProvider.baseCurrencyExchangeRates?.keys.map(
                  (currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  },
                ).toList(),
                onChanged: (newVal) async {
                  if (newVal != homeProvider.selectedBaseCurrency) {
                    await homeProvider.updateSelectedBaseCurrency(newVal);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            children: homeProvider.baseCurrencyExchangeRates!.entries
                .map(
                  (entry) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          entry.value.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
