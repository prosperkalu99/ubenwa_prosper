import 'package:flutter/material.dart';


extension NavigatorStateExtextsion on BuildContext {
  NavigatorState get nav => Navigator.of(this);
}

extension ThemeDataExtextsion on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension MediaQueryDataExtextsion on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}