import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ci cd test
class ColorFromHex {
  final int alpha;
  final int red;
  final int green;
  final int blue;
  final String flutterHexColor;
  final Color flutterColor;
  ColorFromHex({
    required this.flutterColor,
    required this.flutterHexColor,
    required this.alpha,
    required this.red,
    required this.green,
    required this.blue,
  });
}

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _textEditingController = TextEditingController();

  ColorFromHex? _colorFromHex;

  ColorFromHex _colorFromHexString({required String hexString}) {
    final pureHexString = hexString.replaceFirst('#', '');

    if (pureHexString.length == 3) {
      return ColorFromHex(
        alpha: 255,
        red: int.parse('${pureHexString[0]}${pureHexString[0]}', radix: 16),
        green: int.parse('${pureHexString[1]}${pureHexString[1]}', radix: 16),
        blue: int.parse('${pureHexString[2]}${pureHexString[2]}', radix: 16),
        flutterHexColor:
            '0xff${pureHexString[0]}${pureHexString[0]}${pureHexString[1]}${pureHexString[1]}${pureHexString[2]}${pureHexString[2]}',
        flutterColor: Color(
          int.parse(
            '0xff${pureHexString[0]}${pureHexString[0]}${pureHexString[1]}${pureHexString[1]}${pureHexString[2]}${pureHexString[2]}',
          ),
        ),
      );
    }
    if (pureHexString.length == 6) {
      return ColorFromHex(
        alpha: 255,
        red: int.parse('${pureHexString[0]}${pureHexString[1]}', radix: 16),
        green: int.parse('${pureHexString[2]}${pureHexString[3]}', radix: 16),
        blue: int.parse('${pureHexString[4]}${pureHexString[5]}', radix: 16),
        flutterHexColor:
            '0xff${pureHexString[0]}${pureHexString[1]}${pureHexString[2]}${pureHexString[3]}${pureHexString[4]}${pureHexString[5]}',
        flutterColor: Color(
          int.parse(
            '0xff${pureHexString[0]}${pureHexString[1]}${pureHexString[2]}${pureHexString[3]}${pureHexString[4]}${pureHexString[5]}',
          ),
        ),
      );
    }
    return ColorFromHex(
      alpha: int.parse('${pureHexString[0]}${pureHexString[1]}', radix: 16),
      red: int.parse('${pureHexString[2]}${pureHexString[3]}', radix: 16),
      green: int.parse('${pureHexString[4]}${pureHexString[5]}', radix: 16),
      blue: int.parse('${pureHexString[6]}${pureHexString[7]}', radix: 16),
      flutterHexColor:
          '0x${pureHexString[0]}${pureHexString[1]}${pureHexString[2]}${pureHexString[3]}${pureHexString[4]}${pureHexString[5]}${pureHexString[6]}${pureHexString[7]}',
      flutterColor: Color(
        int.parse(
          '0x${pureHexString[0]}${pureHexString[1]}${pureHexString[2]}${pureHexString[3]}${pureHexString[4]}${pureHexString[5]}${pureHexString[6]}${pureHexString[7]}',
        ),
      ),
    );
  }

  bool _isValidHexColor(String hex) {
    final RegExp hexColorRegExp = RegExp(
      '^#?(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\$',
    );
    return hexColorRegExp.hasMatch(hex);
  }

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {
      final String hexString = _textEditingController.text;

      if (_isValidHexColor(hexString)) {
        setState(() {
          _colorFromHex = _colorFromHexString(hexString: hexString);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hex to Flutter',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter hex color code from Figma(e.g., #F5F5F5)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Builder(
                builder: (context) {
                  if (_colorFromHex != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SelectableText(
                              'Color.fromARGB(${_colorFromHex!.alpha}, ${_colorFromHex!.red}, ${_colorFromHex!.green}, ${_colorFromHex!.blue})',
                            ),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                    text:
                                        'Color.fromARGB(${_colorFromHex!.alpha}, ${_colorFromHex!.red}, ${_colorFromHex!.green}, ${_colorFromHex!.blue})',
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy_outlined),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            SelectableText(
                              'Color.fromRGBO(${_colorFromHex!.red}, ${_colorFromHex!.green}, ${_colorFromHex!.blue}, ${_colorFromHex!.alpha})',
                            ),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                    text:
                                        'Color.fromRGBO(${_colorFromHex!.red}, ${_colorFromHex!.green}, ${_colorFromHex!.blue}, ${_colorFromHex!.alpha})',
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy_outlined),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            SelectableText(
                              'Color(${_colorFromHex!.flutterHexColor})',
                            ),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                    text:
                                        'Color(${_colorFromHex!.flutterHexColor})',
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy_outlined),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            SelectableText(
                              'Color.from(alpha: ${_colorFromHex!.flutterColor.a.toStringAsFixed(8)}, red: ${_colorFromHex!.flutterColor.r.toStringAsFixed(8)}, green: ${_colorFromHex!.flutterColor.g.toStringAsFixed(8)}, blue: ${_colorFromHex!.flutterColor.b.toStringAsFixed(8)})',
                            ),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(
                                    text:
                                        'Color.from(alpha: ${_colorFromHex!.flutterColor.a.toStringAsFixed(8)}, red: ${_colorFromHex!.flutterColor.r.toStringAsFixed(8)}, green: ${_colorFromHex!.flutterColor.g.toStringAsFixed(8)}, blue: ${_colorFromHex!.flutterColor.b.toStringAsFixed(8)})',
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy_outlined),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: _colorFromHex!.flutterColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
