import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Auth/cubit/auth_cubit.dart';
import 'package:flutter_mt/source/widget/custom_banner.dart';
import 'package:flutter_mt/source/widget/custom_button.dart';
import 'package:flutter_mt/source/widget/custom_button2.dart';
import 'package:flutter_mt/source/widget/custom_loading.dart';
import 'package:flutter_mt/source/widget/custom_text_field.dart';
import 'package:flutter_mt/source/widget/custom_text_field_pass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool pass = true;
  void showPass() {
    setState(() {
      pass = !pass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomLoading();
                });
          }
          if (state is LoginLoaded) {
            Navigator.pop(context);
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              final materialBanner = MyBanner.bannerSuccess("Success !");
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(materialBanner);
            } else {
              final materialBanner = MyBanner.bannerFailed(json['source']);
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(materialBanner);
            }
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    child: Image.asset(
                      "assets/icon.png",
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Maintenance App",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Color(0xFF0F4C75)),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1.3,
                          blurRadius: 1.3,
                          offset: Offset(2, 3),
                        )
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            "Selamat Datang",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 24),
                          CustomFormField(
                            controller: controllerEmail,
                            hint: "Masukan Email Anda",
                            label: "Email",
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),
                          CustomTextFieldPass(
                            controller: controllerPassword,
                            hint: "Masukan Password Anda",
                            label: "Password",
                            showPass: showPass,
                            iconPass: pass,
                          ),
                          const SizedBox(height: 50),
                          CustomButton(
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).login(context, controllerEmail.text, controllerPassword.text);
                              if (formKey.currentState!.validate()) {}
                            },
                            text: "LOGIN",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text(
                        "IT DEPARTEMENT | PT SIPATEX PUTRI LESTARI",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
