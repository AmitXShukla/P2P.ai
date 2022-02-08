import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web/views/aboutus.dart';
import 'package:web/views/ai.dart';
import './shared/styles.dart';
import 'package:url_launcher/url_launcher.dart';

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
        '/aboutus': (BuildContext context) => const AboutUs(title: cAppTitle),
        '/ai': (BuildContext context) => const AI(title: cAppTitle),
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
  // ignore: unused_field
  late Future<void> _launched;
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavDrawer(),
      appBar: AppBar(
        title: Text(widget.title, style: cTitleText),
        leadingWidth: 40,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_fullscreen_sharp),
            color: cNavColor,
            iconSize: 28.0,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
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
                                Icons.electrical_services,
                                color: Colors.pink,
                                size: 60,
                              ),
                              title: Text(
                                'your live AI assistant',
                                style: cNavText,
                              ),
                              subtitle: Text(
                                  "P2P.ai acts as an live assistant. As user input data, search over Items or browse through Supply chain documents in ERP or any on-premise/cloud applications, AI learns your input (non-invasive by all means). AI doesn't store any input and respect all ethical privacy contraints. based on user's inputs, AI renders live predictive analytics results through secure REST API, which help business user evaluate, understand, compare results and make quick informed decisions immediatly.",
                                  style: cBodyText),
                              isThreeLine: false,
                              trailing: Image(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ai_interceptor.png"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                  child: const Text(
                                      'powered by elishconsulting.com'),
                                  onPressed: () => _launched = _launchInBrowser(
                                      'http://www.elishconsulting.com/')),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                            height: 20,
                          ),
                          const ListTile(
                              leading: Icon(
                                Icons.bubble_chart_rounded,
                                color: Colors.orange,
                                size: 60,
                              ),
                              title: Text(
                                'no one knows your data better than you',
                                style: cNavText,
                              ),
                              subtitle: Text(
                                  "Your database not only keeps live transactions, it is knowledge encylopedia. There is no other better intelligence than your database itself. All P2P.ai does is, train on your wealth of data, learns years of your business experience and produces learned experience prediction results, at your fingertip.",
                                  style: cHeaderText),
                              isThreeLine: true,
                              trailing: Image(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/Online-Lead-Generation2.jpg"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('use on-premise knowledge'),
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
                                Icons.mark_chat_read,
                                color: Colors.grey,
                                size: 60,
                              ),
                              title: Text(
                                'query on-premise data with market insights',
                                style: cNavText,
                              ),
                              subtitle: Text(
                                  "Often users use guided learning in procurement. P2P.ai learns, each item on supply chain voucher or purchase order and prepare a live guided learning based on on-premise historical data set comparing directly with open market. This guided learning experinece, let users manage CRM, Sales, Finance, Supply Chain Procure to Pay, inventory operations with complete visibility.",
                                  style: cHeaderText),
                              isThreeLine: true,
                              trailing: Image(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/CRM & Sales Analytics.jpg"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('guided market insights'),
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
                                Icons.analytics_rounded,
                                color: Colors.blueAccent,
                                size: 60,
                              ),
                              title: Text(
                                'Predictive analytical results',
                                style: cNavText,
                              ),
                              subtitle: Text(
                                  "operation intelligence information readily available to make quick, effective decisions with confidence. User can trust on P2P.ai framework. P2P.ai periodically self-train itself based on behind the scene AutoML mechanism. You can trust P2P.ai to produce results on frequently trained machine learning models.",
                                  style: cHeaderText),
                              isThreeLine: true,
                              trailing: Image(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/BI1.jpg"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('operational intelligence'),
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
                                Icons.search_sharp,
                                color: Colors.redAccent,
                                size: 60,
                              ),
                              title: Text(
                                'fast search results',
                                style: cNavText,
                              ),
                              subtitle: Text(
                                  "search for Items, Purchase orders, DocCART or all Finance & SCM related information. P2P.ai uses Oracle Cloud ODI, Julia Lang Distributed Parallel GPU computing and state of the art REST APIs to query your on-premise data based on elastic search.",
                                  style: cHeaderText),
                              isThreeLine: true,
                              trailing: Image(
                                  image: NetworkImage(
                                      "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/finance_banne1r.jpg"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('search on campus first'),
                                onPressed: () {/* ... */},
                              ),
                            ],
                          ),
                          // Container(
                          //     width: 600,
                          //     height: 400,
                          //     child: Image(
                          //         image: NetworkImage(
                          //             "https://amitxshukla.github.io/P2P.jl/images/p2p_business_process.png"))),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: <Widget>[
                          //     TextButton(
                          //       child: const Text(
                          //           'powered by elishconsulting.com'),
                          //       onPressed: () {/* ... */},
                          //     ),
                          //     const SizedBox(width: 8),
                          //     // TextButton(
                          //     //   child: const Text('LISTEN'),
                          //     //   onPressed: () {/* ... */},
                          //     // ),
                          //     const SizedBox(width: 8),
                          //   ],
                          // ),
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
