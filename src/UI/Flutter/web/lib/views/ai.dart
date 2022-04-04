import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/styles.dart';

class AI extends StatefulWidget {
  static const routeName = '/ai';
  // This widget is the about us page of your application.

  const AI({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AIState createState() => _AIState();
}

class _AIState extends State<AI> {
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
              icon: const Icon(Icons.contact_mail_rounded),
              color: cNavColor,
              iconSize: 28.0,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
        body: DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                cAITitle,
                style: cNavText,
              ),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.brown,
                    ),
                    text: "snippets",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.build_circle_outlined,
                      color: Colors.deepPurple,
                    ),
                    text: "process",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.list,
                      color: Colors.deepOrange,
                    ),
                    text: "AI List",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: const [
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/screenshot_1.png")),
                        // ListTile(
                        //   title: Text(
                        //     '',
                        //     style: cNavText,
                        //   ),
                        //   subtitle: Text(""),
                        //   // isThreeLine: false,
                        //   trailing: Image(
                        //       image: NetworkImage(
                        //           "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/screenshot_1.png")),
                        // ),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/screenshot_2.png")),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/screenshot_3.png")),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/screenshot_4.png")),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/screenshot_5.png")),
                      ]);
                    },
                  ),
                ),
                //process page
                Center(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: const [
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/Application_Process.png")),
                      ]);
                    },
                  ),
                ),
                // ail list
                Center(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: const [
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ai_list.png")),
                      ]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
