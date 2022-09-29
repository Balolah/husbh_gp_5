import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:husbh_app/screens/home_page.dart';
import 'package:husbh_app/screens/reset_password.dart';
import '../widgets/check_if_email_used.dart';
import '../widgets/my_button.dart';
import 'rigster_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import '../widgets/back_arrow.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _passwordVisible = false;

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 90,
                            ),
                            child: BlurryContainer(
                              borderRadius: BorderRadius.circular(20),
                              bgColor: Colors.lime.shade50,
                              blur: 0,
                              height: height * 0.7,
                              width: width * 0.6,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 35),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        child: TextField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _email,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white60,
                                            filled: true,
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 20),
                                              child: Icon(Icons.email),
                                            ),
                                            hintText: 'أدخل البريد الإلكتروني',
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'ReadexPro',
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 20,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.orange,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        child: TextField(
                                          obscureText: !_passwordVisible,
                                          controller: _pass,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  // Based on passwordVisible state choose the icon
                                                  _passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                                onPressed: () {
                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                  setState(
                                                    () {
                                                      _passwordVisible =
                                                          !_passwordVisible;
                                                    },
                                                  );
                                                }),
                                            fillColor: Colors.white60,
                                            filled: true,
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 20),
                                              child: Icon(Icons.lock),
                                            ),
                                            hintText: 'أدخل كلمة السر',
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'ReadexPro',
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 20,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.orange,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      MyButton(
                                          title: 'تسجيل دخول',
                                          onPressed: () async {
                                            (_email.text == '' ||
                                                    _pass.text == '')
                                                ? AwesomeDialog(
                                                    //if there is missing info this will be displayed
                                                    context: context,
                                                    dialogType:
                                                        DialogType.WARNING,
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                    width: 280,
                                                    buttonsBorderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(2)),
                                                    headerAnimationLoop: false,
                                                    animType:
                                                        AnimType.BOTTOMSLIDE,
                                                    title: '! تنبيه',
                                                    desc:
                                                        'قم بإدخال البيانات لإكمال التسجيل',
                                                    showCloseIcon: true,
                                                  ).show()
                                                : //else
                                                print('Successfull');
                                            bool check =
                                                await checkIfEmailInUse(
                                                    _email.text);
                                            if (_pass.text.length > 0 &&
                                                _email.text.length > 0 &&
                                                check == true) {
                                              print('Done');
                                              await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: _email.text,
                                                      password: _pass.text);

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        home_page()),
                                              );
                                            } else {
                                              AwesomeDialog(
                                                //if there is missing info this will be displayed
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 2),
                                                width: 280,
                                                buttonsBorderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(2)),
                                                headerAnimationLoop: false,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: '! تنبيه',
                                                desc:
                                                    'البريد الإلكتروني أو كلمة السر غير صحيحة',
                                                showCloseIcon: true,
                                              ).show();
                                            }
                                          },
                                          startColor: Colors.amber,
                                          endColor: Colors.amber.shade400,
                                          borderColor:
                                              Color.fromARGB(255, 231, 162, 0),
                                          textColor: Colors.brown.shade600),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ليس لديك حساب؟',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'ReadexPro',
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegistrationScreen()),
                                              );
                                            },
                                            child: const Text(
                                              'سجل الآن',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'ReadexPro',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //NEW!! REST PASSWORD
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'نسيت كلمة المرور؟',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'ReadexPro',
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResetPassword()),
                                              );
                                            },
                                            child: const Text(
                                              'إعادة ضبط كلمة المرور',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'ReadexPro',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: BlurryContainer(
                              borderRadius: BorderRadius.circular(100),
                              bgColor: Colors.lime.shade50,
                              blur: 1,
                              height: 110,
                              width: 110,
                              child: Container(),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 125,
                            child: Image.asset('images/logo.PNG'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
