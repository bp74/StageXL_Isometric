part of stagexl_isometric;

// http://www.compuphase.com/axometr.htm - axometric projection references

/**
 * IsoMath provides functions for converting pts back and forth between 3D isometric space and cartesian coordinates.
 */
class IsoMath {

  /////////////////////////////////////////////////////////////////////
  //      TRANSFORMATION OBJECT
  /////////////////////////////////////////////////////////////////////

  static AxonometricTransformationBase _transformationObj = new DefaultIsometricTransformation();
  static AxonometricTransformationBase get transformationObject => _transformationObj;

  static set transformationObject(AxonometricTransformationBase value) {

    if (value != null) {
      _transformationObj = value;
    } else {
      _transformationObj = new DefaultIsometricTransformation();
    }
  }

  /////////////////////////////////////////////////////////////////////
  //      TRANSFORMATION METHODS
  /////////////////////////////////////////////////////////////////////

  /**
   * Converts a given pt in cartesian coordinates to 3D isometric space.
   *
   * @param screenPt The pt in cartesian coordinates.
   * @param createNew Flag indicating whether to affect the provided pt or to return a converted copy.
   * @return pt A pt in 3D isometric space.
   */
  static Pt screenToIso(Pt screenPt, [bool createNew = false])
  {
    var isoPt = _transformationObj.screenToSpace(screenPt);

    if (createNew) {
      return isoPt;
    } else {
      screenPt.x = isoPt.x;
      screenPt.y = isoPt.y;
      screenPt.z = isoPt.z;
      return screenPt;
    }
  }

  /**
   * Converts a given pt in 3D isometric space to cartesian coordinates.
   *
   * @param isoPt The pt in 3D isometric space.
   * @param createNew Flag indicating whether to affect the provided pt or to return a converted copy.
   * @return pt A pt in cartesian coordinates.
   */
  static Pt isoToScreen (Pt isoPt, [bool createNew = false]) {

    var screenPt = _transformationObj.spaceToScreen(isoPt);

    if (createNew) {
      return screenPt;
    } else {
      isoPt.x = screenPt.x;
      isoPt.y = screenPt.y;
      isoPt.z = screenPt.z;
      return isoPt;
    }
  }
}