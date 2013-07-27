part of stagexl_isometric;

/**
 * IsoOrigin is a visual class that depicts the origin pt (typically at 0, 0, 0) with multicolored axis lines.
 */
class IsoOrigin extends IsoPrimitive {

  IsoOrigin([Map descriptor = null]):super(descriptor) {

    if (descriptor != null || descriptor.containsKey("strokes") == false) {
      strokes = [
        new Stroke(0, 0xFF0000, 0.75),
        new Stroke(0, 0x00FF00, 0.75),
        new Stroke(0, 0x0000FF, 0.75)
      ];
    }

    if (descriptor != null || !descriptor.containsKey("fills") == false) {
      fills = [
        new SolidColorFill(0xFF0000, 0.75),
        new SolidColorFill(0x00FF00, 0.75),
        new SolidColorFill(0x0000FF, 0.75)
      ];
    }
  }

  void _drawGeometry() { // protected

    var pt0 = IsoMath.isoToScreen(new Pt(-1 * axisLength, 0, 0));
    var ptM;
    var pt1 = IsoMath.isoToScreen(new Pt(axisLength, 0, 0));

    var g = _mainContainer.graphics;
    g.clear();

    //draw x-axis
    var stroke = strokes[0] as StrokeBase;
    var fill = fills[0] as FillBase;

    stroke.apply(g);
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);

    //g.lineStyle(0, 0, 0);
    g.moveTo(pt0.x, pt0.y);
    fill.begin(g);
    IsoDrawingUtil.drawIsoArrow(g, new Pt(-1 * axisLength, 0), 180, arrowLength, arrowWidth);
    fill.end(g);

    g.moveTo(pt1.x, pt1.y);
    fill.begin(g);
    IsoDrawingUtil.drawIsoArrow(g, new Pt(axisLength, 0), 0, arrowLength, arrowWidth);
    fill.end(g);

    //draw y-axis
    stroke = strokes[1] as StrokeBase;
    fill = fills[1] as FillBase;

    pt0 = IsoMath.isoToScreen(new Pt(0, -1 * axisLength, 0));
    pt1 = IsoMath.isoToScreen(new Pt(0, axisLength, 0));

    stroke.apply(g);
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);

    //g.lineStyle(0, 0, 0);
    g.moveTo(pt0.x, pt0.y);
    fill.begin(g);
    IsoDrawingUtil.drawIsoArrow(g, new Pt(0, -1 * axisLength), 270, arrowLength, arrowWidth);
    fill.end(g);

    g.moveTo(pt1.x, pt1.y);
    fill.begin(g);
    IsoDrawingUtil.drawIsoArrow(g, new Pt(0, axisLength), 90, arrowLength, arrowWidth);
    fill.end(g);

    //draw z-axis
    stroke = strokes[2] as StrokeBase;
    fill = fills[2] as FillBase;

    pt0 = IsoMath.isoToScreen(new Pt(0, 0, -1 * axisLength));
    pt1 = IsoMath.isoToScreen(new Pt(0, 0, axisLength));

    stroke.apply(g);
    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);

    //g.lineStyle(0, 0, 0);
    g.moveTo(pt0.x, pt0.y);
    fill.begin(g);
    IsoDrawingUtil.drawIsoArrow(g, new Pt(0, 0, axisLength), 90, arrowLength, arrowWidth, IsoOrientation.XZ);
    fill.end(g);

    g.moveTo(pt1.x, pt1.y);
    fill.begin(g);
    IsoDrawingUtil.drawIsoArrow(g, new Pt(0, 0, -1 * axisLength), 270, arrowLength, arrowWidth, IsoOrientation.YZ);
    fill.end(g);
  }

  /**
   * The length of each axis (not including the arrows).
   */
  num axisLength = 100;

  /**
   * The arrow length for each arrow found on each axis.
   */
  num arrowLength = 20;

  /**
   * The arrow width for each arrow found on each axis.
   * This is the total width of the arrow at the base.
   */
  num arrowWidth = 3;

  /**
   * @inheritDoc
   */
  set width (num value) {
    super.width = 0;
  }

  set length(num value) {
    super.length = 0;
  }

  set height (num value) {
    super.height = 0;
  }
}
