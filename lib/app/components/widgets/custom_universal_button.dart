import 'package:adventure/app/components/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class CustomUniversalButton extends StatelessWidget {
  final String title;
  final String? semanticLabel;
  final double? width;
  final double? height;

  final double? marginHorizontal;
  final Function() onTap;

  final TextStyle? textStyle;
  final RoundedLoadingButtonController? controller;
  final bool isDisable;

  CustomUniversalButton({
    required this.title,
    required this.onTap,
    this.semanticLabel,
    this.controller,
    this.width,
    this.height,
    this.textStyle,
    this.marginHorizontal,
    this.isDisable = false,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return controller == null
        ? GestureDetector(
            onTap: isDisable ? () {} : onTap,
            child: Container(
              decoration: BoxDecoration(
                color: isDisable ? Colors.grey : Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              width: double.maxFinite,
              height: height ?? 5.5.h,
              child: Center(
                child: Text(
                  title,
                  semanticsLabel: semanticLabel,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(
                          fontFamily: AppStyles.urbanist,
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1),
                ),
              ),
            ),
          )
        : RoundedLoadingButton(
            width: double.maxFinite,
            height: height ?? 5.5,
            onPressed: isDisable ? () {} : onTap,
            animateOnTap: false,
            borderRadius: 20.0,
            controller: controller!,
            color: isDisable ? Colors.grey : Colors.black,
            child: Text(
              title,
              semanticsLabel: semanticLabel,
              style: textStyle ??
                  TextStyle(
                      fontFamily: AppStyles.urbanist,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1),
            ),
          );
  }
}
