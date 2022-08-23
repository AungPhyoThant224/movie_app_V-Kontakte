import 'package:flutter/material.dart';

class Colors{
  static const Color mainColor = const Color(0xFF576DE0);
  static const Color backgroundColor = const Color(0xFFFFFFFF);
  static const Color textFieldColor = const Color(0xFFE3F1FF);
  static const Color textFieldColor1 = const Color(0xFFFFFFFF);
  static const Color cardColor = const Color(0xFFFFFFFF);
  static const Color cardColor1 = const Color(0xFF576DE0);
  static const Color textColor1 = const Color(0xFFFFFFFF);
  static const Color textColor2 = const Color(0xFF202020);
  static const Color textColor3 = const Color(0xFF757575);
  static const Color labelColor = const Color(0xFF9E9E9E);
  static const Color borderColor = const Color(0xFFA6ACAF);
  static const Color borderColor1 = const Color(0xFF0062BD);
  static const Color errorColor = const Color(0xFFF44336);
  static const Color iconColor = const Color(0xFFFFFFFF);
  static const Color iconColor1 = const Color(0xFF0062BD);
}

final InputDecoration textField = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(5, 14, 10, 14),
  errorMaxLines: 2,
  fillColor: Colors.textFieldColor,
  errorStyle: TextStyle(
    fontFamily: 'FiraSans',
  ),
  // filled: true,
  hintStyle: TextStyle(
    color: Colors.labelColor,
    fontFamily: 'FiraSans',
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.borderColor,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.borderColor1,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.errorColor
    )
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.errorColor
    )
  )
);

final InputDecoration textField1 = InputDecoration(
  contentPadding: EdgeInsets.all(14),
  errorMaxLines: 2,
  fillColor: Colors.textFieldColor1,
  errorStyle: TextStyle(
    fontFamily: 'FiraSans',
  ),
  filled: true,
  hintStyle: TextStyle(
    color: Colors.labelColor,
    fontFamily: 'FiraSans',
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.borderColor
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.borderColor,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.errorColor
    )
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.errorColor
    )
  )
);

final InputDecoration textField2 = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(9, 0, 9, 0),
  errorMaxLines: 2,
  errorStyle: TextStyle(
    fontFamily: 'FiraSans',
  ),
  filled: true,
  hintStyle: TextStyle(
    fontFamily: 'FiraSans',
  ),
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.errorColor
    )
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.errorColor
    )
  )
);
