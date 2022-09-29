import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:husbh_app/screens/new_password.dart';
import '../widgets/check_if_email_used.dart';
import '../widgets/my_button.dart';
import '../widgets/back_arrow.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  //TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
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
                        BackArrow(),
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
                                      Text(
                                        'سيتم إسال رسالة الى بريدك الالكتروني تحتوي على رابط لاعادة ضبط كلمة المرور',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'ReadexPro',
                                        ),
                                      ),
                                      SizedBox(height: 20),
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
                                          //validator: (email) => email != null && !EmailValidator.validate(email) ? 'enter valid email' : null,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      MyButton(
                                          title: 'إعادة ضبط كلمة المرور',
                                          onPressed: () async {
                                            if (_email.text == '') {
                                              AwesomeDialog(
                                                //if there is missing info this will be displayed
                                                context: context,
                                                dialogType: DialogType.WARNING,
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
                                                    'قم بإدخال البيانات لإكمال العملية',
                                                showCloseIcon: true,
                                              ).show();
                                            } else {
                                              bool check =
                                                  await checkIfEmailInUse(
                                                      _email.text);
                                              if (_email.text.length > 0 &&
                                                  check == true) {
                                                print('Done');
                                                await FirebaseAuth.instance
                                                    .sendPasswordResetEmail(
                                                  email: _email.text,
                                                );
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewPassword()),
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
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  title: '! تنبيه',
                                                  desc:
                                                      'البريد الإلكتروني غير صحيح',
                                                  showCloseIcon: true,
                                                ).show();
                                              }
                                            }

                                            print('Successfull');
                                          },
                                          startColor: Colors.amber,
                                          endColor: Colors.amber.shade400,
                                          borderColor:
                                              Color.fromARGB(255, 231, 162, 0),
                                          textColor: Colors.brown.shade600),
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

  // Future resetPassword() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: _email.text.trim());
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  // }
}
