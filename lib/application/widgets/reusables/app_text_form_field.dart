import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.textInputAction,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
    super.key,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: autofocus ?? false,
        validator: validator,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}

class AppDropdownButton extends StatelessWidget {
  const AppDropdownButton(
      {required this.text,
      required this.onChange,
      required this.itemsList,
      required this.itemSelected,
      super.key});

  final List<DropdownMenuItem<int>> itemsList;
  final int itemSelected;
  final void Function(int? value) onChange;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        hint: Text(text),
        items: itemsList,
        value: itemSelected,
        onChanged: onChange,
        isExpanded: true,
      ),
    );
  }
}
