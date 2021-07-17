import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController vibrationController;
  late Animation<double> turns;
  bool forward = true;

  @override
  void initState() {
    super.initState();
    vibrationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    turns = Tween<double>(begin: 0, end: 0.1)
        .chain(TweenSequence([
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: 0, end: 0.1), weight: 1),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: 0.1, end: -0.1), weight: 2),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: -0.1, end: 0), weight: 1),
        ]))
        .animate(
            CurvedAnimation(parent: vibrationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    super.dispose();
    vibrationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Game Console',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Color(0xFFEEEEEE)),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF0F044C),
        ),
        backgroundColor: const Color(0xFF0F044C),
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: RotationTransition(
                turns: turns,
                child: const GamePad(
                  size: 300,
                ),
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Container(
                alignment: Alignment.center,
                child: const Vibration(
                  size: 300,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class Vibration extends StatefulWidget {
  final double size;
  const Vibration({Key? key, this.size = 400}) : super(key: key);

  @override
  _VibrationState createState() => _VibrationState();
}

class _VibrationState extends State<Vibration> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F044C),
      width: 400,
      height: 400,
      child: CustomPaint(
        painter: VibrationPattern(widget.size),
      ),
    );
  }
}

class VibrationPattern extends CustomPainter {
  final double size;
  double controllerWidth = 0.0;
  double controllerHeight = 0.0;

  VibrationPattern(this.size) {
    controllerWidth = 0.7 * size;
    controllerHeight = 0.3 * size;
  }

  void vibrationPattern(Canvas canvas, Size size, c, radius) {
    final vibrationPatternBrush = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = controllerHeight * controllerWidth * 0.00055
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: c, radius: radius / 1.35), pi / 6,
        -pi / 3, false, vibrationPatternBrush);
    canvas.drawArc(Rect.fromCircle(center: c, radius: radius / 1.05), pi / 5,
        -2 * pi / 5, false, vibrationPatternBrush);
    canvas.drawArc(Rect.fromCircle(center: c, radius: radius / 1.35),
        5 * pi / 6, pi / 3, false, vibrationPatternBrush);
    canvas.drawArc(Rect.fromCircle(center: c, radius: radius / 1.05),
        4 * pi / 5, 2 * pi / 5, false, vibrationPatternBrush);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width / 2;
    final y = size.height / 2;
    final radius = min(x, y);
    final c = Offset(x, y);
    vibrationPattern(canvas, size, c, radius);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GamePad extends StatefulWidget {
  final double size;
  const GamePad({Key? key, this.size = 400}) : super(key: key);
  @override
  _GamePadState createState() => _GamePadState();
}

class _GamePadState extends State<GamePad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F044C),
      width: 400,
      height: 400,
      child: CustomPaint(
        painter: GamePadPainter(widget.size),
      ),
    );
  }
}

class GamePadPainter extends CustomPainter {
  final double size;
  double controllerWidth = 0.0;
  double controllerHeight = 0.0;

  GamePadPainter(this.size) {
    controllerWidth = 0.7 * size;
    controllerHeight = 0.3 * size;
  }

  void gamePadBody(Canvas canvas, Size size, radius, c) {
    final gamePadBodyBrush = Paint()..color = const Color(0xFF787A91);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: c, width: controllerWidth, height: controllerHeight),
            Radius.circular(radius / 10)),
        gamePadBodyBrush);
  }

  void selectControllers(Canvas canvas, Size size, x, y) {
    final selectControllerBrush = Paint()..color = const Color(0xFFEEEEEE);
    final selectControllerSize = controllerHeight * 0.4;
    final selectControllerOffset = Offset(x - controllerWidth * 0.27, y);
    canvas.drawRect(
        Rect.fromCenter(
            center: selectControllerOffset,
            width: 0.1 * selectControllerSize,
            height: selectControllerSize),
        selectControllerBrush);
    canvas.drawRect(
        Rect.fromCenter(
            center: selectControllerOffset,
            height: 0.1 * selectControllerSize,
            width: selectControllerSize),
        selectControllerBrush);
  }

  void functionControllers(Canvas canvas, Size size, x, y) {
    final functionControllerBrush = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..strokeWidth = controllerHeight * controllerWidth * 0.00035
      ..strokeCap = StrokeCap.round;
    final pointOffsets = [
      Offset(x + controllerWidth * 0.27, y + 0.27 * (controllerHeight / 2)),
      Offset(x + controllerWidth * 0.27, y - 0.27 * (controllerHeight / 2)),
      Offset(x + controllerWidth * 0.27 + 0.27 * (controllerHeight / 2), y),
      Offset(x + controllerWidth * 0.27 - 0.27 * (controllerHeight / 2), y),
    ];
    canvas.drawPoints(PointMode.points, pointOffsets, functionControllerBrush);
  }

  void movementControllers(Canvas canvas, Size size, x, y) {
    final functionControllerBrush = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..strokeWidth = controllerHeight * controllerWidth * 0.00055
      ..strokeCap = StrokeCap.round;
    final pointOffsets = [
      Offset(x - controllerHeight * 0.2, y + controllerHeight * 0.2),
      Offset(x + controllerHeight * 0.2, y + controllerHeight * 0.2),
    ];
    canvas.drawPoints(PointMode.points, pointOffsets, functionControllerBrush);
  }

  void wire(Canvas canvas, Size size, x, y) {
    Path path = Path();
    path.moveTo(x, y - controllerHeight / 2);
    path.lineTo(x, y - controllerHeight);
    path.close();
    final wireBrush = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..strokeWidth = controllerHeight * controllerWidth * 0.0002
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, wireBrush);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width / 2;
    final y = size.height / 2;
    final radius = min(x, y);
    final c = Offset(x, y);
    gamePadBody(canvas, size, radius, c);
    selectControllers(canvas, size, x, y);
    functionControllers(canvas, size, x, y);
    movementControllers(canvas, size, x, y);
    wire(canvas, size, x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
