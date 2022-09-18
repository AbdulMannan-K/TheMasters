import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: quantity > 0 ? onDecrement : null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: const Size(35, 35),
            disabledForegroundColor: Colors.grey.shade900,
            disabledBackgroundColor: Colors.grey.shade400,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
          ),
          child: const Icon(Icons.remove_rounded, size: 18),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.black12),
            ),
          ),
          child: SizedBox(
            width: 40,
            height: 27,
            child: Center(child: Text(quantity.toString())),
          ),
        ),
        TextButton(
          onPressed: onIncrement,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: const Size(35, 35),
            disabledBackgroundColor: Colors.grey.shade400,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
          ),
          child: const Icon(Icons.add_rounded, size: 18),
        ),
      ],
    );
  }
}
