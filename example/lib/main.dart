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
