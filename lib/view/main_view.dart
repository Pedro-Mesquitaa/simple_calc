import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_calc/controller/operation_controller.dart';
import 'package:simple_calc/controller/theme_controller.dart';

class Mainview extends StatefulWidget {
  const Mainview({super.key});

  @override
  State<Mainview> createState() => _MainviewState();
}

class _MainviewState extends State<Mainview> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final operationController = context.watch<OperationController>();
    final themeController = context.watch<ThemeController>(); 

    final buttons = [
      '1',
      '2',
      '3',
      '+',
      '4',
      '5',
      '6',
      '-',
      '7',
      '8',
      '9',
      'x',
      '=',
      '0',
      'AC',
      '÷',
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => {
            Navigator.of(context).popAndPushNamed('/hist')
          }, icon: Icon(Icons.history)),
          IconButton(onPressed: themeController.selectTheme, icon: themeController.iconTheme)
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                style: TextStyle(fontSize: 35),
                controller: _textController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.+\-x/]'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 4 * 70 + 3 * 8,
                ), // 4 botões + 3 espaços
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: buttons.map((label) {
                    return SizedBox(
                      width: 70,
                      height: 70,
                      child: TextButton(
                        onPressed: label.isEmpty
                            ? null
                            : () {
                                if (label == 'AC') {
                                  _textController.clear();
                                } else if (label == '=') {
                                  final isValid = _formKey.currentState?.validate() ?? false;
                                  if (isValid) {
                                    final result = operationController.getResult(_textController.text);
                                    _textController.value = TextEditingValue(
                                      text: result,
                                      selection: TextSelection.collapsed(offset: result.length),
                                    );
                                  }
                                } else if (label == '÷') {
                                    final newText = '${_textController.text}/';
                                    _textController.value = TextEditingValue(
                                      text: newText,
                                      selection: TextSelection.collapsed(offset: newText.length),
                                    );
                                } 
                                else {
                                  if(operationController.verifyError()) {
                                    _textController.clear();
                                  }
                                  final newText = _textController.text + label;
                                  _textController.value = TextEditingValue(
                                    text: newText,
                                    selection: TextSelection.collapsed(offset: newText.length),
                                  );
                                }
                              },
                        child: Text(label, style: TextStyle(fontSize: 20),),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}