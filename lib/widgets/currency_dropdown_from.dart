import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class CurrencyDropDownFrom extends StatelessWidget {
  const CurrencyDropDownFrom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      padding: EdgeInsets.all(16.w),
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
            child: TextField(
              controller: homeProvider.amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16.sp),
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          DropdownButton<String>(
            value: homeProvider.selectedFromCurrency,
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
            onChanged: (newValue) => homeProvider.updateFromCurrency(newValue),
          ),
        ],
      ),
    );
  }
}
