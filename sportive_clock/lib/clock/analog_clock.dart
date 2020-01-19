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

import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';

import 'package:sportive_clock/clock_theme.dart';

import 'package:vector_math/vector_math_64.dart' show radians;

import 'painter/clock_background.dart';
import 'painter/bezel_hand.dart';
import 'painter/hand.dart';
import 'painter/time_markers.dart';
import 'package:sportive_clock/clock/meridiem.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);


class AnalogClock extends StatelessWidget {
  const AnalogClock(this.model, this.time);

  final ClockModel model;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return createBackground(context, time);
  }

  Stack createBackground(BuildContext context, DateTime time) {
    ClockTheme theme = ClockThemeWidget.of(context).theme;
    Brightness brightness = ClockThemeWidget.of(context).brightness;
    int darkColor = 0, darkerColor = 0;
    if (brightness == Brightness.dark) {
      darkColor = 400;
      darkerColor = 600;
    }
    TextStyle textStyle = ClockThemeWidget.of(context).textStyle();
    return Stack(
      children: <Widget>[
        wrapPainter(ClockBackgroundPainter(
          lineWidth: 6.0,
          innerColor: theme.backgroundColor[200 + darkColor],
          outerColor: theme.backgroundColor[100 + darkerColor],
        )),
        wrapPainter(BezelHandPainter(
          lineWidth: 6.0,
          seconds: time.second,
          color: theme.primaryColor[200 + darkerColor],
        )),
        wrapPainter(TimeMarkerPainter(
            lineWidth: 6.0,
            markersColor: theme.backgroundColor[400],
            circleColor: theme.backgroundColor[200 + darkerColor])),
        wrapPainter(HandPainter(
          color: theme.primaryColor[300],
          lineWidth: 6,
          handSize: 0.8,
          angleRadians: time.minute * radiansPerTick,
        )),
        wrapPainter(HandPainter(
          color: theme.primaryColor[600],
          lineWidth: 6,
          handSize: 0.5,
          angleRadians: time.hour * radiansPerTick,
        )),
        textClock("12", textStyle, Alignment.topCenter),
        textClock("3", textStyle, Alignment.centerRight),
        textClock("6", textStyle, Alignment.bottomCenter),
        textClock("9", textStyle, Alignment.centerLeft),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MeridiemWidget(
                meridiem: time.hour < 12 ? Meridiem.am : Meridiem.pm),
          ),
        )
      ],
    );
  }

  Widget textClock(String text, TextStyle style, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Center(
          child: Text(text, style: style),
        ),
      ),
    );
  }

  Widget wrapPainter(CustomPainter painter) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SizedBox.expand(
        child: CustomPaint(
          painter: painter,
        ),
      ),
    );
  }
}
