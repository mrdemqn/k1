import 'package:flutter/material.dart';

class GraphButton extends StatelessWidget {
  final bool active;
  final String? text;
  final Function onTap;
  const GraphButton({required this.active, this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 25,
        width: 43,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Color.fromRGBO(0, 122, 255, 1) : Color.fromRGBO(242, 242, 247, 1),
          borderRadius: BorderRadius.circular(7)
        ),
        child: Text(
            text ?? '',
        style: TextStyle(
          color: active ? Colors.white : Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}
