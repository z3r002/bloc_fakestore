import 'package:bloc_pet/core/presentation/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  TextInput({
    Key? key,
    this.placeholder,
    this.initValue,
    this.obscureText = false,
    this.fillColor,
    this.textError,
    this.maxLines = 1,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.submit,
    this.isNumbers = false,
    this.borderRadius = 16,
    this.isError = false,
    this.inputFormatters,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool isNumbers;
  final String? placeholder;
  final String? initValue;
  final Function(String) onChanged;
  final String? textError;
  final bool obscureText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? padding;
  final Function? submit;
  final Color? fillColor;
  final double borderRadius;
  final bool isError;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  int _currentMaxLines = 1;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initValue ?? '', );
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
  void _handleTextChange() {
    final text = _controller.text;
    final lineCount = '\n'.allMatches(text).length + 1;

    // Если количество строк превышает максимальное значение, увеличиваем maxLines
    if (lineCount != _currentMaxLines && lineCount <= 5) {
      setState(() {
        _currentMaxLines = lineCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        color: widget.isError ? UIColors.cF44336 : UIColors.cD8D1E1, // Красный при ошибке
        width: 0.5,
      ),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        color:widget.isError ? UIColors.cF44336: UIColors.c9B6CE6, // Цвет рамки при активном состоянии
        width: 1.0, // Можно настроить ширину
      ),
    );
    return TextField(
      style: TextStyle(color: UIColors.c150830, fontWeight: FontWeight.w400 ),
      onChanged: (text) => widget.onChanged(text),
      keyboardType: widget.isNumbers?TextInputType.number:  TextInputType.multiline, // Разрешаем многострочный ввод

      onSubmitted: (e) => {
        if (widget.submit != null) widget.submit!(),
      },
      inputFormatters: widget.inputFormatters,
      cursorColor: UIColors.black,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines ?? null, // Позволяем расширяться
      expands: false, // Можно установить на true, если нужно чтобы занимало все доступное пространство
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon:Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: widget.suffixIcon,
        ),
        suffixIconConstraints: widget.suffixIcon == null ?  BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ): null,
        contentPadding: EdgeInsets.symmetric(vertical: widget.padding ?? 0, horizontal: 12),
        filled: true,
        fillColor: widget.fillColor ?? UIColors.white,
        hintText: widget.placeholder,

        labelStyle:  TextStyle(color: UIColors.white, fontSize: 20, ),
        hintStyle: TextStyle(color: UIColors.c8B81A6, fontSize: 16, fontWeight: FontWeight.w400),
        border: border,
        focusedBorder: focusedBorder,
        disabledBorder: border,
        enabledBorder: border,
      ),
    );
  }
}
