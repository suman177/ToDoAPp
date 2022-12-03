import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {Key? key,
      required this.textEditingController,
      required this.formKey,
      required this.hintText,
      this.textInputType})
      : super(key: key);
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;
  final String hintText;
  final TextInputType? textInputType;
  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: TextFormField(
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(hintText: widget.hintText),
        ));
  }
}

class LongTextFormFieldWidget extends StatefulWidget {
  const LongTextFormFieldWidget(
      {Key? key,
      required this.textEditingController,
      required this.formKey,
      required this.hintText,
      this.textInputType})
      : super(key: key);
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;
  final String hintText;
  final TextInputType? textInputType;
  @override
  State<LongTextFormFieldWidget> createState() =>
      _LongTextFormFieldWidgetState();
}

class _LongTextFormFieldWidgetState extends State<LongTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: SizedBox(
          height: 200,
          child: TextFormField(
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
        ));
  }
}
