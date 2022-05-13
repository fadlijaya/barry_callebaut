import 'package:barry_callebaut/users/petugas/view/home/home_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPagePetugas extends StatefulWidget {
  const LoginPagePetugas({Key? key}) : super(key: key);

  @override
  _LoginPagePetugasState createState() => _LoginPagePetugasState();
}

class _LoginPagePetugasState extends State<LoginPagePetugas> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerIdPetugas = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  late bool _showPassword = true;
  late final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kGrey,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              formLogin(),
            ],
          ),
        ),
      )),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/logo.svg",
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Barry Callebaut",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 25, color: kBlack6),
          )
        ],
      ),
    );
  }

  Widget formLogin() {
    return Container(
      width: double.infinity,
      height: 542,
      padding: const EdgeInsets.only(left: padding, right: padding, top: 60),
      decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Id Petugas",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kGrey2),
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 12,
                ),
                child: TextFormField(
                  controller: _controllerIdPetugas,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration.collapsed(
                      hintText: '@34restuwidya'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Id Petugas";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kGrey2),
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 12,
                ),
                child: TextFormField(
                  controller: _controllerPassword,
                  obscureText: _showPassword,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'xxxxxxx',
                    border:
                        const UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        const UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        const UnderlineInputBorder(borderSide: BorderSide.none),
                    errorBorder:
                        const UnderlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: GestureDetector(
                      onTap: togglePasswordVisibility,
                      child: _showPassword
                          ? const Icon(
                              Icons.visibility_off,
                              color: kGrey5,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: kGrey5,
                            ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Password";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textLupaPassword(),
              const SizedBox(
                height: 24,
              ),
              buttonLogin(),
            ],
          )),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget textLupaPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          "Lupa Password?",
          style: TextStyle(color: kGreen, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget buttonLogin() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kGreen),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      onPressed: login,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        width: double.infinity,
        height: 48,
        child: const Center(
          child: Text(
            'Login', 
            style: TextStyle(color: kWhite, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Future<dynamic> login() async {
    final String idPetugas = _controllerIdPetugas.text.trim();
    final String email = '$idPetugas@gmail.com';
    final String password = _controllerPassword.text.trim();

    if (!_isLoading) {
      if (_formKey.currentState!.validate()) {
        displaySnackBar('Mohon Tunggu..');

        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          // ignore: unnecessary_null_comparison
          if (user != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            //print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            //print('Wrong password provided for that user.');
          }
        }
      }
    }
  }

  displaySnackBar(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
