import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:quranapp/services/CacheHelper/cache_helper.dart';
import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view/layout/drawer.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';

import 'package:quranapp/view_model/AppStates/state.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                if (state.loginResponse.result.success) {
                  CacheHelper.saveData(
                          key: 'token',
                          value: state.loginResponse.result.data.accessToken)
                      .then((value) {
                    AppCubit.get(context).getInstructor();
                    AppCubit.get(context).getStudent();
                    AppCubit.get(context).getGroup();
                    navigateAndFinish(context, DrawerScreen());
                  });
                  showToast(
                      message: state.loginResponse.result.message,
                      state: ToastState.SUCCESS);
                }
              } else if (state is LoginErrorState) {
                showToast(message: state.error, state: ToastState.ERROR);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/shatiby.png',
                                  height: 90,
                                  width: 90,
                                ),
                                Text(
                                  "مركز الإمام الشاطبي",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 5.5,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "صفحة تسجيل الدخول",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "البريد الإلكتروني",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      defaultTextFormField(
                                        fillBoxColor: Color(0xfff4f8fb),
                                        inputBorder: InputBorder.none,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return "يجب أن لا يكون البريد الإلكتروني فارغ";
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        labelText: "",
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "كلمة المرور",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "نسيت كلمة المرور",
                                              style: TextStyle(
                                                color: Colors.green[300],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      defaultTextFormField(
                                        fillBoxColor: Color(0xfff4f8fb),
                                        inputBorder: InputBorder.none,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return "يجب أن لا تكون كلمة السر فارغة";
                                          }
                                          return null;
                                        },
                                        controller: passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        labelText: "",
                                        suffix: IconButton(
                                          onPressed: () {
                                            LoginCubit.get(context)
                                                .changePasswordVisability();
                                          },
                                          icon: Icon(
                                            LoginCubit.get(context).suffix,
                                            color: Colors.green[300],
                                          ),
                                        ),
                                        isPassword:
                                            LoginCubit.get(context).isPassword,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ConditionalBuilder(
                                        condition: state is! LoginLoadingState,
                                        builder: (context) {
                                          return defaultButton(
                                              function: () async {
                                                await LoginCubit.get(context).userLogin(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text
                                                    // email: emailController.text,
                                                    // password: passwordController
                                                    //     .text
                                                    );
                                              },
                                              // function: () {
                                              //   if (formKey.currentState
                                              //       .validate()) {
                                              //     LoginCubit.get(context).userLogin(
                                              //         email: emailController.text,
                                              //         password:
                                              //             passwordController.text);
                                              //   }
                                              // },
                                              title: "متابعة",
                                              buttonColor: Colors.green[400],
                                              textColor: Colors.white);
                                        },
                                        fallback: (context) => Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "حول",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "اتصل بنا",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
