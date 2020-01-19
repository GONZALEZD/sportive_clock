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
import 'dart:math';

class ClockBackgroundPainter extends CustomPainter {
  ClockBackgroundPainter({
    @required this.lineWidth,
    @required this.innerColor,
    @required this.outerColor,
  })  : assert(lineWidth != null),
        assert(innerColor != null),
        assert(outerColor != null);

  double lineWidth;
  Color innerColor;
  Color outerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    double radius = min(size.width / 2, size.height / 2);

    Paint circle = new Paint()
      ..color = innerColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, circle);

    Paint line = new Paint()
      ..color = outerColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.lineWidth;
    canvas.drawCircle(center, radius - this.lineWidth / 2, line);
  }

  @override
  bool shouldRepaint(ClockBackgroundPainter oldDelegate) {
    return oldDelegate.lineWidth != lineWidth ||
        oldDelegate.innerColor != innerColor ||
        oldDelegate.outerColor != outerColor;
  }
}
