import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconButton? passicon;
  final TextInputType textInputType;
  const TextFieldInput(
      {
    Key? key,
    required this.textEditingController,
    this.isPass = false,
        this.passicon,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
       // focusedBorder: inputBorder,
        //enabledBorder: inputBorder,
        filled: true,
       // suffixIcon: IconButton(onPressed: (){}, icon: passicon!),
        contentPadding: const EdgeInsets.all(8),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),

      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
