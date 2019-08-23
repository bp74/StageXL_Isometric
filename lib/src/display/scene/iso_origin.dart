part of stagexl_isometric;

/// IsoOrigin is a visual class that depicts the origin pt (typically at 0, 0, 0) with multicolored axis lines.
class IsoOrigin extends IsoPrimitive {
  IsoOrigin([Map descriptor = null]) : super(descriptor) {
    if (descriptor == null || descriptor.containsKey("strokes") == false) {
      strokes = [
        Stroke(0, 0xFF0000, 0.75),
        Stroke(0, 0x00FF00, 0.75),
        Stroke(0, 0x0000FF, 0.75)
      ];
    }

    if (descriptor == null || descriptor.containsKey("fills") == false) {
      fills = [
        SolidColorFill(0xFF0000, 0.75),
        SolidColorFill(0x00FF00, 0.75),
        SolidColorFill(0x0000FF, 0.75)
      ];
    }
  }

  void _drawGeometry() {
    // protected

    Pt pt0, pt1;
    Graphics g = _mainContainer.graphics;

    g.clear();

    //draw x-axis
    var stroke = strokes[0];
    var fill = fills[0];

    pt0 = IsoMath.isoToScreen(Pt(-1 * axisLength, 0, 0));
    pt1 = IsoMath.isoToScreen(Pt(axisLength, 0, 0));

    fill.begin(g);
    g.beginPath();
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);
    g.moveTo(pt0.x, pt0.y);
    IsoDrawingUtil.drawIsoArrow(
        g, Pt(-1 * axisLength, 0), 180, arrowLength, arrowWidth);
    g.moveTo(pt1.x, pt1.y);
    IsoDrawingUtil.drawIsoArrow(
        g, Pt(axisLength, 0), 0, arrowLength, arrowWidth);
    fill.end(g);
    stroke.apply(g);

    //draw y-axis
    stroke = strokes[1];
    fill = fills[1];

    pt0 = IsoMath.isoToScreen(Pt(0, -1 * axisLength, 0));
    pt1 = IsoMath.isoToScreen(Pt(0, axisLength, 0));

    fill.begin(g);
    g.beginPath();
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);
    g.moveTo(pt0.x, pt0.y);
    IsoDrawingUtil.drawIsoArrow(
        g, Pt(0, -1 * axisLength), 270, arrowLength, arrowWidth);
    g.moveTo(pt1.x, pt1.y);
    IsoDrawingUtil.drawIsoArrow(
        g, Pt(0, axisLength), 90, arrowLength, arrowWidth);
    fill.end(g);
    stroke.apply(g);

    //draw z-axis
    stroke = strokes[2];
    fill = fills[2];

    pt0 = IsoMath.isoToScreen(Pt(0, 0, -1 * axisLength));
    pt1 = IsoMath.isoToScreen(Pt(0, 0, axisLength));

    fill.begin(g);
    g.beginPath();
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);
    g.moveTo(pt0.x, pt0.y);
    IsoDrawingUtil.drawIsoArrow(g, Pt(0, 0, axisLength), 90, arrowLength,
        arrowWidth, IsoOrientation.XZ);
    g.moveTo(pt1.x, pt1.y);
    IsoDrawingUtil.drawIsoArrow(g, Pt(0, 0, -1 * axisLength), 270, arrowLength,
        arrowWidth, IsoOrientation.YZ);
    fill.end(g);
    stroke.apply(g);
  }

  /// The length of each axis (not including the arrows).
  num axisLength = 100;

  /// The arrow length for each arrow found on each axis.
  num arrowLength = 20;

  /// The arrow width for each arrow found on each axis.
  /// This is the total width of the arrow at the base.
  num arrowWidth = 3;

  /// @inheritDoc
  set width(num value) {
    super.width = 0;
  }

  set length(num value) {
    super.length = 0;
  }

  set height(num value) {
    super.height = 0;
  }
}
