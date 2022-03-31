import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:husbh_app/screens/home_page.dart';
import '../widgets/back_arrow.dart';
import '../widgets/check_if_email_used.dart';
import '../widgets/my_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _passwordVisible = false;
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
                  vertical: 24,
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
                              height: height * 0.65,
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
                                            hintText: 'أدخل الإيميل',
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
                                          title: 'التالي',
                                          onPressed: () async {
                                            if (_email.text == '' ||
                                                _pass.text == '') {
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
                                                    'قم بإدخال البيانات لإكمال التسجيل',
                                                showCloseIcon: true,
                                              ).show();
                                            } // end of if (_email.text == '' ||  _pass.text == '')

                                            else {
                                              if (_pass.text.length < 6) {
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
                                                      'يجب أن تكون كلمة السر أكثر من 6 أحرف/أرقام',
                                                  showCloseIcon: true,
                                                ).show();
                                              } // end of if (_pass.text.length < 6)
                                              else {
                                                print('Done');
                                                bool check =
                                                    await checkIfEmailInUse(
                                                        _email.text);
                                                if (check == false) {
                                                  await FirebaseAuth.instance
                                                      .createUserWithEmailAndPassword(
                                                          email: _email.text,
                                                          password: _pass.text);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrationScreenSecond(
                                                              em: _email.text,
                                                              pass: _pass.text,
                                                            )),
                                                  );
                                                } // end of if check == false --> not used
                                                else {
                                                  AwesomeDialog(
                                                    //if there is missing info this will be displayed
                                                    context: context,
                                                    dialogType:
                                                        DialogType.ERROR,
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
                                                        'البريد الإلكتروني مستخدم من قبل',
                                                    showCloseIcon: true,
                                                  ).show();
                                                }
                                              }
                                              ;
                                            }
                                          },
                                          startColor: Colors.amber,
                                          endColor: Colors.amber.shade400,
                                          borderColor:
                                              Color.fromARGB(255, 231, 162, 0),
                                          textColor: Colors.brown.shade600
                                          //     startColor: Colors.lightBlue,
                                          // endColor: Colors.lightBlue[300]!,
                                          // borderColor: Colors.lightBlue[700]!,
                                          // textColor: Colors.white
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
                            padding: const EdgeInsets.symmetric(vertical: 18),
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

class RegistrationScreenSecond extends StatefulWidget {
  final String em;
  final String pass;

  const RegistrationScreenSecond(
      {Key? key, required this.em, required this.pass})
      : super(key: key);

  @override
  State<RegistrationScreenSecond> createState() =>
      _RegistrationScreenSecondState();
}

class _RegistrationScreenSecondState extends State<RegistrationScreenSecond> {
  TextEditingController _childName = TextEditingController();

  late int _selectedIndex = 8;
  List<String> _options = [
    '٢',
    '٣ ',
    '٤',
    '٥',
    '٦',
    '٧',
    '+۸',
  ];

  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ReadexPro',
            )),
        elevation: 3,
        pressElevation: 5,
        backgroundColor: Colors.grey[500],
        selectedColor: Colors.lightGreen,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(choiceChip);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown.shade100,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //                 <--- border radius here
              ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: chips,
          ),
        ),
      ),
    );
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
                  vertical: 24,
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
                              vertical: 60,
                            ),
                            child: BlurryContainer(
                              borderRadius: BorderRadius.circular(20),
                              bgColor: Colors.lime.shade50,
                              blur: 0,
                              height: height * 0.75,
                              width: width * 0.6,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 42),
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
                                          controller: _childName,
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 20),
                                              child: Icon(Icons.person),
                                            ),
                                            fillColor: Colors.white60,
                                            filled: true,
                                            hintText: ' اسم طفلك',
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
                                      Text(
                                        "عمر طفلك",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'ReadexPro',
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      _buildChips(),
                                      SizedBox(height: 11),
                                      Column(
                                        children: [
                                          MyButton(
                                              title: 'التالي',
                                              onPressed: () {
                                                (_selectedIndex == 8 ||
                                                        _childName.text == '')
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
                                                                Radius.circular(
                                                                    2)),
                                                        headerAnimationLoop:
                                                            false,
                                                        animType: AnimType
                                                            .BOTTOMSLIDE,
                                                        title: '! تنبيه',
                                                        desc:
                                                            'قم بإدخال البيانات لإكمال التسجيل',
                                                        showCloseIcon: true,
                                                      ).show()
                                                    : //else
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegistrationScreenThird(
                                                                  em: widget.em,
                                                                  pass: widget
                                                                      .pass,
                                                                  chName:
                                                                      _childName
                                                                          .text,
                                                                  age: _options[
                                                                      _selectedIndex],
                                                                )),
                                                      );
                                              },
                                              startColor: Colors.amber,
                                              endColor: Colors.amber.shade400,
                                              borderColor: Color.fromARGB(
                                                  255, 231, 162, 0),
                                              textColor: Colors.brown.shade600
                                              //       startColor: Colors.cyan,
                                              // endColor: Colors.cyan[400]!,
                                              // borderColor: Colors.cyan[300]!,
                                              // textColor: Colors.brown
                                              ),
                                        ],
                                      )
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
                              height: 90,
                              width: 90,
                              child: Container(),
                            ),
                          ),
                        ),
                        Align(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            width: 110,
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

class RegistrationScreenThird extends StatefulWidget {
  final String em; // the email of the child
  final String pass; // the password of the child
  final String chName; // the password of the child
  final String age; // the age of the child

  const RegistrationScreenThird(
      {Key? key,
      required this.em,
      required this.pass,
      required this.chName,
      required this.age})
      : super(key: key);

  @override
  State<RegistrationScreenThird> createState() =>
      _RegistrationScreenThirdState(age);
}

class _RegistrationScreenThirdState extends State<RegistrationScreenThird> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String age;
  int _value = 2;

  _RegistrationScreenThirdState(this.age);
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
                                        "جنس طفلك",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'ReadexPro',
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  setState(() => (_value = 0)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: _value == 0
                                                      ? Colors.blue[100]
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color:
                                                        Colors.brown.shade100,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          30.0) //                 <--- border radius here
                                                      ),
                                                ),
                                                height: 100,
                                                width: 120,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 57,
                                                        child: Image.asset(
                                                            'images/husbh_boy.png'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 3),
                                                        child: Text(
                                                          'ولد',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'ReadexPro',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 14),
                                          Container(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  setState(() => (_value = 1)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: _value == 1
                                                      ? Colors.pink[100]
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color:
                                                        Colors.brown.shade100,
                                                    width: 2,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          30.0) //                 <--- border radius here
                                                      ),
                                                ),
                                                height: 100,
                                                width: 120,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        child: Image.asset(
                                                            'images/husbh_girl.png'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5),
                                                        child: Text(
                                                          'بنت',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'ReadexPro',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      MyButton(
                                          title: 'التالي',
                                          onPressed: () async {
                                            if (_value == 2) {
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
                                                    'قم باختيار جنس طفلك لإكمال التسجيل',
                                                showCloseIcon: true,
                                              ).show();
                                            } else {
                                              final FirebaseAuth auth =
                                                  FirebaseAuth.instance;
                                              void inputData() {
                                                final User? user =
                                                    auth.currentUser;
                                                final uid = user!.uid;
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.uid)
                                                    .set({
                                                  'name': widget.chName,
                                                  'age': widget.age,
                                                  'sex': _value == 0
                                                      ? 'boy'
                                                      : 'girl',
                                                  'email': user.email,
                                                });
                                              }

                                              inputData();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          home_page()));
                                            }
                                            ;
                                          },
                                          startColor: Colors.amber,
                                          endColor: Colors.amber.shade400,
                                          borderColor:
                                              Color.fromARGB(255, 231, 162, 0),
                                          textColor: Colors.brown.shade600
                                          //   startColor: Colors.cyan,
                                          // endColor: Colors.cyan[400]!,
                                          // borderColor: Colors.cyan[300]!,
                                          // textColor: Colors.brown
                                          )
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
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: BlurryContainer(
                              borderRadius: BorderRadius.circular(100),
                              bgColor: Colors.lime.shade50,
                              blur: 1,
                              height: 90,
                              width: 90,
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
