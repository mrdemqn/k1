import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:k1/models/revenue.dart';
import 'package:k1/ui/graph_button.dart';

import '../fonts.dart';
import '../graph_manager.dart';

enum Button { H1, D1, W1, M1, M6, Y1 }

class GraphForm extends StatefulWidget {
  final Size size;
  final int index;

  const GraphForm({Key? key, required this.size, required this.index}) : super(key: key);

  @override
  _GraphFormState createState() => _GraphFormState();
}

class _GraphFormState extends State<GraphForm> with TickerProviderStateMixin {
  Size get size => widget.size;
  int get index => widget.index;
  Button? currentButton = Button.Y1;
  StreamController<Button> buttonSC = StreamController();
  Stream<Button> get buttonStream => buttonSC.stream;
  late List<double> yPosit;

  // Controllers for animating the graph
  late AnimationController _animationController;
  late Animation<double> _animation;

  GraphManager get graphManager => GraphManager();

  // Variable to start animation if true
  bool _animate = false;

  // Variable to track the first animation run
  bool _isStart = true;

  // We track the end of the animation so that after
  // the end of the first animation, we update its time
  void listener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed ||
    status == AnimationStatus.completed) {
      _animationController..duration = const Duration(milliseconds: 400);
    }
  }

  @override
  void initState() {
    _isStart
    // If the widget is showing for the first time, then delay for each element
    // (element number multiplied by 50 milliseconds) for the stair effect
        ? Future.delayed(Duration(milliseconds: index * 50), () {
      setState(() {
        _animate = true;
        _isStart = false;
      });
    }) : _animate = true;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 1, end: size.width * .8).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutQuad));
    _animation.addStatusListener(listener);
    _animationController.forward();
    // Initial value of the data in the graph (default year)
    yPosit = graphManager.currentRevenue.year;
    super.initState();
  }

  @override
  void dispose() {
    buttonSC.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _animate ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        padding: _animate
            ? EdgeInsets.zero
            : const EdgeInsets.only(top: 100),
        duration: const Duration(milliseconds: 400),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: StreamBuilder<Button>(
              stream: buttonStream,
              initialData: currentButton,
              builder: (context, buttonAsync) {
                final Button? button = buttonAsync.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedBuilder(
                            animation: _animationController,
                            builder: (BuildContext context, Widget? child) {
                              return Stack(
                                children: [
                                  Container(
                                      height: 350,
                                      width: size.width * .8,
                                      color: Colors.transparent),
                                  Container(
                                      height: 350,
                                      width: _animation.value,
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
                                      bottom: size.height * .37,
                                      child: divider()),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: size.height * .28,
                                      child: divider()),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: size.height * .19,
                                      child: divider()),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: size.height * .1,
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
                        columnPercents(),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 5),
                    rowMonth(),
                    SizedBox(height: 19),
                    rowButtons(button),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }

  // Widget displaying a row of buttons for switching between graph
  Widget rowButtons(Button? button) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GraphButton(active: button == Button.H1, text: '1H',
            onTap: () => buttonTapped(Button.H1, graphManager.currentRevenue.hour)),

        GraphButton(active: button == Button.D1, text: '1D',
            onTap: () => buttonTapped(Button.D1, graphManager.currentRevenue.day)),

        GraphButton(active: button == Button.W1, text: '1W',
            onTap: () => buttonTapped(Button.W1, graphManager.currentRevenue.week)),

        GraphButton(active: button == Button.M1, text: '1M',
            onTap: () => buttonTapped(Button.M1, graphManager.currentRevenue.month)),

        GraphButton(active: button == Button.M6, text: '6M',
            onTap: () => buttonTapped(Button.M6, graphManager.currentRevenue.sixMonth)),

        GraphButton(active: button == Button.Y1, text: '1Y',
            onTap: () => buttonTapped(Button.Y1, graphManager.currentRevenue.year)),
      ],
    );
  }

  // Handling a graph button click
  void buttonTapped(Button? button, List<double> revenue) {
    if (currentButton != button && button != null) {
      // Save the currently pressed graph button
      currentButton = button;
      // Adding an event depending on the pressed button and rebuilding a row of graph buttons
      buttonSC.sink.add(button);
      // Change of data for the graph depending on the pressed button
      yPosit = revenue;
      // Reset animation for next playback from the beginning
      _animationController.reset();
      // Play graph animation
      _animationController.forward();
    }
  }

  // Widget displaying a row with months
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

  // Widget displaying text element (month)
  Widget monthItem(String text) {
    return Text(text,
        style: TextStyle(color: Color.fromRGBO(60, 60, 67, 170), fontSize: 9,
            fontFamily: sfProTextMedium, fontWeight: FontWeight.w500));
  }

  // Widget displaying a column with graph percentages
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

  // Widget displaying text element (graph percentages)
  Widget percentItem(String text) {
    return Text(text,
        style: TextStyle(color: Color.fromRGBO(60, 60, 67, 170), fontSize: 9,
            fontFamily: sfProTextMedium, fontWeight: FontWeight.w600));
  }

  Widget divider() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width * .8,
          child: Divider(
            height: 0.33,
            thickness: 0.33,
            color: Color.fromRGBO(60, 60, 67, 170),
          ),
        ),
      );
  }
}

// The graph that was built on Canvas
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