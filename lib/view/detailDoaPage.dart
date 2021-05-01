import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moodo/model/doa.dart';
import 'package:moodo/model/style.dart';
import 'package:sized_context/sized_context.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

final sharedPrefs = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

class FavoriteIds extends StateNotifier<List<String>> {
  FavoriteIds(this.pref) : super(pref?.getStringList("id") ?? []);

  static final provider =
      StateNotifierProvider<FavoriteIds, List<String>>((ref) {
    final pref = ref.watch(sharedPrefs).maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    return FavoriteIds(pref);
  });

  final SharedPreferences? pref;

  void toggle(String favoriteId) {
    if (state.contains(favoriteId)) {
      state = state.where((id) => id != favoriteId).toList();
    } else {
      state = [...state, favoriteId];
    }
    // Throw here since for some reason SharedPreferences could not be retrieved
    pref!.setStringList("id", state);
  }
}

class DetailDoa extends ConsumerWidget {
  const DetailDoa({
    required this.doa,
  });

  final Doa doa;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _screenshotController = ScreenshotController();
    void _takeScreenshot() async {
      final imageFile = await _screenshotController.capture(pixelRatio: 6);
      Share.shareFiles([imageFile.path]);
    }

    final favoriteIds = watch(FavoriteIds.provider);

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
            //ANCHOR Favorite icon
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: IconButton(
                  icon: favoriteIds.contains(doa.id.toString())
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: favoriteIds.contains(doa.id.toString())
                      ? Colors.red
                      : Colors.grey,
                  onPressed: () => context
                      .read(FavoriteIds.provider.notifier)
                      .toggle(doa.id.toString()),
                ),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Doa",
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
                      doa.judul!.titleCase,
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
                        "Lafaz Doa",
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
                                "${doa.judul}\n\n${doa.lafaz}\n\nShared with 💖 from Moodo App");
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
                              doa.lafaz!,
                              style: TextStyle(
                                  fontSize: 24, fontFamily: "Poppins"),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                doa.latin!,
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
                            "Arti Doa",
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
                                    "${doa.judul}\n\n${doa.arti}\n\nShared with 💖 from Moodo App");
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
                          doa.arti!,
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
                            "Tentang Doa",
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
                                    "${doa.judul}\n\n${doa.arti}\n\nShared with 💖 from Moodo App");
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Text(
                          doa.tentang!,
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
                            "${doa.judul}\n\n${doa.lafaz}\n\nArtinya: ${doa.arti}\n\nTentang Doa: \n${doa.tentang}\n\nDisebarkan dengan sepenuh 💖 dari Moodo.\nInstall Moodo sekarang juga! https://ipb.link/get-moodo");
                      },
                      style: TextButton.styleFrom(primary: Colors.tealAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child:
                            Text("Share lafaz, arti, dan riwayat ${doa.judul}",
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
