import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared/styles.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/aboutus';
  // This widget is the about us page of your application.

  const AboutUs({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                cAboutusTitle,
                style: cNavText,
              ),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.arrow_upward,
                      color: Colors.deepPurple,
                    ),
                    text: "career",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.business,
                      color: Colors.brown,
                    ),
                    text: "company",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.connect_without_contact_outlined,
                      color: Colors.deepOrange,
                    ),
                    text: "connect",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: 60,
                          ),
                          title: Text(
                            'email your resume',
                            style: cNavText,
                          ),
                          subtitle: Text("career@elishconsulting.com",
                              style: cBodyText),
                          isThreeLine: false,
                          // trailing: Image(
                          //     image: NetworkImage(
                          //         "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ai_interceptor.png")),
                        )
                      ]),
                ),
                //company page
                Center(
                  child: Column(children: const [
                    ListTile(
                      leading: Icon(
                        Icons.indeterminate_check_box_outlined,
                        color: Colors.grey,
                        size: 60,
                      ),
                      title: Text(
                        '',
                        style: cNavText,
                      ),
                      subtitle: Image(
                          image: NetworkImage(
                              "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ab elish.jpg")),
                      isThreeLine: false,
                      // trailing: Image(
                      //     image: NetworkImage(
                      //         "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/resize.jpg")),
                    ),
                    SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.business_center,
                          color: Colors.orange,
                          size: 60,
                        ),
                        title: Text(
                          'About company',
                          style: cNavText,
                        ),
                        subtitle: Text(
                            "We proudly introduce us as IT Business Intelligence Consulting Company.\n\n We are one of the management and technology consulting companies. \n\n We are also primary developer and vendor for IT Software development and IT Services for small business solutions and as well as large enterprises. \n\n Elish Consulting is legally separate and independent entity operating through Delaware USA since 2008.",
                            style: cBodyText),
                        isThreeLine: false,
                        trailing: Image(
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/customLogo.jpg"))),
                    ListTile(
                      leading: Icon(
                        Icons.cloud_done_sharp,
                        color: Colors.green,
                        size: 60,
                      ),
                      title: Text(
                        'Business background',
                        style: cNavText,
                      ),
                      subtitle: Text(
                          "Elish Consulting own a range of Customized IT Products for different domains like Legal, Health, Media, Finance and Accounting, IT Services, Marketing and Sales, BPO operations etc.\n\n Elish Consulting has expertise in developing IT Solutions and services for commercial applications, mobile and device applications, IT staffing, Enterprise Application development and ERP consulting.\n\n Elish Consulting has all required professional experience and expertise to successfully design, develop, test and support any type of IT implementation, product development and business process outsourcing.\n\n Elish Consulting has plans to use their expertise and experience to expand and enhance its current business development initiatives and be involved into Software-as-Service business.\n\n This SAAS (Software-as-a-Service) program will allow this initiative to reach a broader customers and clients across geographic regions and use these services for a low cost and highest possible quality business solutions.",
                          style: cBodyText),
                      isThreeLine: false,
                      // trailing: Image(
                      //     image: NetworkImage(
                      //         "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/resize.jpg")),
                    ),
                  ]),
                ),
                // connect page
                Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: 60,
                          ),
                          title: Text(
                            'email us',
                            style: cNavText,
                          ),
                          subtitle: Text("info@elishconsulting.com",
                              style: cBodyText),
                          isThreeLine: false,
                          // trailing: Image(
                          //     image: NetworkImage(
                          //         "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ai_interceptor.png")),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.black38,
                            size: 60,
                          ),
                          title: Text(
                            'call us',
                            style: cNavText,
                          ),
                          subtitle: Text("+1-732-407-2527", style: cBodyText),
                          isThreeLine: false,
                          // trailing: Image(
                          //     image: NetworkImage(
                          //         "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ai_interceptor.png")),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.business,
                            color: Colors.blueGrey,
                            size: 60,
                          ),
                          title: Text(
                            'visit us',
                            style: cNavText,
                          ),
                          subtitle: Text(
                              "2711 Centerville Rd Wilmington DE 19808",
                              style: cBodyText),
                          isThreeLine: false,
                          // trailing: Image(
                          //     image: NetworkImage(
                          //         "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/ai_interceptor.png")),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
