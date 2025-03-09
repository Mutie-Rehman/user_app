import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String? message;
  ProgressDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const SizedBox(
                  width: 6,
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
                const SizedBox(
                  width: 26,
                ),
                Text(
                  message!,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}
