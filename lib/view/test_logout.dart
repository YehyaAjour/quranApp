import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/services/CacheHelper/cache_helper.dart';

import 'component/component.dart';
import 'loginscreen/cubit/cubit.dart';
import 'loginscreen/cubit/state.dart';
import 'loginscreen/login_screen.dart';


class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
                child: ElevatedButton(
              onPressed: () async {
                await LoginCubit.get(context).userLogout();
                CacheHelper.removeData(key: 'token').then((value) {
                  if (value) {
                    navigateAndFinish(context, LoginScreen());
                  }
                });
              },
              child: Text("Logout"),
            )),
          );
        },
      ),
    );
  }
}
