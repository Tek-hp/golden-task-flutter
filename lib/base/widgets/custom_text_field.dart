import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final bool obscureText;
  final String labelText;
  final TextEditingController textController;
  final bool isNumeric;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.obscureText = false,
    required this.labelText,
    required this.textController,
    this.isNumeric = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? hidePassword;
  @override
  Widget build(BuildContext context) {
    hidePassword = hidePassword ?? widget.obscureText;
    return TextFormField(
      controller: widget.textController,
      validator: widget.validator,
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      obscureText: hidePassword!,
      textCapitalization: TextCapitalization.sentences,
      obscuringCharacter: '●',
      keyboardType: widget.isNumeric ? TextInputType.number : null,
      inputFormatters: widget.isNumeric
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      style: TextStyle(
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.labelText,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  hidePassword!
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword!;
                  });
                },
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        labelStyle: const TextStyle(
          fontSize: 18.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
      ),
    );
  }
}
