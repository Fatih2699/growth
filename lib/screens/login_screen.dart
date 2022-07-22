import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growth/common_widgets/login_widget.dart';
import 'package:growth/constants/app_constant.dart';
import 'package:growth/screens/registers/registers_screen.dart';
import 'package:growth/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email, _password, _code;
  final _formKey = GlobalKey<FormState>();

  Future<void> _formSubmit() async {
    _formKey.currentState!.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      await _userModel.login(_email!, _password!, _code!);
      SharedPreferences _pref = await SharedPreferences.getInstance();
      var token = _pref.getString('token');
      if (token == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
        Fluttertoast.showToast(
            fontSize: 12,
            msg: 'HATALI GİRİŞ',
            timeInSecForIosWeb: 2,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ApplicationConstants.mor);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistersScreen(),
          ),
        );
        debugPrint('LOGİN OLDU');
      }
    } on PlatformException catch (hata) {
      debugPrint(hata.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: LoginWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/logo.svg',
                height: MediaQuery.of(context).size.height / 15,
                //height: 50,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Giriş Yap",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF142348),
                      fontSize: 28),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(labelText: "Kullanıcı Kod"),
                        onSaved: (String? girilenCode) {
                          _code = girilenCode;
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(labelText: "Kullanıcı Email"),
                        onSaved: (String? girilenEmail) {
                          _email = girilenEmail;
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(labelText: "Şifre"),
                        onSaved: (String? girilenPassword) {
                          _password = girilenPassword;
                        },
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _formSubmit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 16,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5c59ef),
                        Color(0xFF04d1aa),
                      ],
                    ),
                  ),
                  child: const Text(
                    "GİRİŞ YAP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
