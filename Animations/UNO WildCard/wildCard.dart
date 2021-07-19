import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  static const List<Widget> cards = [
    UnoWildCard(600.0, 'design1', key: Key('design1')),
    UnoWildCard(600.0, 'design2', key: Key('design2')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'UNO WildCard ${index == 0 ? 'Design #1' : 'Design #2'}',
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Container(
                height: 600,
                color: Colors.white,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: cards[index],
                  transitionBuilder: (child, Animation<double> animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            index = index == 0 ? 1 : 0;
          }),
          child: const Icon(Icons.swap_horiz_outlined),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class UnoWildCard extends StatefulWidget {
  final double cardSize;
  final String design;

  const UnoWildCard(this.cardSize, this.design, {Key? key}) : super(key: key);

  @override
  _UnoWildCardState createState() => _UnoWildCardState();
}

class _UnoWildCardState extends State<UnoWildCard> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WildCard(widget.cardSize, widget.design),
    );
  }
}

class WildCard extends CustomPainter {
  final double cardSize;
  final String design;
  double cardWidth = 0.0;
  double cardHeight = 0.0;

  WildCard(this.cardSize, this.design) {
    cardWidth = 0.6 * cardSize;
    cardHeight = cardSize;
  }

  void cardBody(Canvas canvas, Size size, Offset center) {
    final cardBodyBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: cardWidth, height: cardHeight), const Radius.circular(25.0)), cardBodyBrush);
  }

  void miniCard(Canvas canvas, Size size, Offset center) {
    final greenMiniCardBrush = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = cardHeight * cardWidth * 0.00002;
    final redMiniCardBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = cardHeight * cardWidth * 0.00002;
    final blueMiniCardBrush = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = cardHeight * cardWidth * 0.00002;
    final yellowMiniCardBrush = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = cardHeight * cardWidth * 0.00002;
    final blackFillBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    if (design == 'design2') {
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(-cardWidth * 0.1, -cardHeight * 0.075), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          redMiniCardBrush);
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(-cardWidth * 0.030, -cardHeight * 0.05), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          blackFillBrush);
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(-cardWidth * 0.030, -cardHeight * 0.05), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          greenMiniCardBrush);
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(cardWidth * 0.030, -cardHeight * 0.025), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          blackFillBrush);
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(cardWidth * 0.030, -cardHeight * 0.025), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          blueMiniCardBrush);
      canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(cardWidth * 0.1, 0.0), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)), blackFillBrush);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(cardWidth * 0.1, 0.0), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          yellowMiniCardBrush);
    } else {
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(-cardWidth * 0.075, 0.0), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          greenMiniCardBrush);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(-cardWidth * 0.225, 0.0), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          redMiniCardBrush);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(cardWidth * 0.075, 0.0), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          blueMiniCardBrush);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center.translate(cardWidth * 0.225, 0.0), width: cardWidth * 0.1, height: cardHeight * 0.1), const Radius.circular(5.0)),
          yellowMiniCardBrush);
    }
  }

  void plusFour(Canvas canvas, Size size, Offset center) {
    final plushFourBrush = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = cardHeight * cardWidth * 0.000015;
    final topPath = Path();
    final bottomPath = Path();
    //bottom symbol 4
    bottomPath.moveTo(size.width / 2 + cardWidth * 0.300, size.height / 2 + cardHeight * 0.39);
    bottomPath.lineTo(size.width / 2 + cardWidth * 0.300, size.height / 2 + cardHeight * 0.43);
    bottomPath.moveTo(size.width / 2 + cardWidth * 0.315, size.height / 2 + cardHeight * 0.46);
    bottomPath.lineTo(size.width / 2 + cardWidth * 0.350, size.height / 2 + cardHeight * 0.41);
    bottomPath.lineTo(size.width / 2 + cardWidth * 0.270, size.height / 2 + cardHeight * 0.41);
    //bottom plus symbol
    bottomPath.moveTo(size.width / 2 + cardWidth * 0.380, size.height / 2 + cardHeight * 0.420);
    bottomPath.lineTo(size.width / 2 + cardWidth * 0.450, size.height / 2 + cardHeight * 0.420);
    bottomPath.moveTo(size.width / 2 + cardWidth * 0.415, size.height / 2 + cardHeight * 0.397);
    bottomPath.lineTo(size.width / 2 + cardWidth * 0.415, size.height / 2 + cardHeight * 0.443);
    //top symbol 4
    topPath.moveTo(size.width / 2 - cardWidth * 0.300, size.height / 2 - cardHeight * 0.390);
    topPath.lineTo(size.width / 2 - cardWidth * 0.300, size.height / 2 - cardHeight * 0.430);
    topPath.moveTo(size.width / 2 - cardWidth * 0.315, size.height / 2 - cardHeight * 0.460);
    topPath.lineTo(size.width / 2 - cardWidth * 0.350, size.height / 2 - cardHeight * 0.410);
    topPath.lineTo(size.width / 2 - cardWidth * 0.270, size.height / 2 - cardHeight * 0.410);
    //top plus symbol
    topPath.moveTo(size.width / 2 - cardWidth * 0.380, size.height / 2 - cardHeight * 0.420);
    topPath.lineTo(size.width / 2 - cardWidth * 0.450, size.height / 2 - cardHeight * 0.420);
    topPath.moveTo(size.width / 2 - cardWidth * 0.415, size.height / 2 - cardHeight * 0.397);
    topPath.lineTo(size.width / 2 - cardWidth * 0.415, size.height / 2 - cardHeight * 0.443);

    canvas.drawPath(bottomPath, plushFourBrush);
    canvas.drawPath(topPath, plushFourBrush);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    cardBody(canvas, size, center);
    miniCard(canvas, size, center);
    plusFour(canvas, size, center);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
