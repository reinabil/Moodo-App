import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:lottie/lottie.dart';
import 'package:moodo/model/doa.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sized_context/sized_context.dart';
import 'package:moodo/model/style.dart';

import 'moodPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = false;
  var now = new DateTime.now();
  var waktu = Waktu();
  var hijri = new HijriCalendar.now();
  final int random = Random().nextInt(128);
  List<Doa>? doaList;
  bool _isInit = true;

  Future<void> fetchDoa(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/doa.json');
    doaList = doaFromJson(jsonstring);
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(children: <Widget>[
          Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                gradient: Style().gradasi,
              )),
          ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
                child: Column(
                  children: [
                    Text(
                      "Assalamualaikum",
                      style: Style(styleColor: Colors.white).header,
                    ),
                    Text(
                      Waktu(now).format('EEEE, d MMMM y'),
                      style: Style(styleColor: Colors.white).body,
                    ),
                    Text(
                      hijri.toFormat("dd MMMM yyyy"),
                      style: Style(styleColor: Colors.white).caption,
                    ),

                    // Container(
                    //   height: context.heightPct(.2),
                    // ),
                    FutureBuilder(
                        future: _isInit ? fetchDoa(context) : null,
                        builder: (context, _) {
                          if (doaList != null) {
                            Doa doa = doaList![
                                int.parse(Waktu(now).format('d')) + 51];
                            return Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 4,
                              shadowColor: Color.fromARGB(255, 63, 164, 165),
                              child: Container(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    GradientText(
                                      "Doa of The Day",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                      gradient: Style().gradasi,
                                    ),
                                    Text("${doa.judul}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${doa.lafaz}",
                                      style: TextStyle(
                                          fontSize: 24, fontFamily: "Poppins"),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${doa.latin}",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.teal),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${doa.arti}",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          } else
                            return Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.teal,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: context.heightPct(.3),
              )
            ],
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.25,
              maxChildSize: 0.67,
              minChildSize: 0.25,
              builder: (BuildContext c, s) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(200, 66, 167, 166),
                          blurRadius: 6.0,
                          offset: Offset(0, -7),
                        )
                      ]),
                  child: ListView(
                    controller: s,
                    children: <Widget>[
                      Center(
                        child: Container(
                          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          width: context.widthPct(.15),
                          height: context.heightPct(.007),
                          decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 0),
                        child: GradientText(
                          "Gimana mood-mu?",
                          textAlign: TextAlign.center,
                          style: Style(styleColor: Colors.black).title2,
                          gradient: Style().gradasi,
                        ),
                      ),
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        shadowColor: Color.fromARGB(255, 63, 164, 165),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "اَلَا بِذِکۡرِ اللّٰہِ تَطۡمَئِنُّ الۡقُلُوۡبُ",
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                "ALAA BIDZIKRILLAHI TATHMA-INNUL QULUUB(U);",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.teal),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram.(QS. Ar Ra’d: 28)",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        child: Wrap(
                          spacing: 24,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MoodPage(
                                            moodo: "Sedih",
                                          )),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: context.widthPct(.25),
                                      height: context.heightPct(.25),
                                      child: Lottie.asset(
                                          "assets/animation/sad.json")),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -30.0, 0.0),
                                    child: Text("Sedih",
                                        style: Style(
                                                styleColor:
                                                    Colors.grey.shade600)
                                            .body),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MoodPage(
                                            moodo: "Biasa aja",
                                          )),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                      width: context.widthPct(.25),
                                      height: context.heightPct(.25),
                                      child: Lottie.asset(
                                          "assets/animation/netral.json")),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -30.0, 0.0),
                                    child: Text("Biasa aja",
                                        style: Style(
                                                styleColor:
                                                    Colors.grey.shade600)
                                            .body),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MoodPage(
                                            moodo: "Senang",
                                          )),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                      width: context.widthPct(.25),
                                      height: context.heightPct(.25),
                                      child: Lottie.asset(
                                          "assets/animation/happy.json")),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -30.0, 0.0),
                                    child: Text("Senang",
                                        style: Style(
                                                styleColor:
                                                    Colors.grey.shade600)
                                            .body),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
          // ANCHOR Tentang aplikasi
          SafeArea(
              child: IconButton(
                  icon: Icon(
                    Icons.info_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    NAlertDialog(
                      title: Text(
                        "Tentang Aplikasi",
                        style: Style().headline,
                      ),
                      content: Container(
                        width: context.widthPct(.5),
                        height: context.heightPct(.5),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset("assets/logo_horizontal.png"),
                            SizedBox(
                              height: 0,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Sumber data doa :\nApa Doanya app\n\nDeveloped\nwholeheartedly by\n😎 nabilrei 😎\n😄 hantsnm 😄\n😇 rennyatikas 😇\n🧐 cayne.dameron 🧐\n",
                                style: Style().body,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.topLeft,
                            //   child: Text(
                            //     "Pilih tema warna",
                            //     style: Style().headline,
                            //     textAlign: TextAlign.left,
                            //   ),
                            // ),
                            // ANCHOR Button tema
                            // Container(
                            //   margin: EdgeInsets.symmetric(vertical: 0),
                            //   child: Wrap(
                            //     spacing: 16,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () {},
                            //         child: Material(
                            //           borderRadius: BorderRadius.circular(100),
                            //           elevation: 10,
                            //           shadowColor: Colors.teal,
                            //           child: Stack(
                            //             children: <Widget>[
                            //               SizedBox(
                            //                 width: context.widthPct(.14),
                            //                 height: context.widthPct(.14),
                            //                 child: Material(
                            //                     borderRadius:
                            //                         BorderRadius.circular(100),
                            //                     color: Colors.transparent),
                            //               ),
                            //               Container(
                            //                 width: context.widthPct(.14),
                            //                 height: context.widthPct(.14),
                            //                 decoration: BoxDecoration(
                            //                     gradient: Style().gradasi,
                            //                     borderRadius:
                            //                         BorderRadius.circular(100)),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Text(
                              "versi 1.0.0",
                              style:
                                  Style(styleColor: Colors.grey.shade600).body,
                            ),
                          ],
                        ),
                      ),
                      blur: 2,
                    ).show(context, transitionType: DialogTransitionType.NONE);
                  }))
        ]),
      ),
    );
  }
}
