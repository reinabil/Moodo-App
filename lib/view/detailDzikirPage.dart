import 'package:flutter/material.dart';
import 'package:moodo/model/dzikir.dart';
import 'package:moodo/model/style.dart';
import 'package:sized_context/sized_context.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:recase/recase.dart';

class DetailDzikirPage extends StatelessWidget {
  const DetailDzikirPage({
    required this.dzikir,
  });

  final Dzikir dzikir;

  @override
  Widget build(BuildContext context) {
    final _screenshotController = ScreenshotController();
    void _takeScreenshot() async {
      final imageFile = await _screenshotController.capture(pixelRatio: 6);
      Share.shareFiles([imageFile.path]);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        appBar: AppBar(
          leading: InkWell(
            child: Container(
              margin: EdgeInsets.all(11),
              decoration: BoxDecoration(
                gradient: Style().gradasi,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 67, 169, 165),
                      offset: Offset(1, 2),
                      blurRadius: 3)
                ],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
            onTap: () {
              // ignore: unused_element
              // setState() {
              Navigator.pop(context);
              //}
            },
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    // ignore: unused_element
                    // setState() {
                    _takeScreenshot();
                    // }
                  },
                  child: Icon(
                    Icons.mobile_screen_share_rounded,
                    color: Colors.grey[400],
                    size: 26.0,
                  ),
                )),
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Dzikir " + dzikir.waktu!.titleCase,
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
            ),
          ),
        ),
        // ANCHOR body
        body: Screenshot(
          controller: _screenshotController,
          child: Stack(children: <Widget>[
            Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(gradient: Style().gradasi)),
            Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(56, 16, 56, 16),
                    child: Text(
                      dzikir.judul!,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        "Lafaz Dzikir",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 24),
                      child: IconButton(
                          icon: Icon(
                            Icons.file_copy,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Share.share(
                                "${dzikir.judul}\n\n${dzikir.lafaz}\n\nShared with 💖 from Moodo App");
                          }),
                    )
                  ]),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 7,
                      shadowColor: Color.fromARGB(255, 63, 164, 165),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Column(
                          children: [
                            Text(
                              dzikir.lafaz!,
                              style: TextStyle(
                                  fontSize: 24, fontFamily: "Poppins"),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dzikir.latin!,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontStyle: FontStyle.italic,
                                  color: Colors.teal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 24,
                          ),
                          child: Text(
                            "Arti Dzikir",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 24),
                          child: IconButton(
                              icon: Icon(
                                Icons.file_copy,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Share.share(
                                    "${dzikir.judul}\n\n${dzikir.arti}\n\nShared with 💖 from Moodo App");
                              }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 7,
                      shadowColor: Color.fromARGB(255, 63, 164, 165),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          dzikir.arti!,
                          style: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            "Tentang Dzikir",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 24),
                          child: IconButton(
                            icon: Icon(
                              Icons.file_copy,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Share.share(
                                  "${dzikir.judul}\n\n${dzikir.arti}\n\nShared with 💖 from Moodo App");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 7,
                      shadowColor: Color.fromARGB(255, 63, 164, 165),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Text(
                          dzikir.tentang!,
                          style: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextButton(
                      onPressed: () {
                        Share.share(
                            "${dzikir.judul}\n\n${dzikir.lafaz}\n\nArtinya: ${dzikir.arti}\n\nTentang Dzikir: \n${dzikir.tentang}\n\nDisebarkan dengan sepenuh 💖 dari Moodo.\nInstall Moodo sekarang juga! https://ipb.link/get-moodo");
                      },
                      style: TextButton.styleFrom(primary: Colors.tealAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            "Share lafaz, arti, dan riwayat ${dzikir.judul}",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontFamily: "Poppins",
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.widthPct(.2),
                    width: 16,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
