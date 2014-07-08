part of stagexl_isometric;

/**
 * private
 */
class IsometricTransformation implements AxonometricTransformationBase {

  // TODO jwopitz: Figure out the proper conversion - http://www.compuphase.com/axometr.htm

  num _cosTheta = cos(30 * PI / 180);
  num _sinTheta = sin(30 * PI / 180);

  Pt screenToSpace (Pt screenPt) {

    var z = screenPt.z;
    var y = screenPt.y - screenPt.x / (2 * _cosTheta) + screenPt.z;
    var x = screenPt.x / (2 * _cosTheta) + screenPt.y + screenPt.z;

    return new Pt(x, y, z);
  }

  Pt spaceToScreen (Pt spacePt) {

    var z = spacePt.z;
    var y = (spacePt.x + spacePt.y) * _sinTheta - spacePt.z;
    var x = (spacePt.x - spacePt.y) * _cosTheta;

    return new Pt(x, y, z);
  }
}