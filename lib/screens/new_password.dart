import 'package:flutter/material.dart';
import 'package:husbh_app/screens/login_screen.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../widgets/my_button.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // width of screen
    double height = MediaQuery.of(context).size.height; // height of screen

    return Scaffold(
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
                      //BackArrow(),
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
                                      'تم إرسال رسالة إلى بريدك الالكتروني، الرجاء التجقق منه',
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
                                      child: MyButton(
                                          title: 'تسجيل دخول',
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          },
                                          startColor: Colors.amber,
                                          endColor: Colors.amber.shade400,
                                          borderColor:
                                              Color.fromARGB(255, 231, 162, 0),
                                          textColor: Colors.brown.shade600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
