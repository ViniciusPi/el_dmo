import 'dart:typed_data';
import 'package:modbus/modbus.dart' as modbus;
import 'package:hex/hex.dart';
import 'dart:typed_data';

Future<Uint16List> getModbusdata() async {
  var client = modbus.createTcpClient(
    '10.1.25.100',
    port: 1001,
    mode: modbus.ModbusMode.rtu,
  );

  try {
    await client.connect();

    var slaveIdResponse = await client.reportSlaveId();
    var signal = await client.readHoldingRegisters(68, 2);
    var signal2 = await client.readHoldingRegisters(69, 2);
    print("Slave ID: $slaveIdResponse");
    print(signal);
    print(signal2);
    return signal;
  } finally {
    client.close();
  }
}

Future<double> atribuir() async {
  var data = await getModbusdata();
  var datarecuperada;
  double valorfinal;

  datarecuperada = data.toList()[1].toInt().toRadixString(16).toString() +
      data.toList()[0].toInt().toRadixString(16).toString();

  var ddd5 = HEX.decode(datarecuperada);
  var ddd6 = HEX.encode(ddd5);
  var ddd4 = int.parse(ddd6, radix: 16);
  var d = ByteData(4);
  d.setInt32(0, ddd4);
  valorfinal = double.parse(
    d.getFloat32(0).toDouble().toStringAsFixed(4),
  );
  return valorfinal;
}
