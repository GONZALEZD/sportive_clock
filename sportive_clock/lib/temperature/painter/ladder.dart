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

class LadderPainter extends CustomPainter {
  LadderPainter({
    @required this.lineWidth,
    @required this.color,
    @required this.backgroundColor,
    @required this.nbMarkers,
    @required this.currentPercent,
  })  : assert(lineWidth != null),
        assert(color != null),
        assert(nbMarkers != null),
        assert(nbMarkers >= 2),
        assert(currentPercent != null);

  double lineWidth;
  Color color;
  Color backgroundColor;
  int nbMarkers;
  double currentPercent;

  @override
  void paint(Canvas canvas, Size size) {
    Paint lines = new Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.lineWidth;

    // draw markers
    Offset p1 = Offset(0, 0);
    Offset p2 = Offset(0, size.height);
    canvas.drawLine(p1, p2, lines);
    double offset = size.height / 4;
    double xStep = size.width / (this.nbMarkers - 1);
    for (int i = 1; i < this.nbMarkers; i++) {
      p1 = Offset(i * xStep, offset);
      p2 = Offset(i * xStep, size.height - offset);
      canvas.drawLine(p1, p2, lines);
    }
    p1 = Offset(size.width, 0);
    p2 = Offset(size.width, size.height);
    canvas.drawLine(p1, p2, lines);

    // draw current marker
    lines.color = color;
    p1 = Offset(size.width * this.currentPercent, 0);
    p2 = Offset(size.width * this.currentPercent, size.height);
    canvas.drawLine(p1, p2, lines);
  }

  @override
  bool shouldRepaint(LadderPainter oldDelegate) {
    return oldDelegate.lineWidth != lineWidth ||
        oldDelegate.color != color ||
        oldDelegate.nbMarkers != nbMarkers ||
        oldDelegate.currentPercent != currentPercent;
  }
}
