import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'description_form.dart';
import 'first_bloc_form.dart';
import 'graph_form.dart';

class MainForm extends StatefulWidget {
  MainForm({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainForm> with TickerProviderStateMixin {
  // Controllers for animating screen blocks
  late AnimationController _firstBlocController;
  late AnimationController _graphController;
  late AnimationController _descriptionController;
  late AnimationController _opacityController;

  late Animation _firstBlocAnimation;
  late Animation _graphAnimation;
  late Animation _descriptionAnimation;
  late Animation<double> _opacityAnimation;

  Size get size => MediaQuery.of(context).size;

  @override
  void initState() {
    _firstBlocController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _graphController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _descriptionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _opacityController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    _firstBlocAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _firstBlocController, curve: Curves.easeInOutQuad));
    _graphAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _graphController, curve: Curves.easeInOutQuad));
    _descriptionAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _descriptionController, curve: Curves.easeInOutQuad));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _opacityController, curve: Curves.easeInOutQuad));

    _firstBlocController.forward();
    _graphController.forward();
    _descriptionController.forward();
    _opacityController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _firstBlocController.dispose();
    _graphController.dispose();
    _descriptionController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 29, left: 15, right: 15, bottom: 40),
            child: AnimatedBuilder(
              animation: _opacityController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FirstBlocForm(
                        animationController: _firstBlocController,
                        animation: _firstBlocAnimation,
                      ),
                      GraphForm(
                        animationController: _graphController,
                        animation: _graphAnimation,
                      ),
                      DescriptionForm(
                        animationController: _descriptionController,
                        animation: _descriptionAnimation,
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        )
    );
  }
}
