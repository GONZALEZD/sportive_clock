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

class TimeMarkerPainter extends CustomPainter {
  TimeMarkerPainter({
    @required this.lineWidth,
    @required this.markersColor,
    @required this.circleColor,
  })  : assert(lineWidth != null),
        assert(markersColor != null),
        assert(circleColor != null);

  double lineWidth;
  Color markersColor;
  Color circleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    double radius = min(size.width / 2, size.height / 2);
    // draw little watch lines
    Paint smallLine = new Paint()
      ..color = markersColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.lineWidth / 4;

    final offset1 = Offset(radius, 0);
    final offset2 = Offset(radius - this.lineWidth * 2, 0);
    canvas.translate(center.dx, center.dy);
    for (var i = 0; i < 12; i += 1) {
      canvas.drawLine(offset1, offset2, smallLine);
      canvas.rotate((pi * 2) / 12);
    }

    canvas.translate(-center.dx, -center.dy);
    smallLine.color = circleColor;
    canvas.drawCircle(center, radius + 1, smallLine);
  }

  @override
  bool shouldRepaint(TimeMarkerPainter oldDelegate) {
    return oldDelegate.lineWidth != lineWidth ||
        oldDelegate.markersColor != markersColor ||
        oldDelegate.circleColor != circleColor;
  }
}
