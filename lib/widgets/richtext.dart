import 'package:flutter/material.dart';

Widget richtext(String text1,String text2,double fontsize1,var color2, {@required var color1}){

  return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: text1,
            style: TextStyle(
              fontSize: fontsize1,
              color: color1,
            )),
        TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: fontsize1,
              color: color2,
            )),
      ]));
}