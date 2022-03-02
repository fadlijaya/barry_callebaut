import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class SensusPage extends StatefulWidget {
  const SensusPage({Key? key}) : super(key: key);

  @override
  _SensusPageState createState() => _SensusPageState();
}

class _SensusPageState extends State<SensusPage> {
  String titlePage = "Form Sensus";

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  int _activeStep = 0;
  final int _upperBound = 3;

  //form1
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerJekel = TextEditingController();
  final TextEditingController _controllerTempatLahir = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerStatus = TextEditingController();
  final TextEditingController _controllerPendidikan = TextEditingController();
  final TextEditingController _controllerStatusPendidikan = TextEditingController();

  //form2
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerDesa = TextEditingController();
  final TextEditingController _controllerKecamatan = TextEditingController();
  final TextEditingController _controllerKabupaten = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kGrey,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            children: [
              header(),
              iconStepper(),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: formstep())
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: padding),
      child: Center(
        child: Text(
          titlePage,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: kBlack),
        ),
      ),
    );
  }

  Widget iconStepper() {
    return IconStepper(
      icons: const [
        Icon(
          Icons.check,
          color: kWhite,
        ),
        Icon(
          Icons.check,
          color: kWhite,
        ),
        Icon(
          Icons.check,
          color: kWhite,
        ),
      ],
      activeStep: _activeStep,
      onStepReached: (index) {
        setState(() {
          _activeStep = index;
        });
      },
      stepRadius: 12,
      enableStepTapping: true,
      lineColor: kGreen,
      enableNextPreviousButtons: false,
    );
  }

  formstep() {
    switch (_activeStep) {
      case 0:
        return formSensus();
      case 1:
        return formSensus2();
      default:
    }
  }

  Widget formSensus() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerNama,
                        cursorColor: kGreen,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'Nama'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Nama";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerJekel,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'Jenis Kelamin'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Jenis Kelamin";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerTempatLahir,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'Tempat Lahir'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Tempat Lahir";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerTglLahir,
                        cursorColor: kGreen,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'Tanggal Lahir'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Tanggal Lahir";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerStatus,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'Status'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Status";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerPendidikan,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'Pendidikan'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Pendidikan";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerStatusPendidikan,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            hintText: 'Status Pendidikan'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Status Pendidikan";
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buttonNext(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget buttonNext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kGreen2),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
        onPressed: () {
          if (_activeStep < _upperBound) {
            setState(() {
              _activeStep++;
            });
          } else if (_activeStep > 0) {
            setState(() {
              setState(() {
                _activeStep--;
              });
            });
          }
        },
        child: const SizedBox(
          width: double.infinity,
          height: 48,
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(color: kWhite, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSensus2() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: padding),
              color: kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: double.infinity,
                height: 260,
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerAlamat,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: 'Alamat'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Alamat";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerDesa,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: 'Desa'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Desa";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerKecamatan,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Kecamatan'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Kecamatan";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerKabupaten,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Kabupaten'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Kabupaten";
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buttonSubmit(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kGreen2),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
        onPressed: () {
          if (_activeStep < _upperBound) {
            setState(() {
              _activeStep++;
            });
          }
        },
        child: const SizedBox(
          width: double.infinity,
          height: 48,
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(color: kWhite, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
