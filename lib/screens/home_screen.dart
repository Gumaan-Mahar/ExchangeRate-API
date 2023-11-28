import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import '../widgets/base_currency_conversions.dart';
import '../widgets/currency_dropdown_from.dart';
import '../widgets/currency_dropdown_to.dart';
import '../widgets/indicative_exchange_rate_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget? child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 50.h,
                floating: false,
                pinned: true,
                backgroundColor: Colors.blueGrey,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.all(
                    8.w,
                  ),
                  title: Text(
                    'Currency Converter',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: Colors.blueGrey,
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CurrencyDropDownFrom(),
                          SizedBox(height: 4.h),
                          Center(
                            child: Icon(
                              Icons.swap_vertical_circle_outlined,
                              size: 36.w,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          const CurrencyDropDownTo(),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const IndicativeExchangeRateContainer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  await homeProvider.convertCurrency();
                                },
                                child: const Text('Convert'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Today\'s Rates',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        homeProvider.baseCurrencyExchangeRates == null
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blueGrey,
                                ),
                              )
                            : const BaseCurrencyConversions(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
