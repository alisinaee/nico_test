import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  String fa_text = "نام کاربری";
  String en_text = "user name";
  var currentLang = "EN";

  String userName = "";

  @override
  void initState() {
    super.initState();
    //print('initstate');
    parsJsonLang(selectdLang: "FA");
  }

  Future parsJsonLang({String selectdLang = "EN"}) async {
    if (selectdLang == "EN") {
      String data =
          await DefaultAssetBundle.of(context).loadString("lang/en.json");
      final enLang = json.decode(data);

      setState(() {
        userName = enLang["user_name"];
      });
      
    } else {
      String data =
          await DefaultAssetBundle.of(context).loadString("lang/fa.json");
      final faLang = json.decode(data);
      setState(() {
        userName = faLang["user_name"];
      });
    }
    print(userName);

    //print(jsonResult['user_name']);
  }

  Future<Model> fetchAlbum() async {
    final response = await http
        .get('http://kohmartapi.nicode.org/api/Ads/GetAdsByFilterByPage');

    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      return Model.fromJson(parsed);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void selectLang(String lang) {
    /* setState(() {
      currentLang = lang;
    }); */

    parsJsonLang(selectdLang: lang);
  }

  Function showDialog(int pageIndex, BuildContext context) {
    print(pageIndex);
    if (pageIndex == 2) {
      return showAlertDialog(context, selectLang);
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Center(child: Text('NICO')),
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () => {},
        ),
        actions: [
          Row(
            children: [
              //Text(currentLang == "EN" ? en_text : fa_text),
              Text(userName),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                    child: Image.network(
                  'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50',
                  fit: BoxFit.cover,
                  width: 40.0,
                  height: 40.0,
                )),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.language, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
          showDialog(index, context);
        },
      ),
      body: FutureBuilder<Model>(
        future: fetchAlbum(),
        builder: (BuildContext context, AsyncSnapshot<Model> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.object.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Card(
                        color: Colors.white60,
                        child: ListTile(
                          leading: FlutterLogo(size: 72.0),
                          title: Text(snapshot.data.object[index].title),
                          subtitle:
                              Text(snapshot.data.object[index].description),
                          trailing: Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  })
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context, Function selectLang) {
  Widget faButton = FlatButton(
    child: Text("FA"),
    onPressed: () {
      selectLang("FA");
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  Widget enButton = FlatButton(
    child: Text("EN"),
    onPressed: () {
      selectLang("EN");
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("language"),
    content: Text("select language : "),
    actions: [
      enButton,
      faButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
