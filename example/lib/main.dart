import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_dock_progress/macos_dock_progress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _progressValue = 0.0;
  String style = "ProgressBarStyle.bar";
  final TextEditingController _badgeInput = TextEditingController(text: "0");
  final TextEditingController _radiusInput = TextEditingController(text: "55");
  double _alphaValue = CupertinoColors.systemBlue.alpha / 255;
  double _redValue = CupertinoColors.systemBlue.red / 255;
  double _greenValue = CupertinoColors.systemBlue.green / 255;
  double _blueValue = CupertinoColors.systemBlue.blue / 255;

  Color _getColor() => Color.fromARGB(
      (_alphaValue * 255).round(),
      (_redValue * 255).round(),
      (_greenValue * 255).round(),
      (_blueValue * 255).round());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dock Progress Bar Example'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                        "Progress: ${(_progressValue * 100).toStringAsFixed(1)}%"),
                    Slider(
                      onChanged: (value) async {
                        await DockProgress.setProgress(value);
                        _progressValue = await DockProgress.getProgress() ?? 0;
                        setState(() {});
                      },
                      max: 1.0,
                      min: 0.0,
                      value: _progressValue,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await DockProgress.resetProgress();
                        setState(() {
                          _progressValue = 0;
                        });
                      },
                      child: const Text("Reset Progress"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Color"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Text("Alpha: "),
                        ),
                        Expanded(
                          child: Slider(
                            onChanged: (value) async {
                              setState(() {
                                _alphaValue = value;
                              });
                            },
                            max: 1.0,
                            min: 0.0,
                            value: _alphaValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Text("Red: "),
                        ),
                        Expanded(
                          child: Slider(
                            onChanged: (value) async {
                              setState(() {
                                _redValue = value;
                              });
                            },
                            max: 1.0,
                            min: 0.0,
                            value: _redValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Text("Green: "),
                        ),
                        Expanded(
                          child: Slider(
                            onChanged: (value) async {
                              setState(() {
                                _greenValue = value;
                              });
                            },
                            max: 1.0,
                            min: 0.0,
                            value: _greenValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Text("Blue: "),
                        ),
                        Expanded(
                          child: Slider(
                            onChanged: (value) async {
                              setState(() {
                                _blueValue = value;
                              });
                            },
                            max: 1.0,
                            min: 0.0,
                            value: _blueValue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Style: $style"),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        DockProgress.changeStyle(ProgressBarStyle.bar());
                        style = "ProgressBarStyle.bar";
                        setState(() {});
                      },
                      child: const Text("ProgressBarStyle.bar"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        DockProgress.changeStyle(
                            ProgressBarStyle.squircle(color: _getColor()));
                        style = "ProgressBarStyle.squircle";
                        setState(() {});
                      },
                      child: const Text("ProgressBarStyle.squircle"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            style = "ProgressBarStyle.circle";
                            DockProgress.changeStyle(ProgressBarStyle.circle(
                                color: _getColor(),
                                radius:
                                    double.tryParse(_radiusInput.text) ?? 0));
                            setState(() {});
                          },
                          child: const Text("ProgressBarStyle.circle"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _radiusInput,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              DockProgress.changeStyle(ProgressBarStyle.circle(
                                  color: _getColor(),
                                  radius: double.tryParse(value) ?? 0));
                              style = "ProgressBarStyle.circle";
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              label: Text("Radius"),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            style = "ProgressBarStyle.badge";
                            DockProgress.changeStyle(ProgressBarStyle.badge(
                                int.tryParse(_badgeInput.text) ?? 0,
                                color: _getColor()));
                            setState(() {});
                          },
                          child: const Text("ProgressBarStyle.badge"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _badgeInput,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              DockProgress.changeStyle(ProgressBarStyle.badge(
                                  int.tryParse(value) ?? 0,
                                  color: _getColor()));
                              style = "ProgressBarStyle.badge";
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              label: Text("Badge Value"),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
