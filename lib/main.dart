// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  /// Comment or uncomment to run both examples
  runApp(
      WithBuilder()
      // WithPages()
  );
}

///Class to hold data for itembuilder in Withbuilder app.
class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

/// Example of LiquidSwipe with itemBuilder
class WithBuilder extends StatefulWidget {
  @override
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<WithBuilder> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> data = [
    ItemData(Colors.blue, "assets/1.jpeg", "Hi", "It's Me", "Sahdeep"),

    ItemData(Colors.deepPurpleAccent, "assets/2.jpeg", "Take a", "Look At",
        "Liquid Swipe"),
    ItemData(Colors.green, "assets/3.jpeg", "Liked?", "Fork!", "Give Star!"),
    ItemData(Colors.yellow, "assets/4.jpeg", "Can be", "Used for",
        "Onboarding design"),
    ItemData(
        Colors.pink, "assets/5.jpeg", "Example", "of a page", "with Gesture"),
    ItemData(Colors.red, "assets/6.jpeg", "Do", "try it", "Thank you"),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                  color: data[index].color,
                    image: DecorationImage(
                      image: AssetImage(data[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(index != 4 ? 24.0 : 0),
                      ),
                      index == 4
                          ? const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 70.0),
                              child: ExampleSlider(),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: const Icon(Icons.arrow_back_ios, color: Colors.white,),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              // enableSideReveal: true,
              preferDragFromRevealedArea: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true,
            ),



            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.01),
                      foregroundColor: Colors.white),
                  child: const Text("Skip to End"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page: liquidController.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.01),
                      foregroundColor: Colors.white
                      ),
                  child: const Text("Next"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}


class ExampleSlider extends StatefulWidget {
  const ExampleSlider({Key? key}) : super(key: key);

  @override
  State<ExampleSlider> createState() => _ExampleSliderState();
}

class _ExampleSliderState extends State<ExampleSlider> {
  double sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: sliderVal,
        activeColor: Colors.white,
        inactiveColor: Colors.red,
        onChanged: (val) {
          setState(() {
            sliderVal = val;
          });
        });
  }
}