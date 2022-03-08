import 'package:barry_callebaut/users/petugas/view/initial_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPagePetugas extends StatefulWidget {
  const RegisterPagePetugas({Key? key}) : super(key: key);

  @override
  _RegisterPagePetugasState createState() => _RegisterPagePetugasState();
}

class _RegisterPagePetugasState extends State<RegisterPagePetugas> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerIdNumber = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPass = TextEditingController();

  late bool _showPassword = true;
  late bool _showRePassword = true;
  final bool _isLoading = false;

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
      padding: const EdgeInsets.only(left: padding, right: padding, top: 30),
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
                "User Name",
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
                  controller: _controllerUsername,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration.collapsed(
                      border: InputBorder.none, hintText: 'Irwan Deku'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan User Name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Id Number",
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
                padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                child: TextFormField(
                  controller: _controllerIdNumber,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration.collapsed(hintText: '@34dekuirwan'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Id Number";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Enter Password",
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
                padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                child: TextFormField(
                  controller: _controllerPassword,
                  obscureText: _showPassword,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
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
                height: 16,
              ),
              const Text(
                "Re-enter Password",
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
                  controller: _controllerConfirmPass,
                  obscureText: _showRePassword,
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
                      onTap: toggleRePasswordVisibility,
                      child: _showRePassword
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
                      return "Masukkan Re-enter Password";
                    } else if (value != _controllerPassword.text) {
                      return "Password Tidak Sama";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              buttonRegister(),
            ],
          )),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void toggleRePasswordVisibility() {
    setState(() {
      _showRePassword = !_showRePassword;
    });
  }

  Widget buttonRegister() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kGreen),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      onPressed: register,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        width: double.infinity,
        height: 48,
        child: const Center(
          child: Text(
            'Register',
            style: TextStyle(color: kWhite, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Future<dynamic> register() async {
    if (!_isLoading) {
      if (_formKey.currentState!.validate()) {
        String idNumber = _controllerIdNumber.text;
        String email = "$idNumber@gmail.com";
        
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, password: _controllerPassword.text);

          User? user = FirebaseAuth.instance.currentUser;

          await FirebaseFirestore.instance
              .collection("petugas")
              .doc(user!.uid)
              .set({
            'uid': user.uid,
            'username': _controllerUsername.text,
            'email': email,
            'idNumber': idNumber
          });

          registerDialog();
        } catch (e) {
          return e.toString();
        }
      }
    }
  }

  registerDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.check_circle,
                  color: kGreen,
                  size: 72,
                ),
                SizedBox(
                  height: 16,
                ),
                Center(child: Text('Register Berhasil')),
              ],
            ),
            actions: [
              Center(
                  child: TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InitialPage()),
                          (route) => false),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: kGreen),
                      )))
            ],
          );
        });
  }
}
