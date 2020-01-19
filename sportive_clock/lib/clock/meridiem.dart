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
import 'package:sportive_clock/clock_theme.dart';

enum Meridiem { am, pm }

class MeridiemWidget extends StatelessWidget {
  MeridiemWidget({this.meridiem});

  final Meridiem meridiem;

  @override
  Widget build(BuildContext context) {
    ClockTheme theme = ClockThemeWidget.of(context).theme;
    int darkerColor = 0;
    if (ClockThemeWidget.of(context).brightness == Brightness.dark) {
      darkerColor = 500;
    }
    TextStyle textStyle = ClockThemeWidget.of(context).textStyle();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
      decoration: BoxDecoration(
        color: theme.backgroundColor[200 + darkerColor],
        border: Border.all(
            color: theme.backgroundColor[400 + darkerColor], width: 1),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Text(
        meridiemToString(),
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }

  String meridiemToString() {
    String string;
    switch (meridiem) {
      case Meridiem.am:
        string = "AM";
        break;
      case Meridiem.pm:
        string = "PM";
        break;
    }
    return string;
  }
}
