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

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:sportive_clock/clock_builder.dart' as builder;

import 'package:sportive_clock/clock_theme.dart';

void main() {
  runApp(ClockCustomizer((ClockModel model) {
    return builder.ClockBuilder(ClockType.analog, model, ClockTheme.purpleTheme)
//      ..display = builder.ClockDisplay.clockLeft
//          ..showTemperature = false
//      ..showWeather = false
        ;
  }));
}
