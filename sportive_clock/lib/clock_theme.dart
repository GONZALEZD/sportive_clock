/**
 * Copyright 2020 david.gonzalez.freelance@gmail.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import 'package:flutter/material.dart';

enum ClockType { analog, digital }

class ClockTheme {
  ClockTheme({this.primaryColor, this.backgroundColor, this.textStyle})
      : assert(primaryColor != null),
        assert(backgroundColor != null),
        assert(textStyle != null);

  final MaterialColor primaryColor;
  final MaterialColor backgroundColor;
  final TextStyle textStyle;

  static ClockTheme purpleTheme = ClockTheme(
      primaryColor: Colors.purple,
      backgroundColor: Colors.grey,
      textStyle: ThemeData.fallback().textTheme.body1.copyWith(
            fontSize: 18,
          ));

  static ClockTheme blueTheme = ClockTheme(
      primaryColor: Colors.lightBlue,
      backgroundColor: Colors.grey,
      textStyle: ThemeData.fallback().textTheme.body1.copyWith(
            fontSize: 18,
          ));

  bool isEqual(ClockTheme to) {
    return primaryColor == to.primaryColor &&
        backgroundColor == to.backgroundColor &&
        textStyle == to.textStyle;
  }

  TextStyle computeTextStyle(Brightness brightness) {
    return textStyle.copyWith(
        color: brightness == Brightness.light
            ? primaryColor[500]
            : primaryColor[300]);
  }
}

class ClockThemeWidget extends InheritedModel<ClockTheme> {
  final ClockTheme theme;
  final Brightness brightness;

  TextStyle textStyle() {
    return theme.computeTextStyle(brightness);
  }

  ClockThemeWidget({this.theme, this.brightness, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(ClockThemeWidget oldWidget) {
    return !theme.isEqual(oldWidget.theme);
  }

  @override
  bool updateShouldNotifyDependent(
      InheritedModel<ClockTheme> oldWidget, Set<ClockTheme> dependencies) {
    return updateShouldNotify(oldWidget);
  }

  static ClockThemeWidget of(BuildContext context, {ClockTheme theme}) {
    return InheritedModel.inheritFrom<ClockThemeWidget>(context, aspect: theme);
  }
}
