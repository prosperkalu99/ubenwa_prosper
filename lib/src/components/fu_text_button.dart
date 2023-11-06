import 'package:flutter/material.dart';
import 'package:udenwa_prosper/src/constants/string_constants.dart';

class FUTextButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Color? indicatorColor;
  final double? indicatorSize;

  const FUTextButton({super.key, required this.text, this.isLoading = false,
    this.onPressed, this.style, this.isDisabled = false, this.indicatorColor, this.indicatorSize});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: isDisabled || isLoading? null : ()=> onPressed?.call(),
      child: isLoading ? SizedBox(
        height: indicatorSize ?? 20, width: indicatorSize ?? 20,
        child: CircularProgressIndicator(color: indicatorColor??Colors.white,),
      ) : Text(text, textAlign: TextAlign.center, style: const TextStyle(fontFamily: StringConstants.fontFamily),),
    );
  }
}
