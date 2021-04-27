import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:moodo/model/dzikir.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/detailDzikirPage.dart';
import 'package:recase/recase.dart';

class ListDzikirPage extends StatefulWidget {
  final String dzikirVar;
  ListDzikirPage({
    required this.dzikirVar,
  });
  @override
  _ListDzikirPageState createState() => _ListDzikirPageState(this.dzikirVar);
}

class _ListDzikirPageState extends State<ListDzikirPage> {
  final ScrollController controller = ScrollController();
  List<Dzikir>? dzikirList;
  bool _isInit = true;

  final String dzikirVar;

  Future<void> fetchDzikir(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/dzikir.json');
    dzikirList = dzikirFromJson(jsonstring);
    _isInit = false;
  }

  _ListDzikirPageState(this.dzikirVar);

  @override
  Widget build(BuildContext context) {
    final _controller = ScrollController();
    return Scaffold(
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Dzikir " + dzikirVar.titleCase,
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: _isInit ? fetchDzikir(context) : null,
                      builder: (context, _) {
                        if (dzikirList != null) {
                          return CupertinoScrollbar(
                            child: ListView.builder(
                                itemCount: dzikirList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Dzikir dzikir = dzikirList![index];
                                  if (dzikir.waktu.toString() ==
                                      dzikirVar.toLowerCase())
                                    return _itemList(index);
                                  else
                                    return Container();
                                }),
                          );
                        } else
                          return Container();
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _itemList(index) {
    Dzikir dzikir = dzikirList![index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GradientText(
                dzikir.judul!,
                gradient: Style().gradasi,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              "Dibaca ${dzikir.dibaca}",
              style: Style(styleColor: Colors.grey.shade600).body,
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      dzikir.lafaz!,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 24),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => DetailDzikirPage(
                                  dzikir: dzikir,
                                )),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GradientText(
                        "Baca selengkapnya",
                        gradient: Style().gradasi,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
