
# Position Animator

A Flutter package that allows you to animate the movement of a widget from its current position to the position of another widget on the screen. This package also provides the flexibility to customize the animation's behavior and appearance.

## Features

- Animate a widget from its current position to the position of another widget.
- Customize the animation curve and duration.
- Optionally resize the widget as it moves.
- Use a custom builder to define how the widget is animated.

<p align="center">
  <img src="https://github.com/user-attachments/assets/124dbdda-0488-4727-b994-d91688ba4c99" width="200"/>
  <img src="https://github.com/user-attachments/assets/e1a36093-cc17-4ef0-8a54-2ba93cef1705" width="200"/>
  <img src="https://github.com/user-attachments/assets/743f9a71-46ad-4e61-bedc-2d5c2df26550" width="200"/>
  <img src="https://github.com/user-attachments/assets/b4634bd1-0c75-4ea5-a775-d45384fe5105" width="200"/>
</p>

## Getting Started

### Installation

Add `position_animator` to your `pubspec.yaml` file:

```yaml
dependencies:
  position_animator: ^1.0.0
```

Then, run:

```bash
flutter pub get
```

### Usage

To use the `PositionAnimator`, wrap the widget you want to animate with a `PositionAnimatorWidget`, and provide a `GlobalKey` to both the widget to animate and the target widget.

```dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:position_animator/position_animator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey bottomBarKey = GlobalKey();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('AppBar'),
            actions: [
              Icon(
                Icons.shopping_cart_outlined,
                key: appBarKey,
              ),
              const SizedBox(width: 20),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: kToolbarHeight,
            child: AppBar(
              title: const Text('BottomBar'),
              actions: [
                Icon(
                  Icons.shopping_cart_outlined,
                  key: bottomBarKey,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          body: ListView.separated(
            itemCount: 20,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              final GlobalKey widgetKey = GlobalKey();
              return Row(
                children: [
                  PositionAnimatorWidget(
                    key: widgetKey,
                    child: SizedBox.square(
                      dimension: 100,
                      child: Card(
                        color:
                        Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(Icons.shopping_basket_outlined),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  ElevatedButton(
                    onPressed: () {
                      final animator = PositionAnimator(
                        targetWidgetKey: bottomBarKey,
                        widgetKey: widgetKey,
                        duration: const Duration(seconds: 3),
                        curve: Curves.elasticInOut,
                      );
                      animator.start(context);
                    },
                    child: const Text('Add'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      final animator = PositionAnimator(
                        targetWidgetKey: appBarKey,
                        widgetKey: widgetKey,
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear,
                      );
                      animator.start(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        );
      }),
    );
  }
}
```

### Parameters

- `targetWidgetKey`: The `GlobalKey` of the widget to which the animated widget should move.
- `widgetKey`: The `GlobalKey` of the widget that should be animated.
- `duration`: The duration of the animation.
- `curve`: The curve that defines the animation's easing.
- `childSizeFactor`: A factor by which the size of the child widget will decrease as it moves. The value must be greater than 0.
- `builder`: A builder function to customize the animated widget. It provides the context, animation, child widget, size, and target position.

### Example

The example above demonstrates how to animate a red box to the position of a blue box on the screen when the floating action button is pressed. The red box will also shrink in size as it moves.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
