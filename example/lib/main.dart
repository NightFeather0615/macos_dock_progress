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
                      DockProgress.setProgress(value);
                      _value = await DockProgress.getProgress() ?? 0;
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
                      DockProgress.setBadgeValue(int.tryParse(value) ?? 0);
                      style = "Badge";
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: "Badge Value",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DockProgress.resetProgress();
                      _value = await DockProgress.getProgress() ?? 0;
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
                          DockProgress.changeStyle(ProgressBarStyle.bar);
                          style = "ProgressBarStyle.bar";
                          setState(() {});
                        },
                        child: const Text("ProgressBarStyle.bar"),
                      ),
                      const SizedBox(height: 10,),
                      OutlinedButton(
                        onPressed: () {
                          DockProgress.changeStyle(ProgressBarStyle.circle);
                          style = "ProgressBarStyle.circle";
                          setState(() {});
                        },
                        child: const Text("ProgressBarStyle.circle"),
                      ),
                      const SizedBox(height: 10,),
                      OutlinedButton(
                        onPressed: () {
                          DockProgress.changeStyle(ProgressBarStyle.squircle);
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
