part of stagexl_isometric;

/**
 * Pt is an extension of the flash.geom.Point class providing a z coordinate for 3D pts.
 */
class Pt extends Point {

  ///////////////////////////////////////////////
  //      CONSTRUCTOR
  ///////////////////////////////////////////////

  /**
   * Constructor
   *
   * @param x The x value.
   * @param y The y value.
   * @param z The z value.
   */
  Pt([num x = 0, num y = 0, num z = 0]):super(x, y) {
    this.z = z;
  }

  String toString() => "x: $x  y: $y z:$z";

  /////////////////////////////////////////////
  //      X, Y, Z
  ///////////////////////////////////////////////

  /**
   * Represents the z value in 3D coordinate space.
   */
  num z = 0;

  num get length => sqrt(x * x + y * y + z * z);

  Point clone() => new Pt(x, y, z);

  ///////////////////////////////////////////////
  //      CALCULATIONS
  ///////////////////////////////////////////////

  /**
   * Calculates the distance between two given pts.
   *
   * @param ptA The first pt.
   * @param ptB The second pt.
   * @return Number The distance between the two pts.
   */

  static num distance(Pt ptA, Pt ptB) {
    var tx = ptB.x - ptA.x;
    var ty = ptB.y - ptA.y;
    var tz = ptB.z - ptA.z;
    return sqrt(tx * tx + ty * ty + tz * tz);
  }

  /**
   * Calculates the angle in radians between two given pts.
   * The returned value is relative to the first pt.
   * The returned value is only relative to rotations in the X-Y plane.
   *
   * @param ptA The first pt.
   * @param ptB The second pt.
   * @return Number The angle in radians between the two pts.
   */
  static num theta(Pt ptA, Pt ptB) {
    var tx = ptB.x - ptA.x;
    var ty = ptB.y - ptA.y;
    var radians = atan(ty / tx);

    if (tx < 0) radians += pi;
    if (tx >= 0 && ty < 0) radians += pi * 2;
    return radians;
  }

  /**
   * Calculates the angle in degrees between two given pts.
   * The returned value is relative to the first pt.
   * The returned value is only relative to rotations in the X-Y plane.
   *
   * @param ptA The first pt.
   * @param ptB The second pt.
   * @return Number The angle in degrees between the two pts.
   */
  static num angle(Pt ptA, Pt ptB) {
    return theta(ptA, ptB) * 180 / pi;
  }

  /**
   * Create a new pt relative to the origin pt.
   * The returned value is relative to the first pt.
   * The returned value is only relative to rotations in the X-Y plane.
   *
   * @param originPt The pt of origin.
   * @param radius The distance of the new pt relative to the originPt.
   * @param theta The angle in radians of the new pt relative to the originPt.
   * @return Pt The newly created pt.
   */
  static Pt polar(Pt originPt, num radius, [num theta = 0]) {
    var tx = originPt.x + cos(theta) * radius;
    var ty = originPt.y + sin(theta) * radius;
    var tz = originPt.z;
    return new Pt(tx, ty, tz);
  }

  /**
   * Create a new pt between two given pts.
   * The returned value is relative to the first pt.
   * If f = 0 then the first pt is returned.
   * If f = 1 then the second pt is returnd.
   *
   * @param ptA The first pt.
   * @param ptB The second pt.
   * @param f The amount of interpolation relative to the first pt.
   * @return Pt The newly created pt.
   */
  static Pt  interpolate(Pt ptA, Pt ptB, num f) {
    if (f <= 0) return ptA;
    if (f >= 1) return ptB;

    var nx = (ptB.x - ptA.x) * f + ptA.x;
    var ny = (ptB.y - ptA.y) * f + ptA.y;
    var nz = (ptB.z - ptA.z) * f + ptA.z;
    return new Pt(nx, ny, nz);
  }

}
