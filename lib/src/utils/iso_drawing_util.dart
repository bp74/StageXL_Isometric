part of stagexl_isometric;

/// IsoDrawingUtil provides some convenience methods for drawing shapes in 3D isometric space.

class IsoDrawingUtil {
  /* static public function drawIsoCircle (g:Graphics, originPt:Pt, radius:Number, plane:String = "xy"):void
  {
          switch (plane)
          {
                  case IsoOrientation.YZ:
                  {
                          break;
                  }

                  case IsoOrientation.XZ:
                  {
                          break;
                  }

                  case IsoOrientation.XY:
                  default:
                  {
                          var ptX:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 135 * Math.PI / 180));
                          var ptY:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 225 * Math.PI / 180));
                          var ptW:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 315 * Math.PI / 180));
                          var ptH:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 45 * Math.PI / 180));

                          g.drawEllipse(ptX.x, ptY.y, ptW.x - ptX.x, ptH.y - ptY.y);
                  }
          }
  } */

  /// Draws a rectangle in 3D isometric space relative to a specific plane.
  ///
  /// @param g The target graphics object performing the drawing tasks.
  /// @param originPt The origin pt where the specific drawing task originates.
  /// @param width The width of the rectangle. This is relative to the first orientation axis in the given plane.
  /// @param length The length of the rectangle. This is relative to the second orientation axis in the given plane.
  /// @param plane The plane of orientation to draw the rectangle on.
  static drawIsoRectangle(Graphics g, Pt originPt, num width, num length,
      [String plane = "xy"]) {
    Pt pt0 = IsoMath.isoToScreen(originPt, true);
    Pt pt1, pt2, pt3;

    switch (plane) {
      case IsoOrientation.XZ:
        pt1 =
            IsoMath.isoToScreen(Pt(originPt.x + width, originPt.y, originPt.z));
        pt2 = IsoMath.isoToScreen(
            Pt(originPt.x + width, originPt.y, originPt.z + length));
        pt3 = IsoMath.isoToScreen(
            Pt(originPt.x, originPt.y, originPt.z + length));
        break;

      case IsoOrientation.YZ:
        pt1 =
            IsoMath.isoToScreen(Pt(originPt.x, originPt.y + width, originPt.z));
        pt2 = IsoMath.isoToScreen(
            Pt(originPt.x, originPt.y + width, originPt.z + length));
        pt3 = IsoMath.isoToScreen(
            Pt(originPt.x, originPt.y, originPt.z + length));
        break;

      case IsoOrientation.XY:
      default:
        pt1 =
            IsoMath.isoToScreen(Pt(originPt.x + width, originPt.y, originPt.z));
        pt2 = IsoMath.isoToScreen(
            Pt(originPt.x + width, originPt.y + length, originPt.z));
        pt3 = IsoMath.isoToScreen(
            Pt(originPt.x, originPt.y + length, originPt.z));
    }

    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);
    g.lineTo(pt2.x, pt2.y);
    g.lineTo(pt3.x, pt3.y);
    g.lineTo(pt0.x, pt0.y);
  }

  /// Draws an arrow in 3D isometric space relative to a specific plane.
  ///
  /// @param g The target graphics object performing the drawing tasks.
  /// @param originPt The origin pt where the specific drawing task originates.
  /// @param degrees The angle of rotation in degrees perpendicular to the plane of orientation.
  /// @param length The length of the arrow.
  /// @param width The width of the arrow.
  /// @param plane The plane of orientation to draw the arrow on.
  static drawIsoArrow(Graphics g, Pt originPt, num degrees,
      [num length = 27, num width = 6, String plane = "xy"]) {
    var pt0 = Pt();
    var pt1 = Pt();
    var pt2 = Pt();
    var toRadians = pi / 180;
    var ptR;

    switch (plane) {
      case IsoOrientation.XZ:
        pt0 = Pt.polar(Pt(0, 0, 0), length, degrees * toRadians);
        ptR = Pt(pt0.x + originPt.x, pt0.z + originPt.y, pt0.y + originPt.z);
        pt0 = IsoMath.isoToScreen(ptR);

        pt1 = Pt.polar(Pt(0, 0, 0), width / 2, (degrees + 90) * toRadians);
        ptR = Pt(pt1.x + originPt.x, pt1.z + originPt.y, pt1.y + originPt.z);
        pt1 = IsoMath.isoToScreen(ptR);

        pt2 = Pt.polar(Pt(0, 0, 0), width / 2, (degrees + 270) * toRadians);
        ptR = Pt(pt2.x + originPt.x, pt2.z + originPt.y, pt2.y + originPt.z);
        pt2 = IsoMath.isoToScreen(ptR);
        break;

      case IsoOrientation.YZ:
        pt0 = Pt.polar(Pt(0, 0, 0), length, degrees * toRadians);
        ptR = Pt(pt0.z + originPt.x, pt0.x + originPt.y, pt0.y + originPt.z);
        pt0 = IsoMath.isoToScreen(ptR);

        pt1 = Pt.polar(Pt(0, 0, 0), width / 2, (degrees + 90) * toRadians);
        ptR = Pt(pt1.z + originPt.x, pt1.x + originPt.y, pt1.y + originPt.z);
        pt1 = IsoMath.isoToScreen(ptR);

        pt2 = Pt.polar(Pt(0, 0, 0), width / 2, (degrees + 270) * toRadians);
        ptR = Pt(pt2.z + originPt.x, pt2.x + originPt.y, pt2.y + originPt.z);
        pt2 = IsoMath.isoToScreen(ptR);
        break;

      case IsoOrientation.XY:
      default:
        pt0 = Pt.polar(originPt, length, degrees * toRadians);
        pt0 = IsoMath.isoToScreen(pt0);

        pt1 = Pt.polar(originPt, width / 2, (degrees + 90) * toRadians);
        pt1 = IsoMath.isoToScreen(pt1);

        pt2 = Pt.polar(originPt, width / 2, (degrees + 270) * toRadians);
        pt2 = IsoMath.isoToScreen(pt2);
        break;
    }

    g.moveTo(pt0.x, pt0.y);
    g.lineTo(pt1.x, pt1.y);
    g.lineTo(pt2.x, pt2.y);
    g.lineTo(pt0.x, pt0.y);
  }

  /// Creates a BitmapData object of the target IIsoDisplayObject.
  ///
  /// @param target The target to retrieve the data from.
  ///
  /// @return BitmapData A drawn bitmap data object of the target object.
  static BitmapData getIsoBitmapData(IsoDisplayObjectBase target) {
    //make sure we can render the object, do it, then restore original value
    var oldOrphanValue = target.renderAsOrphan;
    target.renderAsOrphan = true;
    target.isoRender();
    target.renderAsOrphan = oldOrphanValue;

    //get the screen bounds and adjust matrix for negative rect values.
    var rect = target.container.getBounds(target.container);
    var bitmapdata = BitmapData(rect.width, rect.height, 0);
    bitmapdata.draw(
        target.container, Matrix(1, 0, 0, 1, rect.left * -1, rect.top * -1));

    return bitmapdata;
  }

  /// Given a particular isometric orientation this method returns a matrix needed to project(skew) and image onto that plane.
  ///
  /// @param orientation The isometric planar orientation.
  /// @return Matrix The matrix associated with the provided isometric orientation.
  ///
  /// @see as3isolib.enum.IsoOrientation
  static Matrix getIsoMatrix(String orientation) {
    var m = Matrix.fromIdentity();

    switch (orientation) {
      case IsoOrientation.XY:
        var m2 = Matrix.fromIdentity();
        m2.scale(1, 0.5);
        m.rotate(pi / 4);
        m.scale(sqrt2, sqrt2);
        m.concat(m2);
        break;

      case IsoOrientation.XZ:
        m.setTo(1, 30 * pi / 180, 0, 1, 0, 0);
        break;

      case IsoOrientation.YZ:
        m.setTo(1, -30 * pi / 180, 0, 1, 0, 0);
        break;
    }

    return m;
  }
}
