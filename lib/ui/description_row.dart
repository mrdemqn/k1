import 'package:flutter/material.dart';

import '../fonts.dart';

// Widget that renders one line of two columns displaying information about the business
class DescriptionRow extends StatefulWidget {
  final Size size;
  final int index;
  final String first;
  final String second;
  final String third;
  final String fourth;
  final Color? color;

  const DescriptionRow({Key? key, required this.size, required this.index,
    required this.first, required this.second, required this.third, required this.fourth,
    this.color}) : super(key: key);
  @override
  _DescriptionRowState createState() => _DescriptionRowState();
}

class _DescriptionRowState extends State<DescriptionRow> {
  Size get size => widget.size;
  int get index => widget.index;
  String get first => widget.first;
  String get second => widget.second;
  String get third => widget.third;
  String get fourth => widget.fourth;
  Color? get color => widget.color;
  // Variable to start animation if true
  bool _animate = false;

  // Variable to track the first animation run
  bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
    // If the widget is showing for the first time, then delay for each element
    // (element number multiplied by 50 milliseconds) for the stair effect
        ? Future.delayed(Duration(milliseconds: index * 50), () {
      setState(() {
        _animate = true;
        _isStart = false;
      });
    }) : _animate = true;
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
        child: Row(
          children: [
            Container(
                width: size.width * .446,
                child: columnBloc(first, second)),
            columnBloc(third, fourth),
          ],
        ),
      ),
    );
  }

  // Separate cell of business information in the form of a column
  Widget columnBloc(String fLine, String sLine, [Color? color]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fLine,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Color.fromRGBO(60, 60, 67, 170),
            fontSize: 11,
            fontFamily: sfProTextMedium,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 2),
        Text(
          sLine,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: color ?? Color.fromRGBO(0, 0, 0, 1),
            fontSize: 16,
            fontFamily: ubuntuMedium,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}
