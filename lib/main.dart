import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:async';
// import 'package:';
import 'dart:convert';
import 'package:crypto/crypto.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
			primarySwatch: Colors.grey,
			),
			debugShowCheckedModeBanner: false,
			home: MyHomePage(title: 'JOREM ADMIN'),
		);
	}
}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
	String _scanBarcodeEntrar = '';
	String _scanBarcodeSair = '';

	Future _scanQREntrar() async {
		try {
			String qrResult = await BarcodeScanner.scan();
			setState(() {
				_scanBarcodeEntrar = qrResult;
				var bytes = utf8.encode(_scanBarcodeEntrar.toString());
				var digest = md5.convert(bytes);
				print(digest);
				exist(digest.toString());
			});
		} on PlatformException catch (ex) {
			if (ex.code == BarcodeScanner.CameraAccessDenied) {
				setState(() {
					_scanBarcodeEntrar = "Camera permission was denied";
					print(_scanBarcodeEntrar);
				});
			} else {
				setState(() {
					_scanBarcodeEntrar = "Unknown Error $ex";
					print(_scanBarcodeEntrar);
				});
			}
		} on FormatException {
			setState(() {
				_scanBarcodeEntrar = "You pressed the back button before scanning anything";
				print(_scanBarcodeEntrar);
			});
		} catch (ex) {
			setState(() {
				_scanBarcodeEntrar = "Unknown Error $ex";
				print(_scanBarcodeEntrar);
			});
		}
	}
	Future _scanQRSair() async {
		try {
			String qrResult = await BarcodeScanner.scan();
			setState(() {
				_scanBarcodeSair = qrResult;
				print(_scanBarcodeSair);
				exist(_scanBarcodeSair);
			});
		} on PlatformException catch (ex) {
			if (ex.code == BarcodeScanner.CameraAccessDenied) {
				setState(() {
					_scanBarcodeSair = "Camera permission was denied";
					print(_scanBarcodeSair);
				});
			} else {
				setState(() {
					_scanBarcodeSair = "Unknown Error $ex";
					print(_scanBarcodeSair);
				});
			}
		} on FormatException {
			setState(() {
				_scanBarcodeSair = "You pressed the back button before scanning anything";
				print(_scanBarcodeSair);
			});
		} catch (ex) {
			setState(() {
				_scanBarcodeSair = "Unknown Error $ex";
				print(_scanBarcodeSair);
			});
		}
	}

  Future exist(String md5Hash) async {
    // print(Firestore.instance.collection("usuarios").getDocuments());
    print(md5Hash);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          		mainAxisAlignment: MainAxisAlignment.center,
          		children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							RaisedButton(
								child: Text("Entrar"),
								color: Colors.blue,
								onPressed: _scanQREntrar
							),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							RaisedButton(
								child: Text("Sair"),
								color: Colors.red,
								onPressed: _scanQRSair,
							)
						],
					)
				],
        	)
		)
	);
  }
}