import 'package:flutter/material.dart';

class FirstBlocForm extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const FirstBlocForm({Key? key, required this.animationController, required this.animation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(0.0, animation.value * size.height, 0.0),
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
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '+1.15 (+1.12%)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(52, 199, 89, 1),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,),
                ),
              ),
              Text(
                '6 апреля 2021 г.   10:34   EST',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(60, 60, 67, 170),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,),
              ),
            ],
          ),
        );
      }
    );
  }
}
