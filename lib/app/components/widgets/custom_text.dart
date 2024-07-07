import 'package:adventure/app/components/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final bool? center;
  final bool? alignRight;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? height;
  final String? fontFamily;
  final double? letterSpacing;
  const CustomText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.overflow,
      this.center,
      this.alignRight,
      this.maxLines,
      this.fontStyle,
      this.height,
      this.fontFamily,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.visible,
      textAlign: center == null
          ? alignRight != null
              ? TextAlign.right
              : TextAlign.left
          : center!
              ? TextAlign.center
              : TextAlign.left,
      maxLines: maxLines,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize:fontSize??14.sp,
          fontFamily: fontFamily ?? AppStyles.urbanist,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height,
          letterSpacing: letterSpacing),
    );
  }
}
