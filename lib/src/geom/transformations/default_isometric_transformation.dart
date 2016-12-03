part of stagexl_isometric;

/**
 * The default isometric transformation object that provides the ideal 2:1 x to y ratio.
 */
class DefaultIsometricTransformation implements AxonometricTransformationBase {

  num _ratio = 2;
  num _axialProjection = cos(atan(0.5));

  bool _bAxonometricAxesProjection;
  bool _bMaintainZAxisRatio;

  /**
   * Constructor
   *
   * @param projectValuesToAxonometricAxes A flag indicating whether to compute x, y, z, width, lenght, and height values to the axonometric axes or screen axes.
   * @param maintainZaxisRatio A flag indicating if the z axis values are to be adjusted to maintain proportions based on the x &amp; axis values.
   */
  DefaultIsometricTransformation ([bool projectValuesToAxonometricAxes = false, bool maintainZAxisRatio = false]) {
    _bAxonometricAxesProjection = projectValuesToAxonometricAxes;
    _bMaintainZAxisRatio = maintainZAxisRatio;
  }

  Pt screenToSpace (Pt screenPt) {

    var z = screenPt.z;
    var y = screenPt.y - screenPt.x / _ratio + screenPt.z;
    var x = screenPt.x / _ratio + screenPt.y + screenPt.z;

    if (_bAxonometricAxesProjection == false && _bMaintainZAxisRatio) {
      z = z * _axialProjection;
    }

    if (_bAxonometricAxesProjection) {
      x = x / _axialProjection;
      y = y / _axialProjection;
    }

    return new Pt(x, y, z);
  }

  Pt spaceToScreen (Pt spacePt) {
    if (_bAxonometricAxesProjection == false && _bMaintainZAxisRatio) {
      spacePt.z = spacePt.z / _axialProjection;
    }

    if (_bAxonometricAxesProjection) {
      spacePt.x = spacePt.x * _axialProjection;
      spacePt.y = spacePt.y * _axialProjection;
    }

    var z = spacePt.z;
    var y = (spacePt.x + spacePt.y) / _ratio - spacePt.z;
    var x = spacePt.x - spacePt.y;

    return new Pt(x, y, z);
  }
}