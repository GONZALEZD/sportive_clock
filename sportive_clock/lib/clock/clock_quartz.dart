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

import 'package:sportive_clock/clock/digital_clock.dart';
import 'package:sportive_clock/clock/analog_clock.dart';

import 'package:flutter/material.dart';

import 'package:flutter_clock_helper/model.dart';

import 'package:sportive_clock/clock_theme.dart';

class ClockQuartz extends StatefulWidget {
  const ClockQuartz(this.type, this.model);

  final ClockModel model;
  final ClockType type;

  @override
  _ClockQuartzState createState() => _ClockQuartzState();
}

class _ClockQuartzState extends State<ClockQuartz> {
  var _now = DateTime.now();

  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(ClockQuartz oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {});
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget clock;
    switch (this.widget.type) {
      case ClockType.analog:
        clock = AnalogClock(widget.model, _now);
        break;
      case ClockType.digital:
        clock = DigitalClock(widget.model, _now);
        break;
    }
    return clock;
  }
}
