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
import 'package:flutter_clock_helper/model.dart';
import 'package:sportive_clock/clock_theme.dart';
import 'package:sportive_clock/clock/meridiem.dart';

import 'package:intl/intl.dart' as intl;
import 'dart:core';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model, this.time);

  final ClockModel model;
  final DateTime time;

  @override
  State<StatefulWidget> createState() => DigitalClockState();
}

class DigitalClockState extends State<DigitalClock> {
  _TextSize __textSize;

  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return buildClockText(context, constraints.maxWidth);
    }));
  }

  Widget buildClockText(BuildContext context, double maxWidth) {
    ClockTheme theme = ClockThemeWidget.of(context).theme;
    String format = "HH:mm";
    Widget meridiem = Container(
      width: 0,
      height: 0,
    );

    final String text = intl.DateFormat(format).format(widget.time);
    final String textSeconds = intl.DateFormat("ss").format(widget.time);
    final textSize =
        calculateAutoscaleFontSize("25:55ss", theme.textStyle, 30.0, maxWidth);
    TextStyle style = ClockThemeWidget.of(context).textStyle();
    if (this.__textSize == null ||
        (this.__textSize.fontSize - textSize.fontSize).abs() > 10) {
      this.__textSize = textSize;
    }

    if (!widget.model.is24HourFormat) {
      format = "hh:mm";
      meridiem = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: MeridiemWidget(
            meridiem: widget.time.hour < 12 ? Meridiem.am : Meridiem.pm),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(alignment: Alignment.bottomRight, child: meridiem),
        RichText(
            text: TextSpan(
                style: style.copyWith(fontSize: this.__textSize.fontSize),
                children: [
              TextSpan(text: text),
              TextSpan(
                  text: textSeconds,
                  style:
                      style.copyWith(fontSize: this.__textSize.fontSize / 2)),
            ]))
      ],
    );
  }

  _TextSize calculateAutoscaleFontSize(
      String text, TextStyle style, double startFontSize, double maxWidth) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    var currentFontSize = startFontSize;

    int increment = 2;
    for (var i = 0; i < 100; i += increment) {
      // limit max iterations to 100
      final nextFontSize = currentFontSize + increment;
      final nextTextStyle = style.copyWith(fontSize: nextFontSize);
      textPainter.text = TextSpan(text: text, style: nextTextStyle);
      textPainter.layout();
      if (textPainter.width >= maxWidth) {
        break;
      } else {
        currentFontSize = nextFontSize;
        // continue iteration
      }
    }
    return _TextSize(paintSize: textPainter.size, fontSize: currentFontSize);
  }
}

class _TextSize {
  _TextSize({this.paintSize, this.fontSize});

  final Size paintSize;
  final double fontSize;
}
