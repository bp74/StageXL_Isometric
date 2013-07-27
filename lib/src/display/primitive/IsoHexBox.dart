part of stagexl_isometric;

class IsoHexBox extends IsoPrimitive {

  static final num sin60 = sin(PI / 3);
  static final num cos60 = cos(PI / 3);

  //////////////////////////////////////////////////
  //      CONSTRUCTOR
  //////////////////////////////////////////////////

  IsoHexBox (Map descriptor) : super(descriptor);

  //////////////////////////////////////////////////
  //      SIZE
  //////////////////////////////////////////////////

  num _diameter = 0;

  set width (num value) {
    _diameter = value;

    var sideLength = value / 2;
    _isoLength = 2 * sin60 * sideLength;

    super.width = value;
  }

  set length (num value) {
    var sideLength = value / 2 * sin60;
    _isoWidth = _diameter = 2 * sideLength;

    super.length = value;
  }

  //////////////////////////////////////////////////
  //      GEOMETRY
  //////////////////////////////////////////////////

  _drawGeometry () { // protected
    //calculate pts
    var sideLength = _diameter / 2;

    var ptb0 = new Pt(sideLength / 2, 0, 0);
    var ptb1 = Pt.polar(ptb0, sideLength, 0);
    var ptb2 = Pt.polar(ptb1, sideLength, PI / 3);
    var ptb3 = Pt.polar(ptb2, sideLength, 2 * PI / 3);
    var ptb4 = Pt.polar(ptb3, sideLength, PI);
    var ptb5 = Pt.polar(ptb4, sideLength, 4 * PI / 3);

    var ptt0 = new Pt(sideLength / 2, 0, height);
    var ptt1 = Pt.polar(ptt0, sideLength, 0);
    var ptt2 = Pt.polar(ptt1, sideLength, PI / 3);
    var ptt3 = Pt.polar(ptt2, sideLength, 2 * PI / 3);
    var ptt4 = Pt.polar(ptt3, sideLength, PI);
    var ptt5 = Pt.polar(ptt4, sideLength, 4 * PI / 3);

    var pts = [ptb0, ptb1, ptb2, ptb3, ptb4, ptb5, ptt0, ptt1, ptt2, ptt3, ptt4, ptt5];
    for (var pt in pts)
      IsoMath.isoToScreen(pt);

    //draw bottom hex face
    Graphics  g = _mainContainer.graphics;
    g.clear();

    StrokeBase s = strokes.length >= 8 ? strokes[7] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    FillBase f = fills.length >= 8 ? fills[7] : DEFAULT_FILL;

    if (f != null) {
      if (f is BitmapFill)
        (f as BitmapFill).orientation = IsoOrientation.XY;
      f.begin(g);
    }

    g.moveTo(ptb0.x, ptb0.y);
    g.lineTo(ptb1.x, ptb1.y);
    g.lineTo(ptb2.x, ptb2.y);
    g.lineTo(ptb3.x, ptb3.y);
    g.lineTo(ptb4.x, ptb4.y);
    g.lineTo(ptb5.x, ptb5.y);
    g.lineTo(ptb0.x, ptb0.y);

    s = null;

    if (f != null) f.end(g);

    //draw side faces, orienting fills to face planes
    //face #4
    s = strokes.length >= 5 ? strokes[4] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 5 ? fills[4] : DEFAULT_FILL;
    if (f != null) {
      if (f is BitmapFill) {
        (f as BitmapFill).orientation = new Matrix(1, tan(Pt.theta(ptb4, ptb5)), 0, 1, 0, 0);;
      }
      f.begin(g);
    }

    g.moveTo(ptb4.x, ptb4.y);
    g.lineTo(ptb5.x, ptb5.y);
    g.lineTo(ptt5.x, ptt5.y);
    g.lineTo(ptt4.x, ptt4.y);
    g.lineTo(ptb4.x, ptb4.y);

    s = null;

    if (f != null) f.end(g);

    //face #5
    s = strokes.length >= 6 ? strokes[5] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 6 ? fills[5] : DEFAULT_FILL;
    if (f != null) {
      if (f is BitmapFill) {
        (f as BitmapFill).orientation = new Matrix(1, tan(Pt.theta(ptb5, ptb0)), 0, 1, 0, 0);;
      }
      f.begin(g);
    }

    g.moveTo(ptb0.x, ptb0.y);
    g.lineTo(ptb5.x, ptb5.y);
    g.lineTo(ptt5.x, ptt5.y);
    g.lineTo(ptt0.x, ptt0.y);
    g.lineTo(ptb0.x, ptb0.y);

    s = null;

    if (f != null) f.end(g);

    //face #6
    s = strokes.length >= 7 ? strokes[6] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 7 ? fills[6] : DEFAULT_FILL;
    if (f != null) {
      f.end(g);

      if (f is BitmapFill)
        (f as BitmapFill).orientation = IsoOrientation.XZ;

      f.begin(g);
    }

    g.moveTo(ptb0.x, ptb0.y);
    g.lineTo(ptb1.x, ptb1.y);
    g.lineTo(ptt1.x, ptt1.y);
    g.lineTo(ptt0.x, ptt0.y);
    g.lineTo(ptb0.x, ptb0.y);

    s = null;

    if (f != null) f.end(g);

    //face #1
    s = strokes.length >= 2 ? strokes[1] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 2 ? fills[1] : DEFAULT_FILL;
    if (f != null) {
      if (f is BitmapFill) {
        (f as BitmapFill).orientation = new Matrix(1, tan(Pt.theta(ptb2, ptb1)), 0, 1, 0, 0);;
      }
      f.begin(g);
    }

    g.moveTo(ptb1.x, ptb1.y);
    g.lineTo(ptb2.x, ptb2.y);
    g.lineTo(ptt2.x, ptt2.y);
    g.lineTo(ptt1.x, ptt1.y);
    g.lineTo(ptb1.x, ptb1.y);

    s = null;

    if (f != null) f.end(g);

    //face #2
    s = strokes.length >= 3 ? strokes[2] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 3 ? fills[2] : DEFAULT_FILL;
    f = fills[2];
    if (f != null) {
      if (f is BitmapFill) {
        (f as BitmapFill).orientation = new Matrix(1, tan(Pt.theta(ptb3, ptb2)), 0, 1, 0, 0);;
      }
      f.begin(g);
    }

    g.moveTo(ptb2.x, ptb2.y);
    g.lineTo(ptb3.x, ptb3.y);
    g.lineTo(ptt3.x, ptt3.y);
    g.lineTo(ptt2.x, ptt2.y);
    g.lineTo(ptb2.x, ptb2.y);

    s = null;

    if (f != null) f.end(g);

    //face #3
    s = strokes.length >= 4 ? strokes[3] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 4 ? fills[3] : DEFAULT_FILL;
    if (f != null) {
      if (f is BitmapFill) {
        (f as BitmapFill).orientation = IsoOrientation.XZ;
      }
      f.begin(g);
    }

    g.moveTo(ptb3.x, ptb3.y);
    g.lineTo(ptb4.x, ptb4.y);
    g.lineTo(ptt4.x, ptt4.y);
    g.lineTo(ptt3.x, ptt3.y);
    g.lineTo(ptb3.x, ptb3.y);

    s = null;

    if (f != null) f.end(g);

    //top hex
    s = strokes.length >= 1 ? strokes[0] : DEFAULT_STROKE;
    if (s != null) s.apply(g);

    f = fills.length >= 1 ? fills[0] : DEFAULT_FILL;
    if (f != null) {
      if (f is BitmapFill) {
        (f as BitmapFill).orientation = IsoOrientation.XY;
      }
      f.begin(g);
    }

    g.moveTo(ptt0.x, ptt0.y);
    g.lineTo(ptt1.x, ptt1.y);
    g.lineTo(ptt2.x, ptt2.y);
    g.lineTo(ptt3.x, ptt3.y);
    g.lineTo(ptt4.x, ptt4.y);
    g.lineTo(ptt5.x, ptt5.y);
    g.lineTo(ptt0.x, ptt0.y);

    s = null;

    if (f != null) f.end(g);
  }

  set stroke (StrokeBase value) {
    strokes = [value, value, value, value, value, value, value, value];
  }

}