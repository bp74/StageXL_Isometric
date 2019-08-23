part of stagexl_isometric;

/// 3D polygon primitive in isometric space.
class IsoPolygon extends IsoPrimitive {
  /// Constructor
  IsoPolygon([Map descriptor = null]) : super(descriptor);

  /// @inheritDoc
  bool _validateGeometry() {
    // protected
    return pts.length > 2;
  }

  _drawGeometry() {
    // protected
    Graphics g = _mainContainer.graphics;
    g.clear();
    g.moveTo(pts[0].x, pts[0].y);

    var fill;
    if (fills.length > 0) {
      fill = fills[0];
    }
    if (fill != null && styleType != RenderStyleType.WIREFRAME) fill.begin(g);

    // var stroke = strokes.length >= 1 ? strokes[0] : IsoPrimitive.DEFAULT_STROKE;

    var i = 1;
    var l = pts.length;
    while (i < l) {
      g.lineTo(pts[i].x, pts[i].y);
      i++;
    }

    g.lineTo(pts[0].x, pts[0].y);

    for (Stroke stroke in strokes) {
      if (stroke != null) stroke.apply(g);
    }

    if (fill != null) fill.end(g);
  }

  ////////////////////////////////////////////////////////////////////////
  //      PTS
  ////////////////////////////////////////////////////////////////////////

  /// @private
  List _geometryPts = [];

  /// @private
  List get pts {
    return _geometryPts;
  }

  /// The set of points in isometric space needed to render the polygon.  At least 3 points are needed to render.
  set pts(List value) {
    if (_geometryPts != value) {
      _geometryPts = value;
      invalidateSize();

      if (autoUpdate) isoRender();
    }
  }
}
