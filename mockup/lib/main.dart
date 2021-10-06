import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Render',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GlobalKey> keys = [
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
  ];

  String dir = '';

  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((value) {
      setState(() {
        dir = value?.path ?? '';
        print(dir);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var style = GoogleFonts.roboto(textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w100));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () async {
                    for (final key in keys) {
                      final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
                      final image = await boundary?.toImage();
                      final data = await image?.toByteData(format: ui.ImageByteFormat.png);
                      final bytes = data?.buffer.asUint8List();

                      if (bytes != null) {
                        final dir = await getApplicationDocumentsDirectory();
                        final path = '${dir.path}/${key.hashCode.toString()}.png';
                        final file = await File(path).create();
                        await file.writeAsBytes(bytes);
                      }
                    }
                  },
                  child: const Text('Render'),
                ),
                SizedBox(width: 24),
                Text('$dir'),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RepaintBoundary(
                    key: keys[0],
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: Center(
                        child: Text('Сегодня без интерфейсов', style: style),
                      ),
                    ),
                  ),

                  RepaintBoundary(
                    key: keys[1],
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Просто берем код на Rust', style: style),
                            const SizedBox(height: 48),
                            Image.asset('assets/images/code1.jpeg', width: 600),
                          ],
                        ),
                      ),
                    ),
                  ),

                  RepaintBoundary(
                    key: keys[2],
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(64.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('И через FFI линкуем его \nк iOS приложенияю', style: style),
                            const Spacer(),
                            Image.asset('assets/images/screen.jpeg', width: 300),
                          ],
                        ),
                      ),
                    ),
                  ),

                  RepaintBoundary(
                    key: keys[3],
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Потом вызываем в Swift', style: style),
                            const SizedBox(height: 48),
                            Image.asset('assets/images/code2.png', width: 600),
                          ],
                        ),
                      ),
                    ),
                  ),

                  RepaintBoundary(
                    key: keys[4],
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: Center(
                        child: Text('#codober', style: style),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

