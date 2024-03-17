import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final _dockProgressPlugin = DockProgress();
  double _value = 0.0;
  String style = "ProgressBarStyle.bar";
  final TextEditingController _badgeInput = TextEditingController(text: "0");

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
                  Text("Progress: ${(_value * 100).toStringAsFixed(1)}%"),
                  Slider(
                    onChanged: (value) async {
                      _dockProgressPlugin.setProgress(value);
                      _value = await _dockProgressPlugin.getProgress() ?? 0;
                      setState(() {});
                    },
                    max: 1.0,
                    min: 0.0,
                    value: _value,
                  ),
                  TextField(
                    controller: _badgeInput,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _dockProgressPlugin.setBadgeValue(int.tryParse(value) ?? 0);
                      style = "Badge";
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: "Badge Value",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _dockProgressPlugin.resetProgress();
                      _value = await _dockProgressPlugin.getProgress() ?? 0;
                      setState(() {});
                    },
                    child: const Text("Reset Progress"),
                  ),
                  Text("Style: $style"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          _dockProgressPlugin.changeStyle(ProgressBarStyle.bar);
                          style = "ProgressBarStyle.bar";
                          setState(() {});
                        },
                        child: const Text("ProgressBarStyle.bar"),
                      ),
                      const SizedBox(height: 10,),
                      OutlinedButton(
                        onPressed: () {
                          _dockProgressPlugin.changeStyle(ProgressBarStyle.circle);
                          style = "ProgressBarStyle.circle";
                          setState(() {});
                        },
                        child: const Text("ProgressBarStyle.circle"),
                      ),
                      const SizedBox(height: 10,),
                      OutlinedButton(
                        onPressed: () {
                          _dockProgressPlugin.changeStyle(ProgressBarStyle.squircle);
                          style = "ProgressBarStyle.squircle";
                          setState(() {});
                        },
                        child: const Text("ProgressBarStyle.squircle"),
                      ),
                    ],
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
