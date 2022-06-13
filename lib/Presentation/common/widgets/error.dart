import 'package:flutter/material.dart';
import 'package:quiz_us/Presentation/common/widgets/customButton.dart';

class Error extends StatelessWidget {
  final String message;
  final VoidCallback callback;
  const Error({Key? key, required this.message, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Text(message,
          style: const TextStyle(
            color: Colors.white,fontSize: 20.0
            )
          ),
          const SizedBox(height: 20.0),
          CustomButton(title: 'Retry', onTap: callback)
        ],
      ),
    );
  }
}
