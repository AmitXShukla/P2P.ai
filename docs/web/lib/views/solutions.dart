import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/styles.dart';

class Solutions extends StatefulWidget {
  static const routeName = '/solutions';
  // This widget is the about us page of your application.

  const Solutions({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SolutionsState createState() => _SolutionsState();
}

class _SolutionsState extends State<Solutions> {
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
                cProductTitle,
                style: cNavText,
              ),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.brown,
                    ),
                    text: "custom",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.build_circle_outlined,
                      color: Colors.deepPurple,
                    ),
                    text: "solutions",
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
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/Elish_Products-Services2.bmp.jpg")),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ERD.png")),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/Application_Process_bkp.png")),
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
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/p2p_business_process.png")),
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
