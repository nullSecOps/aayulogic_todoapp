import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/extension/extension.dart';
import 'package:todoapp/auth/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  bool isNotVisible = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> signIn() async {
    try {
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if (response.user!.uid.isNotEmpty) {
        ScaffoldMessenger.maybeOf(context)!.showSnackBar(
            const SnackBar(content: Text('Logged in Successfully')));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(
          const SnackBar(content: Text('Incorrect login details')));
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder myBorderStyle = const OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(15)));
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                  top: 140,
                ),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome Back !',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.only(top: 150),
                  // height: 160,
                  // color: Colors.red,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter email";
                              } else if (!value!.validateEmail()) {
                                return "input a valid email";
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                label: const Text(
                                  'Email',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                focusedBorder: myBorderStyle,
                                focusedErrorBorder: myBorderStyle,
                                enabledBorder: myBorderStyle,
                                errorBorder: myBorderStyle)),
                        const SizedBox(
                          height: 10,
                        ),
                        // TextFormField(
                        //   onFieldSubmitted: (value) {
                        //     FocusScope.of(context).nextFocus();
                        //   },
                        //   // focusNode: f1,
                        //   validator: (value) {
                        //     if (!(value ?? '').validatePhone()) {
                        //       return 'insert valid phone';
                        //     }
                        //   },
                        //   keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //       prefixIcon: const Icon(Icons.phone),
                        //       label: const Text(
                        //         'Phone',
                        //         style: TextStyle(color: Colors.grey),
                        //       ),
                        //       errorBorder: myBorderStyle,
                        //       focusedBorder: myBorderStyle,
                        //       enabledBorder: myBorderStyle),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // focusNode: f2,

                          controller: password,
                          obscureText: isNotVisible,
                          decoration: InputDecoration(
                              suffixIcon: password.text.isEmpty
                                  ? const Icon(FontAwesomeIcons.lock)
                                  : const Icon(FontAwesomeIcons.unlock),
                              prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isNotVisible = !isNotVisible;
                                    });
                                  },
                                  icon: isNotVisible
                                      ? const Icon(
                                          FontAwesomeIcons.eyeSlash,
                                          size: 20,
                                        )
                                      : const Icon(
                                          FontAwesomeIcons.eye,
                                          size: 20,
                                        )),
                              label: const Text(
                                'password',
                                style: TextStyle(color: Colors.grey),
                              ),
                              focusedBorder: myBorderStyle,
                              focusedErrorBorder: myBorderStyle,
                              errorBorder: myBorderStyle,
                              enabledBorder: myBorderStyle),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                    .copyWith(top: 15),
                width: double.infinity,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        signIn();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Register(),
                            ));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: const Color.fromARGB(255, 4, 100, 178),
                                decoration: TextDecoration.underline),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: const Color.fromARGB(255, 4, 100, 178),
                              decoration: TextDecoration.underline),
                        )),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
