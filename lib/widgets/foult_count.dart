import 'package:flutter/material.dart';

class FoultCount extends StatefulWidget {
  const FoultCount({Key? key}) : super(key: key);

  @override
  State<FoultCount> createState() => _FoultCountState();
}

class _FoultCountState extends State<FoultCount> {
  int score = 0;
  List<Widget> items = [];

  _inc() {
    items.add(const Icon(
      Icons.do_not_disturb_on_total_silence_sharp,
      color: Colors.red,
      size: 42,
    ));
    setState(() {});
  }

  _remove() {
    items.removeAt(0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "تعداد خطاها",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: List.generate(items.length, (index) => items[index]),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  _inc();
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  _remove();
                },
                icon: const Icon(Icons.remove)),
          ],
        )
      ],
    );
  }
}
