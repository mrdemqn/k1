import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k1/fonts.dart';
import 'package:k1/ui/behavior_without_glow.dart';
import 'package:k1/ui/description_row.dart';

import 'first_bloc_form.dart';
import 'graph_form.dart';

class MainForm extends StatefulWidget {
  MainForm({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainForm> with TickerProviderStateMixin {

  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: BehaviorWithoutGlow(),
          child: ListView(
            cacheExtent: 1200,
            padding: const EdgeInsets.only(top: 29, left: 15, right: 15, bottom: 40),
            children: <Widget>[
              FirstBlocForm(size: size, index: 0),
              GraphForm(size: size, index: 1),
              SizedBox(height: 40),
              DescriptionRow(size: size, index: 2,
              first: 'Капитализация, млн \$', second: '16 285',
              third: 'Отрасль', fourth: 'IT',),
              SizedBox(height: 16),
              DescriptionRow(size: size, index: 3,
                first: 'EV, млн \$', second: '19 785',
                third: 'Сектор', fourth: 'Кибербезопасность',),
              SizedBox(height: 16),
              DescriptionRow(size: size, index: 4,
                first: 'Дивидендная доходность', second: '1,8%',
                third: 'Биржа', fourth: 'NASDAQ',),
              SizedBox(height: 40),
              DescriptionRow(size: size, index: 5,
                first: 'Доля в портфеле', second: '15%',
                third: 'Уровень входа', fourth: '120,39',),
              SizedBox(height: 16),
              DescriptionRow(size: size, index: 6,
                first: 'В портфеле с', second: '15 сентября 2021',
                third: 'Текущая цена', fourth: '121,10',),
              SizedBox(height: 16),
              DescriptionRow(size: size, index: 7,
                first: 'Актуальность идеи', second: 'Средняя',
                third: 'Результат', fourth: 'Результат', color: Color.fromRGBO(52, 199, 89, 1)),
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
                    fontFamily: sfProTextMedium,
                    fontWeight: FontWeight.w400,
                    height: 1.29
                ),
              ),
            ],
          ),
        )
    );
  }

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
          ),
        ),
        SizedBox(height: 2),
        Text(
          sLine,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: color ?? Color.fromRGBO(0, 0, 0, 1),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
