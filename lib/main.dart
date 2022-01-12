import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/services/CacheHelper/cache_helper.dart';

import 'package:quranapp/services/DioHelper/dio_helper.dart';
import 'package:quranapp/view/component/constants.dart';
import 'package:quranapp/view/layout/drawer.dart';
import 'package:quranapp/view/loginscreen/login_screen.dart';

import 'package:quranapp/view_model/AppStates/state.dart';
import 'package:quranapp/view_model/bloc_observer.dart';

import 'view_model/AppCupit/cubit.dart';

// "email": "shaker@admin.com",
//     "password": "!Q2w3e4r"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  token = CacheHelper.getToken(key: "token");
  if (token != null) {
    widget = DrawerScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (token != null) {
          return AppCubit()
            ..getInstructor()
            ..getStudent()
            ..getGroup();
        } else {
          return AppCubit();
        }
      },
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(),
            debugShowCheckedModeBanner: false,
            // builder: (context, child) {
            //   return Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: child,
            //   );
            // },
            title: 'Flutter Demo',
            home: startWidget,
          );
        },
      ),
    );
  }
}
