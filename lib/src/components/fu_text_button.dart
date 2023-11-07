import 'package:flutter/cupertino.dart';
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
  final bool useCupertino;

  const FUTextButton({super.key, required this.text, this.isLoading = false,
    this.onPressed, this.style, this.isDisabled = false, this.indicatorColor,
    this.indicatorSize, this.useCupertino = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: isDisabled || isLoading? null : ()=> onPressed?.call(),
      child: isLoading ? SizedBox(
        height: indicatorSize ?? 20, width: indicatorSize ?? 20,
        child: useCupertino ? const CupertinoActivityIndicator() : CircularProgressIndicator(color: indicatorColor??Colors.white,),
      ) : Text(text, textAlign: TextAlign.center, style: const TextStyle(fontFamily: StringConstants.fontFamily),),
    );
  }
}
