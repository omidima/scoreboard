import 'package:flutter/material.dart';

class Score extends StatefulWidget {
  const Score({Key? key}) : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                score++;
              });
            },
            icon: const Icon(Icons.add)),
        const SizedBox(
          height: 12,
        ),
        Text(
          score.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
        ),
        const SizedBox(
          height: 12,
        ),
        IconButton(
            onPressed: () {
              setState(() {
                score--;
              });
            },
            icon: const Icon(Icons.remove)),
      ],
    );
  }
}
