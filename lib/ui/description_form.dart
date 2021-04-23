import 'package:flutter/material.dart';

class DescriptionForm extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const DescriptionForm({Key? key, required this.animationController, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.translationValues(0.0, animation.value * size.height, 0.0),
            child: body() /*Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        columnBloc('Капитализация, млн \$', '16 285'),
                        SizedBox(width: 8),
                        columnBloc('Отрасль', 'IT'),
                      ],
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: [
                        columnBloc('EV, млн \$', '19 785'),
                        SizedBox(width: 8),
                        columnBloc('Сектор', 'Кибербезопасность'),
                      ],
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: [
                        columnBloc('Дивидендная доходность', '1,8%'),
                        SizedBox(width: 8),
                        columnBloc('Биржа', 'NASDAQ'),
                      ],
                    ),
                    SizedBox(width: 40),
                    Row(
                      children: [
                        columnBloc('Доля в портфеле', '15%'),
                        SizedBox(width: 8),
                        columnBloc('Уровень входа', '120,39'),
                      ],
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: [
                        columnBloc('В портфеле с', '15 сентября 2021'),
                        SizedBox(width: 8),
                        columnBloc('Текущая цена', '121,10'),
                      ],
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: [
                        columnBloc('Актуальность идеи', 'средняя'),
                        SizedBox(width: 8),
                        columnBloc('Результат', '+1,12%'),
                      ],
                    ),
                  ],
                ),
              ],
            ),*/
          );
        }
      ),
    );
  }
  
  Widget body() {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                columnBloc('Капитализация, млн \$', '16 285'),
                SizedBox(height: 16),
                columnBloc('EV, млн \$', '19 785'),
                SizedBox(height: 16),
                columnBloc('Дивидендная доходность', '1,8%'),
                SizedBox(height: 16),
                columnBloc('Доля в портфеле', '15%'),
                SizedBox(height: 16),
                columnBloc('В портфеле с', '15 сентября 2021'),
                SizedBox(height: 16),
                columnBloc('Актуальность идеи', 'средняя'),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                columnBloc('Отрасль', 'IT'),
                SizedBox(height: 16),
                columnBloc('Сектор', 'Кибербезопасность'),
                SizedBox(height: 16),
                columnBloc('Биржа', 'NASDAQ'),
                SizedBox(height: 16),
                columnBloc('Уровень входа', '120,39'),
                SizedBox(height: 16),
                columnBloc('Текущая цена', '121,10'),
                SizedBox(height: 16),
                columnBloc('Результат', '+1,12%'),
              ],
            ),
          ],
        ),
        SizedBox(height: 40),
        Text(
          'Американская компания из сектора IT. Занимается разработкой софта в области информационной '
              'безопасности и защиты информации для ПК и центров обработки данных. Является одной из '
              'ведущих мировых компаний в своей области. Сам сектор, на наш взгляд, весьма интересен, '
              'а Norton, к тому же, выглядит дешево по мультипликаторам при неплохой фундаментальной картине. '
              'Покупка в «Агрессивный» портфель по цене \$21,1. Доля в портфеле 3%.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

  Widget columnBloc(String fLine, String sLine) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fLine,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color.fromRGBO(60, 60, 67, 170),
              fontSize: 11,
            ),
          ),
          Text(
            sLine,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
            ),
          ),
        ],
      );
  }
}
