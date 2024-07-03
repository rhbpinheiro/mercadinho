// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  // ignore: use_super_parameters
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.prefix,
    this.isSecret = false,
    this.readOnly = false,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.formfieldkey,
  }) : super(key: key);
  final String labelText;
  final Widget prefix;
  final bool isSecret;
  final bool? readOnly;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final GlobalKey<FormFieldState>? formfieldkey;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = false;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: TextFormField(
        key: widget.formfieldkey,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly!,
        obscureText: isObscureText,
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  icon: Icon(
                    isObscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          labelText: widget.labelText,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
