import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class CurrencyDropDownTo extends StatelessWidget {
  const CurrencyDropDownTo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${homeProvider.convertedAmount}',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          SizedBox(width: 16.w),
          DropdownButton<String>(
            value: homeProvider.selectedToCurrency,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade700,
            ),
            underline: const SizedBox.shrink(),
            items: homeProvider.currencyCodes.map(
              (List<String> currency) {
                return DropdownMenuItem<String>(
                  value: currency[0],
                  child: Text(
                    currency[0],
                    style: TextStyle(fontSize: 16.sp),
                  ),
                );
              },
            ).toList(),
            onChanged: (newValue) => homeProvider.updateToCurrency(newValue),
          ),
        ],
      ),
    );
  }
}
