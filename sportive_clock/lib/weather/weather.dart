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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sportive_clock/clock_theme.dart';

class Weather extends StatelessWidget {
  Weather({this.location, this.forecast});

  final String location;
  final WeatherCondition forecast;

  String imageName() {
    String image = "";
    switch (forecast) {
      case WeatherCondition.windy:
        image = "windy.svg";
        break;
      case WeatherCondition.cloudy:
        image = "cloudy.svg";
        break;
      case WeatherCondition.foggy:
        image = "foggy.svg";
        break;
      case WeatherCondition.rainy:
        image = "rainy.svg";
        break;
      case WeatherCondition.snowy:
        image = "snowy.svg";
        break;
      case WeatherCondition.sunny:
        image = "sunny.svg";
        break;
      case WeatherCondition.thunderstorm:
        image = "thunderstorm.svg";
        break;
    }

    return "assets/forecast/$image";
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = ClockThemeWidget.of(context).textStyle();
    Color svgColor = style.color;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
              child: SvgPicture.asset(
                imageName(),
                fit: BoxFit.contain,
                color: svgColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(location, style: style),
        )
      ],
    );
  }
}
