import 'package:covid19_api/app/services/api_service.dart';
import 'package:flutter/material.dart';

import 'app/services/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Covid-19 Nubentos API 2.0.0'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _numOfCases,
    _todayCases,
    _deaths,
    _recovered,
    _critical,
    _active;

  void _updateAccessToken() async {
    final apiService = APIService(API.sandbox()); 
    final _accessToken = await apiService.getAccessToken();

    final values = await Future.wait([
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.cases
      ),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.todayCases
      ),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.deaths
      ),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.recovered
      ),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.critical
      ),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.active
      ),
    ]);

    
    setState(() => {
      _numOfCases = values[0],
      _todayCases = values[1],
      _deaths = values[2],
      _recovered = values[3],
      _critical = values[4],
      _active = values[5]
    });
    
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
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(
              'https://apimarket.nubentos.com/t/nubentos.com/registry/resource/_system/governance/apimgt/applicationdata/icons/owner-AT-nubentos.com/API-nCoV2019/2.0.0/icon',
              scale: 2,
              alignment: Alignment.topCenter
            ), 
            if (_numOfCases == null)
              Text(
                'Push refresh button:',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (_numOfCases != null) 
              Text(
                'Total of active cases: $_numOfCases',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (_todayCases != null) 
              Text(
                'Today cases: $_todayCases',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (_deaths != null) 
              Text(
                'Total of person death: $_deaths',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (_recovered != null) 
              Text(
                'Recovered cases: $_recovered',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (_critical != null) 
              Text(
                'Critical cases: $_critical',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (_active != null) 
              Text(
                'Active cases: $_active',
                style: Theme.of(context).textTheme.headline6,
              ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateAccessToken,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
