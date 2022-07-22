import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/models/non_data_model.dart';
import 'package:growth/screens/advisor_screen.dart';
import 'package:growth/screens/companies/companies_screen.dart';
import 'package:growth/screens/customers/customers_screen.dart';
import 'package:growth/screens/demo_screen.dart';
import 'package:growth/screens/leads/leads_screen.dart';
import 'package:growth/screens/lists/campaign/campaign_screen.dart';
import 'package:growth/screens/lists/kyc_screen.dart';
import 'package:growth/screens/lists/referer_logs/referer_screen.dart';
import 'package:growth/screens/lists/support_screen.dart';
import 'package:growth/screens/login_screen.dart';
import 'package:growth/screens/non_database_screen.dart';
import 'package:growth/screens/registers/registers_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
    _incrementCounter();
    callNonDAta();
  }

  String email = '';
  String name = '';
  int counter = 0;

  Future callNonDAta() async {
    var url = '...';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get('token');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var result = nonDataFromJson(response.body);
      setState(() {
        counter = result.licenseDetails.length;
      });
      return result;
    } catch (e) {
      print("HATA::" + e.toString());
    }
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email')!;
      name = prefs.getString('name')!;
    });
  }

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: ApplicationConstants.lacivert,
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 17,
                ),
                SizedBox(
                  child: Image.asset('assets/images/logo_w.png'),
                  width: 90,
                  height: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 10,
              indent: 20,
              endIndent: 20,
              thickness: 6,
              color: ApplicationConstants.mor,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  buildMenuItem(
                      text: "Kayıt",
                      icon: "assets/icons/id.png",
                      onClicked: () {
                        selectedItem(context, 0);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                      text: "Lead",
                      icon: "assets/icons/lead.png",
                      onClicked: () {
                        selectedItem(context, 1);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                      text: "Demolar",
                      icon: "assets/icons/demo.png",
                      onClicked: () {
                        selectedItem(context, 2);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                      text: "Müşteriler",
                      icon: "assets/icons/customers.png",
                      onClicked: () {
                        selectedItem(context, 3);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                      text: "Firmalar",
                      icon: "assets/icons/company.png",
                      onClicked: () {
                        selectedItem(context, 4);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                      text: "Müşavirler",
                      icon: "assets/icons/consultation.png",
                      onClicked: () {
                        selectedItem(context, 5);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NonDataBaseScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          width: 17,
                        ),
                        Badge(
                          child: Image.asset(
                            'assets/icons/database.png',
                            color: Colors.white,
                            fit: BoxFit.cover,
                            height: 25,
                            width: 25,
                          ),
                          badgeContent: Text(
                            counter.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 10),
                          ),
                          //showBadge: true,
                        ),
                        const SizedBox(width: 31),
                        const Text(
                          "Veri tabanı \noluşmayan lisanslar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // buildMenuItem(
                  //   text: "Görüşmeler",
                  //   icon: "assets/icons/phone.png",
                  //   onClicked: () {
                  //     selectedItem(context, 6);
                  //   },
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    child: PopupMenuButton(
                      child: Row(
                        children: const <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.list,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 33,
                          ),
                          Text(
                            'Listeler',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: TextButton(
                            child: const Text('Referer Logs',
                                style: TextStyle(
                                    color: ApplicationConstants.lacivert)),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RefererScreen(),
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: TextButton(
                            child: const Text(
                              'Kyc Listesi',
                              style: TextStyle(
                                  color: ApplicationConstants.lacivert),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KYCScreen(),
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: TextButton(
                            child: const Text('Kampanyalar',
                                style: TextStyle(
                                    color: ApplicationConstants.lacivert)),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampaignScreen(),
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: TextButton(
                            child: const Text('Arama Geçmişi',
                                style: TextStyle(
                                    color: ApplicationConstants.lacivert)),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupportScreen(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.only(left: 10),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                    text: "Çıkış Yap",
                    icon: "assets/icons/logout.png",
                    onClicked: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('token');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                      Fluttertoast.showToast(
                          fontSize: 12,
                          msg: 'BAŞARILI ÇIKIŞ',
                          timeInSecForIosWeb: 2,
                          textColor: Colors.white,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: ApplicationConstants.mor);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegistersScreen(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LeadsScreen(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DemoScreen(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CustomerScreen(),
          ),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompaniesScreen(),
          ),
        );
        break;
      case 5:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdvisorScreen(),
          ),
        );
        break;
      case 6:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const CallList(),
        //   ),
        // );
        break;
      case 7:
        _logout();
        break;
      case 8:
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: TextButton.icon(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                label: const Text('refererLogs'),
                onPressed: () => debugPrint('refererLogs b asıldı'),
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: TextButton.icon(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: const Text('kyc listesi'),
                  onPressed: () => debugPrint('kyc listesi basıldı')),
            ),
          ],
        );
        break;
    }
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }
}

Widget buildMenuItem({
  required String text,
  required String icon,
  required VoidCallback? onClicked,
}) {
  const color = Colors.white;
  const hoverColor = Colors.white70;

  return ListTile(
    leading: Image.asset(
      icon,
      color: Colors.white,
      fit: BoxFit.cover,
      height: 25,
      width: 25,
    ),
    title: Text(
      text,
      style: const TextStyle(
          color: color, fontSize: 14, fontWeight: FontWeight.bold),
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
