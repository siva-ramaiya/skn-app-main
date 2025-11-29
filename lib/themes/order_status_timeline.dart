import 'package:flutter/material.dart';

class OrderStatusTimeline extends StatelessWidget {
  final String status;

  OrderStatusTimeline({required this.status});

  final List<String> statusOrder = [
    "pending",
    "processing",
    "shipped",
    "delivered",
    "completed",
    "cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = statusOrder.indexOf(status.toLowerCase());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: statusOrder.map((step) {
          final int stepIndex = statusOrder.indexOf(step);
          final bool isCurrent = stepIndex == currentIndex;
          final bool isCompleted = stepIndex < currentIndex;

          Color circleColor = isCompleted
              ? Colors.green
              : isCurrent
                  ? Colors.orange
                  : Colors.grey.shade400;

          Color lineColor = isCompleted
              ? Colors.green
              : isCurrent
                  ? Colors.orange
                  : Colors.grey.shade300;

          Color textColor = isCompleted
              ? Colors.green
              : isCurrent
                  ? Colors.orange
                  : Colors.grey;

          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: circleColor,
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 60,
                  height: 3,
                  color: lineColor,
                ),
                const SizedBox(height: 4),
                Text(
                  step,
                  style: TextStyle(
                    fontSize: 10,
                    color: textColor,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
