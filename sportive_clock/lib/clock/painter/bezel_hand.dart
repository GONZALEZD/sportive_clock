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

class BezelHandPainter extends CustomPainter {
  BezelHandPainter({
    @required this.lineWidth,
    @required this.color,
    @required this.seconds,
  })  : assert(lineWidth != null),
        assert(color != null),
        assert(seconds != null) {
    resetPaint();
  }

  double lineWidth;
  Color color;
  int seconds;
  Paint _painter;

  void resetPaint() {
    this._painter = new Paint()
      ..color = this.color
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.lineWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = (Offset.zero & size).deflate(this.lineWidth / 2);

    double arcRadian = ((pi * 2.0) / 60.0) * this.seconds;
    canvas.drawArc(bounds, -pi / 2, arcRadian, false, this._painter);
  }

  @override
  bool shouldRepaint(BezelHandPainter oldDelegate) {
    var shouldRepaint = oldDelegate.lineWidth != lineWidth ||
        oldDelegate.color != color ||
        oldDelegate.seconds != seconds;
    if (shouldRepaint) {
      resetPaint();
    }
    return shouldRepaint;
    ;
  }
}
