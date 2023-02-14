import 'package:eldaq_demonstration/src/modbus_requisicao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart' as prefix;
import 'dart:async';

class DisplayDados extends StatefulWidget {
  double tensaoDisplay = 0;
  DisplayDados({Key? key, required this.tensaoDisplay}) : super(key: key);

  @override
  State<DisplayDados> createState() => _DisplayDadosState();
}

class _DisplayDadosState extends State<DisplayDados> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(
      const Duration(milliseconds: 1100),
      relacionar,
    );
  }

  var tensao2;

  void relacionar(Timer timer) async {
    var tensao = 2;
    if (!mounted) return;
    setState(() {
      tensao2 = tensao;
    });
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
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 20, top: 10),
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
                Flexible(
                  flex: 5,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'tensão: '.toUpperCase(),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: prefix.Colors.black,
                          ),
                          height: MediaQuery.of(context).size.height / 12,
                          width: MediaQuery.of(context).size.width / 7,
                          child: Center(
                            child: Text(
                              '${widget.tensaoDisplay} V',
                              style: TextStyle(
                                fontSize: 30,
                                color: Color.fromRGBO(255, 192, 0, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
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
