import 'dart:async';

import 'package:flutter/material.dart';

class Cornometer extends StatefulWidget {
  const Cornometer({Key? key}) : super(key: key);

  @override
  State<Cornometer> createState() => _CornometerState();
}

class _CornometerState extends State<Cornometer> {
  int min = 0;
  int sec = 0;
  Timer? time;

  _reset() {
    time?.cancel();
    min = 0;
    sec = 0;
    setState(() {});
  }

  _pause() {
    time?.cancel();
  }

  _start() {
    if (time == null || !time!.isActive) {
      time = Timer.periodic(const Duration(seconds: 1), (timer) {
        _handleTime();
      });
    }
  }

  _handleTime() {
    sec++;
    if (sec == 60) {
      min++;
      sec = 0;
    }
    setState(() {});
  }

  _formatTime(int time) {
    if (time < 10) {
      return "0$time";
    }
    return time;
  }

  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${_formatTime(min)}:${_formatTime(sec)}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 120),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => _pause(), icon: const Icon(Icons.pause)),
            const SizedBox(
              width: 12,
            ),
            IconButton(
                onPressed: () => _start(),
                icon: const Icon(Icons.play_arrow)),
            const SizedBox(
              width: 12,
            ),
            IconButton(
                onPressed: () => _reset(), icon: const Icon(Icons.stop)),
          ],
        )
      ],
    );
  }
}
