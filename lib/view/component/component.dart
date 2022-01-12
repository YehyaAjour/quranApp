import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType keyboardType,
  @required Function validate,
  @required String labelText,
  @required InputBorder inputBorder,
  @required Color fillBoxColor,
  Function onchange,
  IconData prefix,
  Color prefixColor,
  Function prefixPressed,
  Widget suffix,
  bool isPassword = false,
  Function suffixPressed,
}) {
  return TextFormField(
    onChanged: onchange,
    validator: validate,
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isPassword,
    decoration: InputDecoration(
      //  contentPadding: EdgeInsets.symmetric(vertical: 0),
      filled: true,
      fillColor: fillBoxColor,
      labelText: labelText,
      suffixIcon: suffix != null ? suffix : null,
      prefixIcon: prefix != null
          ? IconButton(
              onPressed: prefixPressed,
              icon: Icon(
                prefix,
                color: prefixColor == null ? Color(0xff009EF7) : prefixColor,
              ),
            )
          : null,
      border: inputBorder,
    ),
  );
}

Widget defaultButton({
  @required Function function,
  @required String title,
  @required Color buttonColor,
  @required Color textColor,
  double width,
}) {
  return Container(
    height: 40,
    width: width != null ? width : double.infinity,
    child: ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            buttonColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ))),
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 15),
      ),
    ),
  );
}

Widget defaultButtonWithImage(
    {@required Function function,
    @required String imgUrl,
    @required String title,
    @required Color buttonColor,
    @required Color textColor}) {
  return Container(
    height: 40,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            buttonColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgUrl,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
        ],
      ),
    ),
  );
}

void showToast({
  @required String message,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
  }
  return color;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
