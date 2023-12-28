// This is a Flutter adaptation of https://www.thethingsnetwork.org/forum/t/deveui-for-non-hardware-assigned-values/2093/23 post on the TTN forum

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generate EUI & Key',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Generate EUI & Key',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? _appeui;
  List? _deveui;
  List? _appkey;
  String? _appEUIhex;
  String? _appEUIString;
  String? _devEUIhex;
  String? _devEUIString;
  String? _appKeyhex;
  String? _appKeyString;

  void _generator() {
    List euiGenerate() {
      List eui = [
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      ];
      eui[0] = (eui[0] & ~1) | 2;
      return eui;
    }

    List keyGenerate() {
      List key = [
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      ];
      return key;
    }

    String hexBuffer(element) {
      var hexBuffer = "";
      for (var c = 0; c < element.length; c++) {
        hexBuffer += "0x";
        if (element[c] < 16) {
          hexBuffer += "0";
        }
        hexBuffer += element[c].toRadixString(16).toUpperCase();
        hexBuffer += (c != element.length - 1) ? ", " : "";
      }
      return hexBuffer;
    }

    String arrayString(digits) {
      var arrayString = "";
      for (var c = 0; c < digits.length; c++) {
        if (digits[c] < 16) {
          arrayString += "0";
        }
        arrayString += digits[c].toRadixString(16);
      }
      return arrayString;
    }

    _appeui = euiGenerate();
    _deveui = euiGenerate();
    _appkey = keyGenerate();

    _appEUIhex = hexBuffer(_appeui);
    _appEUIString = arrayString(_appeui).toUpperCase();

    _devEUIhex = hexBuffer(_deveui);
    _devEUIString = arrayString(_deveui).toUpperCase();

    _appKeyhex = hexBuffer(_appkey);
    _appKeyString = arrayString(_appkey).toUpperCase();
  }

  void _newEUIKey() {
    setState(() {
      _generator();
    });
  }

  @override
  void initState() {
    _generator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_generator();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EuiKey(
                  boxTitele: 'AppEUI',
                  euiKeyString: _appEUIString!,
                  euiKeyhex: _appEUIhex!),
              const SizedBox(height: 15),
              EuiKey(
                  boxTitele: 'DevEUI',
                  euiKeyString: _devEUIString!,
                  euiKeyhex: _devEUIhex!),
              const SizedBox(height: 15),
              EuiKey(
                  boxTitele: 'AppKey',
                  euiKeyString: _appKeyString!,
                  euiKeyhex: _appKeyhex!),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                    onPressed: _newEUIKey,
                    child: const Text(
                      'New EUI & Key',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EuiKey extends StatelessWidget {
  const EuiKey({
    super.key,
    required this.boxTitele,
    required this.euiKeyString,
    required this.euiKeyhex,
  });

  final String boxTitele;
  final String euiKeyString;
  final String euiKeyhex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.lightBlue)),
      child: Column(
        children: [
          Text(
            boxTitele,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(euiKeyString),
          const SizedBox(
            height: 3,
          ),
          Text(euiKeyhex),
        ],
      ),
    );
  }
}
