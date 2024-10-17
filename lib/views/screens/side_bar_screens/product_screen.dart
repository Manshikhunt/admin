import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const routeName = 'ProductScreen';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white), color: Colors.green[200]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
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
              'Products',
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
              _rowHeader('Image', 1),
              _rowHeader('Name', 3),
              _rowHeader('Price', 2),
              _rowHeader('Quantity', 2),
              _rowHeader('Action', 1),
              _rowHeader('View More', 1),
            ],
          ),
        ],
      ),
    );
  }
}
