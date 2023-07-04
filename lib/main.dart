import 'dart:typed_data';

import 'package:enough_convert/enough_convert.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';
import 'package:untitled3/products_model.dart';
import 'package:untitled3/receipt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String msg = '';
  TextEditingController ip = TextEditingController();
  img.Image? productsScreenshot;
  ScreenshotController screenshotController = ScreenshotController();
  List<Products> products = [
    Products(
      title: 'عصير الليمون بالنعناع - Lemon& mint',
      quantity: 2,
      price: 25.0
    ),
 Products(
      title: 'عرض أصلي دجاج - OFFER ASLI CHICKEN 5SR',
     quantity: 1,
     price: 123.75
    ),
 Products(
      title: 'بطاطس , مشروب - Frise+Soft Drinks',
     quantity: 1,
     price: 29.5
    ),

  ];

  List<String> codePages = [
    "CP720",
    "CP775",
    "CP855",
    "CP861",
    "CP862",
    "CP864",
    "CP869",
    "CP774",
    "CP772",
    // "CP1125",
    "CP1250",
    // "CP1251",
    // "CP1253",
    // "CP1254",
    // "CP1255",
    // "CP1256",
    // "CP1257",
    // "CP1258",
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  imageProductsPrinter() async {

    screenshotController.capture().then((Uint8List? image2) {
      productsScreenshot = img.decodePng(image2!);
      productsScreenshot!.setPixelRgba(0, 0, 255,255,255);
      productsScreenshot= img.copyResize(productsScreenshot!, width: 550);
   setState(() {});
    });
  }


  Uint8List textEncoder(String word) {
    return Uint8List.fromList(
        Windows1256Codec(allowInvalid: false).encode(word));
  }

  testReceipt(NetworkPrinter printer) async {
    printer.setGlobalCodeTable('CP775');

    printer.image(productsScreenshot!, align: PosAlign.center);

    printer.drawer();
    printer.feed(2);
    printer.cut();
  }

  testPrint() async {
    setState(() {
      msg = '';
    });
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);
      PosPrintResult res = await printer.connect(ip.text, port: 9100);
      if (res == PosPrintResult.success) {
        await testReceipt(printer);
        printer.disconnect();
      }
      else{
        setState(() {
          msg = '${res.msg}';
        });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    imageProductsPrinter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for e ach widget.

          children: <Widget>[
             Text(msg,),
        Expanded(child: Receipt(screenshotController: screenshotController, products: products)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all()
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: ip,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'ip',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
              ),
            ),
          ),
        )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: testPrint,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
