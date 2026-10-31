import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.hinText,
    this.prefixIcon,
    this.obscureText,
    this.readOnly = false,
    this.maxLines = 1,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hinText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool readOnly;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<CustomTextField> {
  bool? isHide;

  @override
  void initState() {
    isHide = widget.obscureText;
    super.initState();
  }

  void changeIsHide() {
    isHide = !(isHide ?? false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHide ?? false,
      controller: widget.controller,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: widget.readOnly ? Colors.grey.shade700 : Colors.black,
      ),
      textInputAction: widget.maxLines > 1
          ? TextInputAction.newline
          : TextInputAction.next,
      validator: widget.validator,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        helperText: '',
        helperStyle: TextStyle(fontSize: 12),
        hintText: widget.hinText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: () {
                  changeIsHide();
                },
                child: isHide ?? false
                    ? Icon(
                        Icons.visibility_off_outlined,
                        size: 24,
                        color: Colors.grey.shade800,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        size: 24,
                        color: Colors.grey.shade800,
                      ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        prefixIcon: widget.prefixIcon,
        fillColor: AppColors.fieldColor,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
