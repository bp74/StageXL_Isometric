part of stagexl_isometric;

/**
 * The Stroke class defines the properties for a line.
 */
class Stroke implements StrokeBase {

  /**
   * The line weight, in pixels.
   */
  num weight;

  /**
   * The line color.
   */
  int color;

  /**
   * The transparency of the line.
   */
  num alpha;

  /**
   * Specifies whether to hint strokes to full pixels.
   */
  bool usePixelHinting;

  /**
   * Specifies how to scale a stroke.
   */
  String scaleMode;

  /**
   * Specifies the type of caps at the end of lines.
   */
  String caps;

  /**
   * Specifies the type of joint appearance used at angles.
   */
  String joints;

  /**
   * Indicates the limit at which a miter is cut off.
   */
  num miterLimit;

  /**
   * Constructor
   */
  Stroke (num weight, int color, [num alpha = 1.0, bool usePixelHinting = false,
      String scaleMode = "normal",String caps = null, String joints= null, num miterLimit = 0]) :
      this.weight = weight,
      this.color = color,
      this.alpha = alpha,
      this.usePixelHinting = usePixelHinting,
      this.scaleMode = scaleMode,
      this.caps = caps,
      this.joints = joints,
      this.miterLimit = miterLimit;

  void apply (Graphics target) {
    // target.lineStyle(weight, color, alpha, usePixelHinting, scaleMode, caps, joints, miterLimit);
    target.strokeColor(color, weight, joints, caps);
  }
}