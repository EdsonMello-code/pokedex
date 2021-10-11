import 'package:flutter/material.dart';

class StatsWidget extends StatefulWidget {
  final String label;

  final int value;

  const StatsWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  StatsWidgetState createState() => StatsWidgetState();
}

class StatsWidgetState extends State<StatsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            widget.label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            widget.value.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              height: 10,
              color: theme.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
