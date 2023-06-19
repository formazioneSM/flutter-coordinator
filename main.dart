// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppCoordinator coordinator = AppCoordinator();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'System Coordinator',
      navigatorKey: coordinator.navigatorKey,
      home: Screen1(coordinator: coordinator),
    );
  }
}

abstract class CoordinableStatelessWidget<T> extends StatelessWidget {
  CoordinableStatelessWidget({super.key, required this.coordinator, this.dataModel});
  final AppCoordinator coordinator;
  T? dataModel;
}

class BaseCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void goToScreen(CoordinableStatelessWidget screen) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

// ESEMPIO DI UTILIZZO

class AppCoordinator extends BaseCoordinator {
  void goToScreen1() {
    super.goToScreen(Screen1(coordinator: this));
  }

  void goToScreen2() {
    super.goToScreen(Screen2(coordinator: this));
  }

  void goToScreen3(String dataModel) {
    super.goToScreen(Screen3(coordinator: this, dataModel: dataModel));
  }

  void goToScreen4() {
    super.goToScreen(Screen4(coordinator: this));
  }
}

class Screen1 extends CoordinableStatelessWidget {
  Screen1({super.key, required super.coordinator});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            coordinator.goToScreen2();
          },
          child: Text('Go to Screen 2'),
        ),
      ),
    );
  }
}

class Screen2 extends CoordinableStatelessWidget {
  Screen2({super.key, required super.coordinator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  coordinator.goToScreen4();
                },
                child: Text('Go to Screen 4'),
              ),
              ElevatedButton(
                onPressed: () {
                  coordinator.goToScreen3("Eccoci arrivati con il passaggio dei dati");
                },
                child: Text('Go to Screen 3'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Screen3 extends CoordinableStatelessWidget {
  Screen3({super.key, required super.coordinator, required super.dataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dataModel)),
      body: Center(
        child: Text(dataModel),
      ),
    );
  }
}

class Screen4 extends CoordinableStatelessWidget {
  Screen4({super.key, required super.coordinator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 4")),
      body: Center(
        child: Text("Screen 4"),
      ),
    );
  }
}
