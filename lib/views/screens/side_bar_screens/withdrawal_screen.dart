import 'package:flutter/material.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  static const routeName = 'WithdrawalScreen';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.green[200]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Withdrawal',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              _rowHeader('Name', 1),
              _rowHeader('Amount', 3),
              _rowHeader('Bank Name', 2),
              _rowHeader('Bank AC', 2),
              _rowHeader('Email', 1),
              _rowHeader('Phone', 1),
            ],
          ),
        ],
      ),
    );
  }
}