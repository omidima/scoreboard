import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoreboard/widgets/cornometer.dart';
import 'package:scoreboard/widgets/foult_count.dart';
import 'package:scoreboard/widgets/score.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode _focusNode = FocusNode();
  _viewDesktop() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Score(),
              SizedBox(
                height: 100,
              ),
              FittedBox(child: FoultCount()),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Cornometer(controller: _cornoController),
            const SizedBox(
              height: 50,
            ),
            if (team1 != null)
              Text(
                "$team1 - $team2",
                style: const TextStyle(fontSize: 24),
              )
            else
              MaterialButton(
                  child: const Text("ثبت تیم‌ها"),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              child: Column(
                                children: [
                                  TextField(
                                    onChanged: (value) => team1 = value,
                                    decoration:
                                        InputDecoration(label: Text("تیم ۱")),
                                  ),
                                  TextField(
                                    onChanged: (value) => team2 = value,
                                    decoration:
                                        InputDecoration(label: Text("تیم 2")),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    child: Text("ثبت"),
                                  )
                                ],
                              ),
                            ));
                  })
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Score(),
              SizedBox(
                height: 100,
              ),
              FittedBox(child: FoultCount()),
            ],
          ),
        )
      ],
    );
  }

  CornoController _cornoController = CornoController();

  _viewMobile() {
    return Center(
      child: Cornometer(controller: _cornoController),
    );
  }

  String? team1, team2;

  @override
  void initState() {
    window.onKeyDown.listen((event) {
      if (_cornoController.state == "play" && !(event.repeat ?? false)) {
        _cornoController.pause();
      }else if (_cornoController.state == "pause") {
        _cornoController.play();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return _viewMobile();
          }
          return _viewDesktop();
        },
      ),
    );
  }
}
