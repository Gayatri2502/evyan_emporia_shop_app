import 'package:evyan_emporia_shop_app/Authentication/loginscreen.dart';
import 'package:evyan_emporia_shop_app/screens/home_screen%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool _emailTapped = false;
  bool _passwordTapped = false;
  bool _isLoading = false;
  var _text = "";


  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  String? get _errorTextEmail {
    @override
    void initState() {
      super.initState();
    }

    final emailText = _emailTextController.value.text;
    final emailRegExpression = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (_emailTapped && emailText.isEmpty) {
      return 'Can\'t be empty';
    }
    if (_emailTapped && !emailRegExpression.hasMatch(emailText)) {
      return 'Invalid Email Address';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextPassword {
    @override
    void initState() {
      super.initState();
    }

    final passText = _passTextController.value.text;

    if (_passwordTapped && passText.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void hideLoadingIndicator() {
    Navigator.of(context).pop();
  }

  void showErrorMessage(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      showLoadingIndicator();

      print("Signup called");

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passTextController.text)
          .then((value) async {
        await FirebaseDatabase.instance
            .ref()
            .child('Users')
            .child(value.user!.uid)
            .set({
          "Email": _emailTextController.text,
          "Password": _passTextController.text
        }).then((value) {
          print("query 2");
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(90.0),
      color: Colors.indigo.shade600,
      child: SizedBox(
        width: 120,
        child: MaterialButton(
          // minWidth: MediaQuery.of(context).size.width,
          // padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {

            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return LoginPage();
            }));

            //_signup();
          },
          child: Text("𝔖𝔦𝔤𝔫𝔘𝔭",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );

    final loginButton = SizedBox(
        width: 400,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              ' Already have an account ? ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Text(
                'Log In ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo.shade900),
              ),
            )
          ],
        ));

    return SafeArea(
      child: Scaffold(
          body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics:  const ClampingScrollPhysics(),
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        opacity: 0.35,
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv9sWDzG8PRF3Lwg6eIjoFzn9Xn6wCx8Hqwg&usqp=CAU"),
                        fit: BoxFit.cover),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.shade50,
                        Colors.lightBlueAccent,
                        Colors.red.shade50,
                        Colors.red
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.teal,

                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubicEmphasized,
                  child: Column(
                    children: [
                   
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "logo collection/6365189.png",
                            ),
                            const SizedBox(
                              width: 400,
                              height: 100,
                              child: Center(
                                child: Text(
                                  '𝓔𝓿𝔂𝓪𝓷 𝓔𝓶𝓹𝓸𝓻𝓲𝓪',
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                // selectionWidthStyle: ,
                                obscureText: false,
                                style: const TextStyle(fontSize: 15),
                                controller: _emailTextController,
                                onChanged: (text)=> setState(()=> _text),
                                onTap: (){
                                  _emailTapped = true;
                                  _passwordTapped = false;
                                },
                                keyboardType:  TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: const Icon(Icons.person_outline),
                                  hintText: "Email ",
                                  errorText:  _errorTextEmail,
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 40),
                                      borderRadius: BorderRadius.circular(20.0)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                obscureText: true,
                                style: const TextStyle(fontSize: 15),
                                controller: _passTextController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    hintText: "Password",
                                    errorText: _errorTextPassword,
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 20),
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                obscureText: true,
                                style: const TextStyle(fontSize: 15),
                                controller: _confirmPassController,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Confirm Password",
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white, width:40),
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                              width: 5.0,
                            ),
                            signUpButton,
                            loginButton,
                            const SizedBox(height:50),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  ' By proceeding you agree to Evyan Emporia ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const LoginPage()));
                                  },
                                  child: Text(
                                    'Privacy policy, Terms & conditions ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
}
