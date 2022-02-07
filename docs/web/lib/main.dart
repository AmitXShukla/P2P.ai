import 'dart:ui';

import 'package:flutter/material.dart';
import './shared/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: cAppTitle,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) => const MyHomePage(title: cAppTitle),
        // '/signup': (BuildContext context) => const SignUpPage(),
      },
      theme: ThemeData(primarySwatch: Colors.lime),
      home: const MyHomePage(title: cAppTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://amitxshukla.github.io/P2P.jl/assets/logo.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
              // decoration: BoxDecoration(
              //   color: Colors.lime,
              // ),
              curve: Curves.easeIn,
              child: Text(
                'P2P.ai',
                style: cTitleText,
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.menu_open),
        //   color: cNavColor,
        //   iconSize: 28.0,
        //   onPressed: () {
        //     PopupMenuButton(
        //       onSelected: (result) {
        //         setState(() {
        //           // _selection = result;
        //         });
        //       },
        //       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        //         const PopupMenuItem(
        //           value: "Home",
        //           child: Text('Home'),
        //         )
        //       ],
        //     );
        //   },
        // ),
        title: Text(widget.title, style: cTitleText),
        leadingWidth: 40,
        actions: [
          IconButton(
            icon: const Icon(Icons.contact_mail_rounded),
            color: cNavColor,
            iconSize: 28.0,
            onPressed: () {
              // Navigator.pushReplacementNamed(context, '/aboutus');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AboutUs()),
              // );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.album),
                    title: Text('The Enchanted Nightingale'),
                    subtitle:
                        Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('LISTEN'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
