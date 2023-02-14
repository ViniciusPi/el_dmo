import 'dart:async';

import 'package:eldaq_demonstration/src/modbus_requisicao.dart';
import 'package:eldaq_demonstration/view/display.dart';
import 'package:eldaq_demonstration/view/grafico.dart';
import 'package:eldaq_demonstration/view/grafico_0_10.dart';
import 'package:eldaq_demonstration/view/grafico_torque.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: EldaqHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EldaqHomePage extends StatefulWidget {
  const EldaqHomePage({Key? key}) : super(key: key);

  @override
  State<EldaqHomePage> createState() => _EldaqHomePageState();
}

class _EldaqHomePageState extends State<EldaqHomePage> {
  int _selecionado = 0;
  double tensao = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getModbusdata();
    Timer.periodic(Duration(milliseconds: 1200), adicionar);
  }

  void adicionar(Timer timer) async {
    var data123 = await atribuir();

    if (!mounted) return;
    setState(() {
      tensao = data123;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _selecionado,
        onChanged: (i) => setState(
          () {
            _selecionado = i;
          },
        ),
        items: <NavigationPaneItem>[
          PaneItem(
            icon: Icon(
              FluentIcons.stacked_line_chart,
            ),
            title: Text(
              'Grafico canal 1'.toUpperCase(),
            ),
          ),
          PaneItem(
            icon: Icon(
              FluentIcons.screen,
            ),
            title: Text(
              'Display'.toUpperCase(),
            ),
          ),
          PaneItem(
            icon: Icon(
              FluentIcons.rotate,
            ),
            title: Text(
              'curva de torque'.toUpperCase(),
            ),
          ),
        ],
      ),
      content: NavigationBody(
        index: _selecionado,
        children: [
          Grafico02(
            tensaoGrafico: tensao,
          ),
          DisplayDados(
            tensaoDisplay: tensao,
          ),
          GraficoTorque(
            tensaoGrafico: tensao,
          ),
        ],
      ),
    );
  }
}
