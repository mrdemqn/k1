import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:k1/ui/graph_button.dart';

enum Button { H1, D1, W1, M1, M6, Y1 }

class GraphForm extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const GraphForm({Key? key, required this.animationController, required this.animation}) : super(key: key);

  @override
  _GraphFormState createState() => _GraphFormState();
}

class _GraphFormState extends State<GraphForm> with TickerProviderStateMixin {
  Button initialButton = Button.Y1;
  StreamController<Button> buttonSC = StreamController();
  Stream<Button> get buttonStream => buttonSC.stream;
  late List<double> yPosit;

  late AnimationController _animationController;
  late Animation<double> _animation;
  Size get size => MediaQuery.of(context).size;

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed ||
    status == AnimationStatus.completed) {
      _animationController..duration = const Duration(milliseconds: 400);
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 1, end: 280).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutQuad));
    _animation.addStatusListener(listener);
    _animationController.forward();
    yPosit = getRandom();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(listener);
    _animationController.dispose();
    buttonSC.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(0.0, widget.animation.value * size.height, 0.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: StreamBuilder<Button>(
                stream: buttonStream,
                initialData: initialButton,
                builder: (context, buttonAsync) {
                  final Button? currentButton = buttonAsync.data;
                return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (BuildContext context, Widget? child) {
                                    return Stack(
                                      children: [
                                        Container(
                                            height: 350,
                                            width: 280,
                                            decoration: BoxDecoration(color: Colors.transparent),
                                            child: CustomPaint(
                                                painter: Graph(
                                                    yPos: yPosit,
                                                    paintingStyle: PaintingStyle.fill,
                                                    colorPaint: Colors.grey[100]!,
                                                    isBackground: true))),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 100,
                                            child: divider()),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 180,
                                            child: divider()),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 250,
                                            child: divider()),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 330,
                                            child: divider()),
                                        Container(
                                            height: 350,
                                            width: _animation.value,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: CustomPaint(
                                                painter: Graph(
                                                    yPos: yPosit,
                                                    paintingStyle: PaintingStyle.stroke,
                                                    colorPaint: Colors.green,
                                                    isBackground: false))),
                                      ],
                                    );
                                  }),
                            SizedBox(width: 5),
                            columnPercents()
                          ],
                        ),
                        SizedBox(height: 5),
                        rowMonth(),
                        SizedBox(height: 19),
                        rowButtons(currentButton),
                      ],
                    );
              }
            ),
              )

              /*TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 100),
              duration: const Duration(milliseconds: 2000),
              builder: (BuildContext context, double percentage, Widget? child) {
                return CustomPaint(
                  painter: LineChartPainterV2(percentage, data, "Top Three Formula One"),
                  child: Container(width: double.infinity, height: 340),
                );
              }),*/
        );
      }
    );
  }

  Widget rowButtons(Button? currentButton) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GraphButton(active: currentButton == Button.H1, text: '1H',
            onTap: () {
          buttonSC.sink.add(Button.H1);
          yPosit = getRandom();
          _animationController.reset();
          _animationController.forward();
        }),
        GraphButton(active: currentButton == Button.D1, text: '1D',
            onTap: () {
            buttonSC.sink.add(Button.D1);
            yPosit = getRandom();
            _animationController.reset();
            _animationController.forward();
        }),
        GraphButton(active: currentButton == Button.W1, text: '1W',
            onTap: () {
            buttonSC.sink.add(Button.W1);
            yPosit = getRandom();
            _animationController.reset();
            _animationController.forward();
        }),
        GraphButton(active: currentButton == Button.M1, text: '1M',
            onTap: () {
            buttonSC.sink.add(Button.M1);
            yPosit = getRandom();
            _animationController.reset();
            _animationController.forward();
        }),
        GraphButton(active: currentButton == Button.M6, text: '6M',
            onTap: () {
            buttonSC.sink.add(Button.M6);
            yPosit = getRandom();
            _animationController.reset();
            _animationController.forward();
        }),
        GraphButton(active: currentButton == Button.Y1, text: '1Y',
            onTap: () {
            buttonSC.sink.add(Button.Y1);
            yPosit = getRandom();
            _animationController.reset();
            _animationController.forward();
        }),
      ],
    );
  }

  Widget rowMonth() {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          monthItem('Сен'),
          monthItem('Окт'),
          monthItem('Ноя'),
          monthItem('Дек'),
          monthItem('Янв'),
          monthItem('Фев'),
          monthItem('Мар'),
          monthItem('Апр'),
          monthItem('Май'),
          monthItem('Июн'),
        ],
      ),
    );
  }

  Widget monthItem(String text) {
    return Text(text,
        style: TextStyle(color: Color.fromRGBO(60, 60, 67, 170), fontSize: 9, fontWeight: FontWeight.w500));
  }

  Widget columnPercents() {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          percentItem('50%'),
          percentItem('45%'),
          percentItem('40%'),
          percentItem('35%'),
          percentItem('30%'),
          percentItem('25%'),
          percentItem('20%'),
          percentItem('15%'),
          percentItem('10%'),
          percentItem('5%'),
          percentItem('0%'),
        ],
      ),
    );
  }

  Widget percentItem(String text) {
    return Text(text,
        style: TextStyle(color: Color.fromRGBO(60, 60, 67, 170), fontSize: 9, fontWeight: FontWeight.w600));
  }

  List<double> getRandom() {
    List<double> list = [];
    Random random = Random();
    for (int i = 0; i < 40; i++) {
      list.add(random.nextInt(100).toDouble());
    }
    return list;
  }

  Widget divider() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 280,
          child: Divider(
            height: 0.33,
            thickness: 0.33,
            color: Color.fromRGBO(60, 60, 67, 170),
          ),
        ),
      );
  }
}

class Graph extends CustomPainter {
  final List<double> yPos;
  final PaintingStyle paintingStyle;
  final Color colorPaint;
  final bool isBackground;

  const Graph({required this.yPos, required this.paintingStyle, required this.colorPaint,
    required this.isBackground});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    drawLine(canvas, size, path);
  }

  void drawLine(Canvas canvas, Size size, Path path) {
    canvas.translate(0.0, size.height);
    final Paint paint = Paint()
      ..strokeCap = StrokeCap.square
      ..style = paintingStyle
      ..strokeWidth = 1.5
      ..color = colorPaint;
    final double center = size.height / 2;
    // first point in bottom left corner of container
    path.moveTo(0.0, isBackground ? 0.0 : - (yPos.first + center));
    // random y points
    // creates a point translated in y inline with leading edge
    path.lineTo(0.0, - (yPos.first + center));
    // number of points in graph
    final int dividerConst = yPos.length;
    for (int i = 1; i < dividerConst + 1; i++) {
      path.lineTo(size.width / dividerConst * i - size.width / (dividerConst * 2), - (yPos[i-1] + center));
    }
    // the last point in line with trailing edge
    path.lineTo(size.width, -(yPos[dividerConst - 1] + center));
    // last point in bottom right corner of container
    path.lineTo(size.width, isBackground ? 0.0 : - (yPos.last + center));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}