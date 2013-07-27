part of stagexl_isometric;

/**
 * 3D box primitive in isometric space.
 */
 class IsoBox extends IsoPrimitive {

   /**
   * Constructor
   */
  IsoBox ([Map descriptor = null]):super(descriptor);

  set stroke (StrokeBase value) {
    strokes = [value, value, value, value, value, value];
  }

  bool _validateGeometry() { // protected
    return (width <= 0 && length <= 0 && height <= 0) ? false : true;
  }

  _drawGeometry () { // protected

    Graphics  g = _mainContainer.graphics;
    g.clear();

    //all pts are named in following order "x", "y", "z" via rfb = right, front, bottom
    var lbb = IsoMath.isoToScreen(new Pt(0, 0, 0));
    var rbb = IsoMath.isoToScreen(new Pt(width, 0, 0));
    var rfb = IsoMath.isoToScreen(new Pt(width, length, 0));
    var lfb = IsoMath.isoToScreen(new Pt(0, length, 0));

    var lbt = IsoMath.isoToScreen(new Pt(0, 0, height));
    var rbt = IsoMath.isoToScreen(new Pt(width, 0, height));
    var rft = IsoMath.isoToScreen(new Pt(width, length, height));
    var lft = IsoMath.isoToScreen(new Pt(0, length, height));

    var fill;
    var stroke;

    //bottom face

    fill = fills.length >= 6 ? fills[5] : IsoPrimitive.DEFAULT_FILL;
    if (fill != null && styleType != RenderStyleType.WIREFRAME) fill.begin(g);

    stroke = strokes.length >= 6 ? strokes[5] : IsoPrimitive.DEFAULT_STROKE;

    g.beginPath();
    g.moveTo(lbb.x, lbb.y);
    g.lineTo(rbb.x, rbb.y);
    g.lineTo(rfb.x, rfb.y);
    g.lineTo(lfb.x, lfb.y);
    g.lineTo(lbb.x, lbb.y);

    if (fill != null) fill.end(g);
    if (stroke != null) stroke.apply(g);

    //back-left face

    fill = fills.length >= 5 ? fills[4] : IsoPrimitive.DEFAULT_FILL;
    if (fill != null && styleType != RenderStyleType.WIREFRAME) fill.begin(g);

    stroke = strokes.length >= 5 ? strokes[4] : IsoPrimitive.DEFAULT_STROKE;

    g.beginPath();
    g.moveTo(lbb.x, lbb.y);
    g.lineTo(lfb.x, lfb.y);
    g.lineTo(lft.x, lft.y);
    g.lineTo(lbt.x, lbt.y);
    g.lineTo(lbb.x, lbb.y);

    if (fill != null) fill.end(g);
    if (stroke != null) stroke.apply(g);

    //back-right face

    fill = fills.length >= 4 ? fills[3] : IsoPrimitive.DEFAULT_FILL;
    if (fill != null && styleType != RenderStyleType.WIREFRAME) fill.begin(g);

    stroke = strokes.length >= 4 ? strokes[3] : IsoPrimitive.DEFAULT_STROKE;

    g.beginPath();
    g.moveTo(lbb.x, lbb.y);
    g.lineTo(rbb.x, rbb.y);
    g.lineTo(rbt.x, rbt.y);
    g.lineTo(lbt.x, lbt.y);
    g.lineTo(lbb.x, lbb.y);

    if (fill != null) fill.end(g);
    if (stroke != null) stroke.apply(g);

    //front-left face
    fill = fills.length >= 3 ? fills[2] : IsoPrimitive.DEFAULT_FILL;

    if (fill != null && styleType != RenderStyleType.WIREFRAME) {
      if (fill is BitmapFillBase) {
        var m = (fill as BitmapFillBase).matrix;
        if (m == null) m = new Matrix(1,0,0,1,0,0);
        m.translate(lfb.x, lfb.y);
        if ((fill as BitmapFillBase).repeat == false) {
          //calculate how to stretch fill for face
          //this is not great OOP, sorry folks!
        }
        (fill as BitmapFillBase).matrix = m;
      }

      fill.begin(g);
    }

    stroke = strokes.length >= 3 ? strokes[2] : IsoPrimitive.DEFAULT_STROKE;

    g.beginPath();
    g.moveTo(lfb.x, lfb.y);
    g.lineTo(lft.x, lft.y);
    g.lineTo(rft.x, rft.y);
    g.lineTo(rfb.x, rfb.y);
    g.lineTo(lfb.x, lfb.y);

    if (fill != null) fill.end(g);
    if (stroke != null) stroke.apply(g);

    //front-right face
    fill = fills.length >= 2 ? fills[1] : IsoPrimitive.DEFAULT_FILL;

    if (fill != null && styleType != RenderStyleType.WIREFRAME) {
      if (fill is BitmapFillBase) {
        var m = (fill as BitmapFillBase).matrix;
        if (m == null) m = new Matrix(1,0,0,1,0,0);
        m.translate(lfb.x, lfb.y);
        if ((fill as BitmapFillBase).repeat == false) {
          //calculate how to stretch fill for face
          //this is not great OOP, sorry folks!
        }
        (fill as BitmapFillBase).matrix = m;
      }
      fill.begin(g);
    }

    stroke = strokes.length >= 2 ? strokes[1] : IsoPrimitive.DEFAULT_STROKE;

    g.beginPath();
    g.moveTo(rbb.x, rbb.y);
    g.lineTo(rfb.x, rfb.y);
    g.lineTo(rft.x, rft.y);
    g.lineTo(rbt.x, rbt.y);
    g.lineTo(rbb.x, rbb.y);

    if (fill != null) fill.end(g);
    if (stroke != null) stroke.apply(g);

    //top face

    fill = fills.length >= 1 ? fills[0] : IsoPrimitive.DEFAULT_FILL;

    if (fill != null && styleType != RenderStyleType.WIREFRAME) {
      if (fill is BitmapFillBase) {
        var m = (fill as BitmapFillBase).matrix;
        if (m == null) m = new Matrix(1,0,0,1,0,0);
        m.translate(lbt.x, lbt.y);
        if ((fill as BitmapFillBase).repeat == false) {
        }
        (fill as BitmapFillBase).matrix = m;
      }
      fill.begin(g);
    }

    stroke = strokes.length >= 1 ? strokes[0] : IsoPrimitive.DEFAULT_STROKE;

    g.beginPath();
    g.moveTo(lbt.x, lbt.y);
    g.lineTo(rbt.x, rbt.y);
    g.lineTo(rft.x, rft.y);
    g.lineTo(lft.x, lft.y);
    g.lineTo(lbt.x, lbt.y);

    if (fill != null) fill.end(g);
    if (stroke != null) stroke.apply(g);
  }
}