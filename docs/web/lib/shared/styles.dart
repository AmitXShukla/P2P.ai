import 'package:flutter/material.dart';

const cAppTitle = "Procure2Pay.ai";
const cAboutusTitle = "About us";

enum cMessageType { error, success }

const cNavColor = Colors.white;

const cTitleText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cNavText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cBodyText = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal);

const cNavRightText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);
const cErrorText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.red,
);
const cWarnText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.yellow,
);
const cSuccessText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.green,
);

const cHeaderText = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal);

const cHeaderWhiteText = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cHeaderDarkText = TextStyle(
    color: Colors.black26,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

var cThemeData = ThemeData(
  primaryColor: Colors.blue,
  //primarySwatch: Colors.white,
  backgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
);

class CustomNavDrawer extends StatelessWidget {
  //final bool toggleSpinner;
  const CustomNavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/docs/assets/images/drawerlogo.png'),
                // fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
            curve: Curves.easeIn,
            child: null,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.lime,
            ),
            title: const Text(
              'Home',
              style: cHeaderText,
            ),
            onTap: () => {Navigator.pushNamed(context, "/")},
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.greenAccent,
            ),
            title: Text(
              'Products',
              style: cHeaderText,
            ),
          ),
          const Text(
            "                       community",
            style: cNavRightText,
          ),
          const Text(
            "                       solutions",
            style: cNavRightText,
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.add_business_outlined,
              color: Colors.purpleAccent,
            ),
            title: Text(
              'Services',
              style: cHeaderText,
            ),
          ),
          const Text(
            "                       community",
            style: cNavRightText,
          ),
          const Text(
            "                       custom",
            style: cNavRightText,
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.animation,
              color: Colors.orange,
            ),
            title: Text(
              'AI',
              style: cHeaderText,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.business,
              color: Colors.blue,
            ),
            title: const Text(
              'About us',
              style: cHeaderText,
            ),
            onTap: () => {Navigator.pushNamed(context, "/aboutus")},
          ),
          const Text(
            "                       company",
            style: cNavRightText,
          ),
          const Text(
            "                       career",
            style: cNavRightText,
          ),
          const Text(
            "                       connect",
            style: cNavRightText,
          ),
        ],
      ),
    );
  }
}
