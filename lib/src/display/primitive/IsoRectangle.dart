part of stagexl_isometric;

/**
 * 3D square primitive in isometric space.
 */
class IsoRectangle extends IsoPolygon {

  /**
   * Constructor
   */
  IsoRectangle (Map descriptor) : super(descriptor) {
    if (descriptor == null)
      width = length = height = 0;
  }

  /**
   * @inheritDoc
   */
  bool _validateGeometry() {

    pts = [];
    pts.add(new Pt(0, 0, 0));

    //width x length
    if (width > 0 && length > 0 && height <= 0) {
      pts.add(new Pt(width, 0, 0));
      pts.add(new Pt(width, length, 0));
      pts.add(new Pt(0, length, 0));
    }

    //width x height
    else if (width > 0 && length <= 0 && height > 0) {
      pts.add(new Pt(width, 0, 0));
      pts.add(new Pt(width, 0, height));
      pts.add(new Pt(0, 0, height));
    }

    //length x height
    else if (width <= 0 && length > 0 && height > 0) {
      pts.add(new Pt(0, length, 0));
      pts.add(new Pt(0, length, height));
      pts.add(new Pt(0, 0, height));
    }

    else return false;

    for (var pt in pts)
      IsoMath.isoToScreen(pt);

    return true;
  }

  _drawGeometry () {
    super._drawGeometry();

    //clean up
    _geometryPts = [];
  }

}