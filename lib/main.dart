import 'package:flutter/material.dart';
import 'package:statefulapp_3_inheritednotifier/slider_data.dart';

void main() async {
  runApp(
    MaterialApp(
      title: 'Inherited Notifier',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
  );
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required SliderData sliderData,
    required Widget child,
  }) : super(
          key: key,
          notifier: sliderData,
          child: child,
        );

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
          ?.notifier
          ?.value ??
      0.0;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Slider(
                    value: SliderInheritedNotifier.of(context),
                    onChanged: (value) {
                      sliderData.value = value;
                    }),
                Row(
                  children: [
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        height: 200,
                        color: Colors.amber.shade900,
                      ),
                    ),
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        height: 200,
                        color: Colors.teal.shade900,
                      ),
                    )
                  ].expandEqualy().toList(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

extension ExpandEqualy on Iterable<Widget> {
  Iterable<Widget> expandEqualy() => map((w) => Expanded(
        child: w,
      ));
}
