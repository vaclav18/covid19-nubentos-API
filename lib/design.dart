import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('App Name'),
          bottom:
            new TabBarView(
              children: <Widget>[
                new TabBar(tabs: <Widget>[new Text("text"), new Text("text 2")],
                ),
    
                new TabBar(tabs: <Widget>[new Text("text"), new Text("text 2")],
                ),
    
                new TabBar(tabs: <Widget>[new Text("text"), new Text("text 2")],
                )
              ]
    
            ),
    
          ),
        body: new Scaffold(
            body:
              new Container(
                child:
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new ListView(
                      )
                    ]
    
                  ),
    
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
              ),
    
          );,
    
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add_circle),
          onPressed: fabPressed),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              title: new Text('Title'),
            ),
    
            new BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              title: new Text('Title'),
            ),
    
            new BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              title: new Text('Title'),
            )
          ]
    
        ),
      );
    }
    void fabPressed() {}
    
}