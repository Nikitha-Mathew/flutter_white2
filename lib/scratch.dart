import 'package:flutter/material.dart';

// for the features of the scratch card
class ScratchCard extends StatefulWidget {
  final Widget child;
  final Function onScratch;

  ScratchCard({required this.child, required this.onScratch});

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(renderBox.globalToLocal(details.globalPosition));
          widget.onScratch();
        });
      },
      onPanEnd: (details) {
        points.add(null);
      },
      child: CustomPaint(
        painter: ScratchCardPainter(points),
        child: widget.child,
      ),
    );
  }
}

class ScratchCardPainter extends CustomPainter {
  final List<Offset?> points;
  ScratchCardPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ScratchCardPainter oldDelegate) => true;
}
