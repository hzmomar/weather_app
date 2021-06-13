import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  final double? height;
  const LoadingIcon({Key? key, this.height = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: const Center(
        child: SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
