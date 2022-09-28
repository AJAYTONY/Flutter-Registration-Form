import 'package:flutter/material.dart';
import 'package:neo_registration_page/screens/register/RegisterScreen.dart';
import 'package:neo_registration_page/utils/app_colors.dart';
import 'package:neo_registration_page/utils/enum.dart';
import 'package:neo_registration_page/utils/input_validator.dart';

class RegisterTextField extends StatefulWidget {
  const RegisterTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.onChanged,
    this.controller,
    this.validator,
    this.textInputType,
    this.maxLines,
    this.enabled,
    required this.inputType,
    this.leadingIcon,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final IconData? leadingIcon;
  final StringCallback? onChanged;
  final TextEditingController? controller;
  final ValidatorCallback? validator;
  final TextInputType? textInputType;
  final bool? enabled;
  final int? maxLines;
  final InputType inputType;

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField>
    with InputValidator {
  String? get validatorCallback => InputType.firstName == widget.inputType
      ? validateFirstName(widget.controller?.text)
      : widget.inputType == InputType.lastName
          ? validateLastName(widget.controller?.text)
          : widget.inputType == InputType.phoneNumber
              ? validateMobileNumber(widget.controller?.text)
              : widget.inputType == InputType.email
                  ? validateEmail(widget.controller?.text)
                  : widget.inputType == InputType.password
                      ? validatePassword(widget.controller?.text)
                      : null;

  @override
  void initState() {
    super.initState();

    if (widget.enabled == null) {
      widget.controller?.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //autofocus: true,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.textInputType,
      textInputAction: TextInputAction.next,
      //style: TextStyle(color: Colors.grey[400]!),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[400]!),
        labelStyle: TextStyle(color: Colors.grey[400]!),
        errorStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        focusedBorder: const OutlineInputBorder(
         // borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Colors.black, width: 2),
        ),
        border: const OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        enabledBorder: const OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        disabledBorder: const OutlineInputBorder(
         // borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black87),
        ),
        prefixIcon: Icon(widget.leadingIcon, color: AppColors.iconColor,),
        //suffixIcon: Icon(widget.leadingIcon, color: AppColors.iconColor,),

        // suffixIcon: (widget.enabled == false)
        //     ? null
        //     : widget.controller?.text == ""
        //         ? null
        //         : Container(
        //             margin: const EdgeInsets.all(8),
        //             decoration: BoxDecoration(
        //               color: (validatorCallback == null)
        //                   ? Colors.green[50]
        //                   : Colors.red[50],
        //               borderRadius: BorderRadius.circular(5),
        //             ),
        //             child: Icon(
        //               (validatorCallback == null) ? Icons.check : Icons.cancel,
        //               size: 16,
        //               color: (validatorCallback == null)
        //                   ? Colors.green[400]
        //                   : Colors.red[400],
        //             ),
        //           ),
      ),
    );
  }
}
