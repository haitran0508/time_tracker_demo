import 'package:flutter/material.dart';

class TimeBage extends StatefulWidget {
  const TimeBage({
    super.key,
    required this.size,
    required this.time,
    this.color = Colors.grey,
  });

  final double size;
  final String time;
  final Color color;

  @override
  State<TimeBage> createState() => _TimeBageState();
}

class _TimeBageState extends State<TimeBage> {
  late String _time;

  @override
  void initState() {
    super.initState();
    _time = widget.time;
  }

  @override
  void didUpdateWidget(TimeBage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _time = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget.size / 2)),
        border: Border.fromBorderSide(
          BorderSide(color: widget.color, width: 10),
        ),
      ),
      alignment: Alignment.center,
      height: widget.size,
      width: widget.size,
      child: Text(
        _time,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      ),
    );
  }
}
