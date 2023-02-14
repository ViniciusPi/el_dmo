import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficoTorque extends StatefulWidget {
  double tensaoGrafico = 0;
  GraficoTorque({Key? key, required this.tensaoGrafico}) : super(key: key);

  @override
  State<GraficoTorque> createState() => _GraficoTorqueState();
}

class _GraficoTorqueState extends State<GraficoTorque> {
  List<EmbrasulData> dataEmbrasul = getDataEmbrasul();
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataEmbrasul();
    Timer.periodic(Duration(milliseconds: 1100), callback);
    _zoomPanBehavior = ZoomPanBehavior(
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
  }

  bool graficoAtivo = true;
  int cronometro = 1;
  callback(Timer timer) {
    if (graficoAtivo) {
      dataEmbrasul.add(
        EmbrasulData(cronometro++, widget.tensaoGrafico),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Color.fromRGBO(255, 192, 0, 1),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Center(
                              child: Container(
                                width: 500,
                                height: 100,
                                child: Image.asset(
                                    'images/Logo_DLB_2021_Preto.png',
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 20,
                            ),
                            child: Text(
                              'dlb-ad-01'.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 1.5,
                    color: prefix.Colors.black,
                    child: Center(
                      child: SfCartesianChart(
                        enableAxisAnimation: false,
                        zoomPanBehavior: _zoomPanBehavior,
                        margin: EdgeInsets.all(20),
                        title: ChartTitle(
                          text: 'monitoramento de tensão 0 - 4 v  (canal 1)'
                              .toUpperCase(),
                          textStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1),
                          ),
                        ),
                        primaryXAxis: NumericAxis(
                          autoScrollingDelta: 10,
                          interval: 1,
                          title: AxisTitle(
                            alignment: ChartAlignment.far,
                            text: 'tempo (s)',
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(255, 192, 0, 1),
                            ),
                          ),
                          labelFormat: '{value}s',
                          associatedAxisName: 'tempo',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1),
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          labelFormat: '{value}V',
                          associatedAxisName: 'V',
                          title: AxisTitle(
                            alignment: ChartAlignment.far,
                            text: 'tensão (V)',
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(255, 192, 0, 1),
                            ),
                          ),
                          autoScrollingDelta: 4,
                          interval: 1,
                          isVisible: true,
                          minimum: 0.0,
                          maximum: 4.0,
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(255, 192, 0, 1),
                          ),
                        ),
                        series: <ChartSeries<EmbrasulData, int>>[
                          LineSeries<EmbrasulData, int>(
                            color: Color.fromRGBO(255, 192, 0, 1),
                            dataSource: dataEmbrasul,
                            xValueMapper: (EmbrasulData tensao, _) =>
                                tensao.time,
                            yValueMapper: (EmbrasulData tensao, _) =>
                                tensao.tensao,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: Text(
                        'Aquisição de dados'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              graficoAtivo = !graficoAtivo;
                            },
                          );
                        },
                        icon: graficoAtivo
                            ? Icon(prefix.Icons.pause, size: 30)
                            : Icon(prefix.Icons.play_arrow, size: 30),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Container(),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 10),
                          child: Center(
                            child: Container(
                              width: 800,
                              height: 50,
                              child: Image.asset(
                                'images/logo_ifmg.png',
                                fit: BoxFit.contain,
                                width: 700,
                                scale: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

List<EmbrasulData> getDataEmbrasul() {
  return <EmbrasulData>[
    EmbrasulData(0, 0),
  ];
}

class EmbrasulData {
  EmbrasulData(this.time, this.tensao);

  final int time;
  final dynamic tensao;
}
