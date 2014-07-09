part of stagexl_isometric;

/**
 * private
 */
class DimetricTransformation implements AxonometricTransformationBase {

  DimetricTransformation() {
  }

  Pt screenToSpace (Pt screenPt ) {
    return null;
  }

  Pt spaceToScreen (Pt spacePt) {
    var z = spacePt.z;
    var y = spacePt.y / 4 - spacePt.z;
    var x = spacePt.x - spacePt.y / 2;
    return new Pt(x, y, z);
  }

}