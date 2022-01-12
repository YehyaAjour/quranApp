

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/model/login_response.dart';
import 'package:quranapp/services/DioHelper/dio_helper.dart';
import 'package:quranapp/services/endpoint/end_points.dart';
import 'package:quranapp/view/loginscreen/cubit/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginResponse loginResponse;
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility;
  bool isPassword = true;

  changePasswordVisability() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> userLogin(
      {@required String email, @required String password}) async {
    emit(LoginLoadingState());

    await DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {

      if(value.statusCode==200){
      loginResponse = LoginResponse.fromJson(value.data);
      emit(LoginSuccessState(loginResponse));}
      else if (value.statusCode>200){
        emit(LoginErrorState(value.data['message']));}


      //print(loginResponse.result);
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState("catch error "));
    });
  }

  //
  // Future<LoginResponse> userlogout() async {
  //   emit(LogoutLoadingState());
  //   await DioHelper.postData(
  //     url: LOGOUT,
  //   ).then((value) {
  //     print(value.data);
  //     emit(LogoutSuccessState());
  //   }).catchError((error) {
  //     emit(LogoutErrorState());
  //     print(error.toString());
  //   });
  // }
  Future<void> userLogout() async {
    emit(LogoutLoadingState());

    await DioHelper.postData(
      url: LOGOUT,
      // token: CacheHelper.getToken(key: 'token')
    ).then((value) {
      // loginResponse = LoginResponse.fromJson(value.data);
      //  print(loginResponse.result);
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutErrorState());
      print(error.toString());
    });
  }
}
