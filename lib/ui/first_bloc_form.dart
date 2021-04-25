import 'package:flutter/material.dart';

import '../fonts.dart';

// Widget for displaying the general status of the wallet,
// percentage of profit and the current date
class FirstBlocForm extends StatefulWidget {
  final Size size;
  final int index;

  const FirstBlocForm({Key? key, required this.size, required this.index}) : super(key: key);

  @override
  _FirstBlocFormState createState() => _FirstBlocFormState();
}

class _FirstBlocFormState extends State<FirstBlocForm> {
  Size get size => widget.size;
  int get index => widget.index;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '10,771.13',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 34,
                    fontFamily: sfProTextMedium,
                    fontWeight: FontWeight.w700,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '+1.15 (+1.12%)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(52, 199, 89, 1),
                  fontSize: 15,
                  fontFamily: sfProTextMedium,
                  fontWeight: FontWeight.w600,),
              ),
            ),
            Text(
              '6 апреля 2021 г.   10:34   EST',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromRGBO(60, 60, 67, 170),
                fontSize: 11,
                fontFamily: sfProTextMedium,
                fontWeight: FontWeight.w600,),
            ),
          ],
        ),
      ),
    );
  }
}
