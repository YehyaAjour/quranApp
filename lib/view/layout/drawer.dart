import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/widgets.dart';
import 'package:quranapp/services/CacheHelper/cache_helper.dart';
import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view/loginscreen/login_screen.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';

import 'package:quranapp/view_model/AppStates/state.dart';

class DrawerScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var searchByNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: SafeArea(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: SizedBox(
                  width: 250,
                  child: Drawer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          DrawerHeader(
                              child: Container(
                            child: FlutterLogo(
                              size: 50,
                              curve: Curves.fastOutSlowIn,
                              style: FlutterLogoStyle.markOnly,
                            ),
                          )),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // ListTile(
                                  //   title: Text(
                                  //     "المحفظين",
                                  //     style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 15,
                                  //     ),
                                  //   ),
                                  //   onTap: () {
                                  //     AppCubit.get(context).changeIndex(0);
                                  //     AppCubit.get(context).getInstructor();
                                  //     Navigator.pop(context);
                                  //   },
                                  // ),
                                  // Divider(
                                  //   color: Colors.grey,
                                  // ),
                                  // ListTile(
                                  //   title: Text(
                                  //     "الطلاب",
                                  //     style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 15,
                                  //     ),
                                  //   ),
                                  //   onTap: () {
                                  //     AppCubit.get(context).changeIndex(1);
                                  //     AppCubit.get(context).getStudent();
                                  //     Navigator.pop(context);
                                  //   },
                                  // ),
                                  // Divider(
                                  //   color: Colors.grey,
                                  // ),
                                  ListTile(
                                    trailing: Icon(Icons.logout),
                                    title: Text(
                                      "تسجيل الخروج",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onTap: () async {
                                      await AppCubit.get(context).userLogout();
                                      CacheHelper.removeData(key: 'token')
                                          .then((value) {
                                        if (value) {
                                          navigateAndFinish(
                                              context, LoginScreen());
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              height: 60,
              animationDuration: Duration(milliseconds: 500),
              items: [
                Column(
                  children: [
                    SvgPicture.asset("assets/icons/education.svg",
                        height: 30, width: 30, semanticsLabel: 'Acme Logo'),
                    Text(
                      "المحفظين",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset("assets/icons/crowd.svg",
                        height: 30, width: 30, semanticsLabel: 'yehya'),
                    Text(
                      "الحلقات",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset("assets/icons/reading.svg",
                        height: 30, width: 30, semanticsLabel: 'yehya'),
                    Text(
                      "الطلاب",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
              backgroundColor: Colors.white,
              color: Colors.green[400],
              buttonBackgroundColor: Colors.transparent,
              index: AppCubit.get(context).currentIndex,
              onTap: (int value) {
                AppCubit.get(context).changeIndex(value);
              },
            ),
            body: AppCubit.get(context)
                .drawerScreen[AppCubit.get(context).currentIndex],
          ),
        );
      },
    );
  }
}
