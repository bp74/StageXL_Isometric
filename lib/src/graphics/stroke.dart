part of stagexl_isometric;

/// The Stroke class defines the properties for a line.
class Stroke implements StrokeBase {
  /// The line weight, in pixels.
  num weight;

  /// The line color.
  int color;

  /// The transparency of the line.
  num alpha;

  /// Specifies whether to hint strokes to full pixels.
  bool usePixelHinting;

  /// Specifies how to scale a stroke.
  String scaleMode;

  /// Specifies the type of caps at the end of lines.
  CapsStyle caps;

  /// Specifies the type of joint appearance used at angles.
  JointStyle joints;

  /// Indicates the limit at which a miter is cut off.
  num miterLimit;

  /// Constructor
  Stroke(this.weight, this.color,
      [this.alpha = 1.0,
      this.usePixelHinting = false,
      this.scaleMode,
      this.caps,
      this.joints,
      this.miterLimit]);

  void apply(Graphics target) {
    // target.lineStyle(weight, color, alpha, usePixelHinting, scaleMode, caps, joints, miterLimit);
    var c = (color & 0xFFFFFF) | ((0xFF * alpha).toInt() << 24);
    target.strokeColor(c, weight, joints, caps);
  }
}
