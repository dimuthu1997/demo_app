import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.obscureText = false,
      this.disableTitle = false,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon = const Icon(Icons.send),
      this.readOnly = false,
      this.onEditCompleted,
      this.keyboardType = TextInputType.text,
      this.title = "",
      this.suffixIconFunction,
      this.isSuffix = false,
      this.isError = false})
      : super(key: key);

  final TextEditingController controller;
  final String? title;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool disableTitle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final VoidCallback? onEditCompleted;
  final VoidCallback? suffixIconFunction;
  final bool? isSuffix;
  final bool? isError;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hidePassword = true;
  int textCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        !widget.disableTitle
            ? Text(
                widget.title!,
                style: Theme.of(context).textTheme.labelLarge,
              )
            : const SizedBox(),
        SizedBox(height: !widget.disableTitle ? 8 : 0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: widget.isError! ? Colors.red : Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.13),
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscureText && hidePassword,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: widget.keyboardType,
            onTap: widget.onTap,
            style: Theme.of(context).textTheme.bodyMedium,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              // counterText: '',
              fillColor: Theme.of(context).colorScheme.surface,
              filled: true,
              hintText: widget.hintText,
              isDense: true,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none),
              suffixIcon: widget.obscureText
                  ? InkWell(
                      onTap: widget.isError!
                          ? null
                          : () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                      radius: 4,
                      child: widget.isError!
                          ? const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 24,
                            )
                          : Icon(
                              hidePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 24,
                              color: Colors.black,
                            ),
                    )
                  : widget.isError!
                      ? const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 24,
                        )
                      : widget.isSuffix!
                          ? InkWell(
                              onTap: () => widget.suffixIconFunction,
                              radius: 4,
                              child: widget.suffixIcon,
                            )
                          : null,
              prefixIcon: widget.prefixIcon,
            ),
            onEditingComplete: widget.onEditCompleted,
          ),
        ),
      ],
    );
  }
}
