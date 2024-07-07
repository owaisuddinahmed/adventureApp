// ignore_for_file: constant_identifier_names

import 'package:adventure/app/components/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.labelText,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.onTap,
      this.onChanged,
      this.limit,
      this.counterText = false,
      this.readOnly = false,
      this.maxLimit,
      this.isRequired = true,
      this.validator});

  final FloatingEditTextShape? shape;

  final FloatingEditTextPadding? padding;

  final FloatingEditTextVariant? variant;

  final FloatingEditTextFontStyle? fontStyle;

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final bool? isObscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final int? maxLimit;

  final String? labelText;

  final String? hintText;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final int? limit;

  final BoxConstraints? suffixConstraints;

  final FormFieldValidator<String>? validator;

  final void Function()? onTap;

  final void Function(String)? onChanged;

  final bool? counterText;

  final bool readOnly;

  final bool isRequired;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int lengthCounter = 0;
  int maxLimit = 0;
  String text = "";

  @override
  void initState() {
    if (widget.limit != null) {
      maxLimit = widget.limit!;
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: _buildFloatingEditTextWidget(),
          )
        : _buildFloatingEditTextWidget();
  }

  _buildFloatingEditTextWidget() {
    return Container(
      width: widget.width ?? double.maxFinite,
      margin: widget.margin,
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus!,
        cursorColor: Colors.black,
        style: _setFontStyle(),
        readOnly: widget.readOnly,
        maxLength: widget.maxLimit ?? /* Constants.MAX_INPUT_LIMIT*/ 50,
        obscureText: widget.isObscureText!,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines ?? 1,
        decoration: _buildDecoration(),
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: (value) {},
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText ?? "",
      counterText: "",
      hintStyle: _setHintFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: widget.prefix,
      prefixIconConstraints: widget.prefixConstraints,
      suffixIcon: widget.suffix,
      suffixIconConstraints: widget.suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      alignLabelWithHint: true,
      isDense: true,
      contentPadding: _setPadding(),
      errorMaxLines: 2,
    );
  }

  _setHintFontStyle() {
    return TextStyle(
      color: Colors.grey,
      fontSize: 14.sp,
      fontFamily: AppStyles.urbanist,
      fontWeight: FontWeight.w400,
    );
  }

  _setFontStyle() {
    switch (widget.fontStyle) {
      case FloatingEditTextFontStyle.AgeoMedium14:
        return TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: AppStyles.urbanist,
          fontWeight: FontWeight.w400,
        );

      default:
        return TextStyle(
          color: Color(0xFF8A8A8E),
          fontSize: 14.sp,
          fontFamily: AppStyles.urbanist,
          fontWeight: FontWeight.w400,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (widget.shape) {
      case FloatingEditTextShape.RoundedBorder14:
        return BorderRadius.circular(
          10
        );
      default:
        return BorderRadius.circular(
        5
        );
    }
  }

  _setBorderStyle() {
    switch (widget.variant) {
      case FloatingEditTextVariant.OutlineGray300_1:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        );
      case FloatingEditTextVariant.None:
        return InputBorder.none;
      case FloatingEditTextVariant.FilledGrayF8:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0,
          ),
        );
      default:
        return UnderlineInputBorder();
    }
  }

  _setFillColor() {
    switch (widget.variant) {
      case FloatingEditTextVariant.FilledGrayF8:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  _setFilled() {
    switch (widget.variant) {
      case FloatingEditTextVariant.OutlineGray300_1:
        return false;
      case FloatingEditTextVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (widget.padding) {
      case FloatingEditTextPadding.PaddingTB16_1:
        return EdgeInsets.only(
          left: 6,
          top: 6,
          right: 6,
          bottom: 6,

        );
      default:
        return  EdgeInsets.only(
          left: 0,
          top: 14,
          right: 0,
          bottom: 14,
        );
    }
  }
}

enum FloatingEditTextShape {
  RoundedBorder5,
  RoundedBorder14,
}

enum FloatingEditTextPadding {
  PaddingTB16,
  PaddingTB16_1,
  Padding0,
}

enum FloatingEditTextVariant {
  None,
  OutlineGray300,
  OutlineGray300_1,
  FilledGrayF8,
}

enum FloatingEditTextFontStyle {
  AgeoRegular14,
  AgeoMedium14,
  AgeoRegular16,
}
