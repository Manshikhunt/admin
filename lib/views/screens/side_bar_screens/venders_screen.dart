import 'package:admin/views/screens/side_bar_screens/widgets/vender_widget.dart';
import 'package:flutter/material.dart';

class VenderScreen extends StatelessWidget {
  const VenderScreen({super.key});

  static const routeName = 'VenderScreen';

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
              'Manage Venders',
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
              _rowHeader('Logo', 1),
              _rowHeader('Business Name', 3),
              _rowHeader('City', 2),
              _rowHeader('State', 2),
              _rowHeader('Action', 1),
              _rowHeader('View More', 1),
            ],
          ),
          VenderWidget(),
        ],
      ),
    );
  }
}
