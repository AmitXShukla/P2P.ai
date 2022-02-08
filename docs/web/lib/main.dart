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
                      'https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/drawerlogo.png'),
                  // fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
              // decoration: BoxDecoration(
              //   color: Colors.lime,
              // ),
              curve: Curves.easeIn,
              child: Text(
                cAppTitle,
                style: cTitleText,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.production_quantity_limits_rounded,
                color: Colors.greenAccent,
              ),
              title: Text(
                'Products',
                style: cHeaderText,
              ),
            ),
            Text(
              "                       community",
              style: cNavRightText,
            ),
            Text(
              "                       solutions",
              style: cNavRightText,
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.add_business_outlined,
                color: Colors.purpleAccent,
              ),
              title: Text(
                'Services',
                style: cHeaderText,
              ),
            ),
            Text(
              "                       community",
              style: cNavRightText,
            ),
            Text(
              "                       custom",
              style: cNavRightText,
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.animation,
                color: Colors.orange,
              ),
              title: Text(
                'AI',
                style: cHeaderText,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.business,
                color: Colors.blue,
              ),
              title: Text(
                'About us',
                style: cHeaderText,
              ),
            ),
            Text(
              "                       company",
              style: cNavRightText,
            ),
            Text(
              "                       career",
              style: cNavRightText,
            ),
            Text(
              "                       connect",
              style: cNavRightText,
            ),
          ],
        ),
      ),
      appBar: AppBar(
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
                  Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                              leading: Icon(
                                Icons.assessment,
                                color: Colors.pinkAccent,
                                size: 60,
                              ),
                              title: Text(
                                'your live AI assistant',
                                style: cNavText,
                              ),
                              subtitle: Text(
                                  "P2P.ai acts as live assistant, which learns your inputs. AI renders live predictive analytics results through REST API, which help business user make quick informed decisions.",
                                  style: cBodyText),
                              isThreeLine: true,
                              trailing: Image(
                                  image: NetworkImage(
                                      "https://amitxshukla.github.io/P2P.jl/images/p2p_business_process.png"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                    'powered by elishconsulting.com'),
                                onPressed: () {/* ... */},
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                            height: 20,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.bluetooth,
                              color: Colors.blueAccent,
                            ),
                            title: Text(
                              'no one knows your data better than you',
                              style: cNavText,
                            ),
                            subtitle: Text(
                                "connect live to learned AI, trained through years of ERP learning experience at your fingertip.",
                                style: cHeaderText),
                            isThreeLine: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('use on-premise knowledge'),
                                onPressed: () {/* ... */},
                              ),
                            ],
                          ),
                          Container(
                              width: 600,
                              height: 400,
                              child: Image(
                                  image: NetworkImage(
                                      "https://amitxshukla.github.io/P2P.jl/images/p2p_business_process.png"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                    'powered by elishconsulting.com'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
                              // TextButton(
                              //   child: const Text('LISTEN'),
                              //   onPressed: () {/* ... */},
                              // ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
