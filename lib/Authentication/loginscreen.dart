import 'package:evyan_emporia_shop_app/Authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen .dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _emailTapped = false;
  bool _passwordTapped = false;
  bool _isLoading = false;
  var _text = '';

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();

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



  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  //
  // @override
  // void dispose(){
  //   _emailTextController.dispose();
  //   _passTextController.dispose();
  //   super.dispose();
  //
  // }

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(90.0),
      color: Colors.indigo.shade900,
      child: SizedBox(
        width: 120,
        child: MaterialButton(
         // minWidth: MediaQuery.of(context).size.width,
         // padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const HomeScreen();
            }));
          },
          child: Text("𝕷𝖔𝖌𝖎𝖓",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.normal)),
        ),
      ),
    );

    final signUpButton = SizedBox(
        width: 400,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              ' Do not have account ? ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SignUp();
                }));
              },
              child: Text(
                'Signup',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo.shade900),
              ),
            ),
          ],
        ));

    return SafeArea(
      child: Scaffold(
        body: Form(
          key : _formKey,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: AnimatedContainer(
              height: MediaQuery.of(context).size.height,
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
                    Colors.red,
                    Colors.red.shade50,
                    Colors.lightBlueAccent,
                    Colors.indigo.shade50,
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
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
                                fontSize: 50,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            // selectionWidthStyle: ,
                            obscureText: false,
                            style: const TextStyle(fontSize: 15),
                            controller: _emailTextController,
                            onChanged: (text) => setState(() => _text),
                            // validator: (value) {
                            //   if (value!.isEmpty ||
                            //       !RegExp(r"^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                            //           .hasMatch(value)) {
                            //     return "Invalid Email";
                            //   }
                            //   return null;
                            // },
                            onTap: (){
                              _emailTapped= true;
                              _passwordTapped=false;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0.0, 30.0, 50.0, 12.0),
                                prefixIcon: const Icon(Icons.person_outline),
                                hintText: "Email ",
                                errorText: _errorTextEmail,
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 20.0,
                                    ),
                                    borderRadius: BorderRadius.circular(25.0))),
                          ),

                        ),
                        const SizedBox(height: 25.0),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _passTextController,
                            obscureText: true,
                            style: const TextStyle(fontSize: 15),
                            // validator: (value) {
                            //   if (value!.length < 6) {
                            //     return "Password is too short";
                            //   }
                            //   if (value.isEmpty) {
                            //     return "Password is Empty";
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 25.0, 20.0, 15.0),
                                hintText: " Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                errorText: _errorTextPassword,
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 20.0,
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20
                        ),
                        loginButton,
                        signUpButton,
                        const SizedBox(height: 80),
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
                                    color: Colors.orange.shade900),
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
          ),
        ),
      ),
    );
  }
}
