part of stagexl_isometric;

/// The IBounds interface defines the interface that all classes with bound-type information objects should use.
///
/// Properties of IBounds implementors will refer to properties in isometric space.
abstract class BoundsBase {
  ///////////////////////////////////////////////////////////
  //  WIDTH / LENGTH / HEIGHT
  ///////////////////////////////////////////////////////////

  /// The difference of the left and right properties.
  num get width;

  /// The difference of the back and front properties.
  num get length;

  /// The difference of the top and bottom properties.
  num get height;

  ///////////////////////////////////////////////////////////
  //  LEFT / RIGHT
  ///////////////////////////////////////////////////////////

  /// The left most coordinate. Most often this cooresponds to the x position of the IBounds' target.
  num get left;

  /// The right most coordinate. Cooresponds to the x + width of the IBounds' target.
  num get right;

  ///////////////////////////////////////////////////////////
  //  BACK / FRONT
  ///////////////////////////////////////////////////////////

  /// The back most coordinate. Most often this cooresponds to the y position of the IBounds' target.
  num get back;

  /// The front most coordinate. Cooresponds to the y + length of the IBounds' target.
  num get front;

  ///////////////////////////////////////////////////////////
  //  TOP / BOTTOM
  ///////////////////////////////////////////////////////////

  /// The bottom most coordinate. Most often this cooresponds to the z position of the IBounds' target.
  num get bottom;

  /// The top most coordinate. Cooresponds to the z + height of the IBounds' target.
  num get top;

  ///////////////////////////////////////////////////////////
  //  PTS
  ///////////////////////////////////////////////////////////

  /// Represents the center pt of the IBounds object in 3D isometric space
  Pt get centerPt;

  /// Returns an array of all the vertices of the IBounds' target.
  ///
  /// @returns Array An array of vertices of the target object.
  List<Pt> getPts();

  ///////////////////////////////////////////////////////////
  //  INTERSECTS
  ///////////////////////////////////////////////////////////

  /// Determines if the IBounds object has a 3D isometric intersection with the target IBounds.
  ///
  /// @param bounds The IBounds object to test for an intersection against.
  ///
  /// @returns Boolean Returns true if an intersection occurred, else false.
  bool intersects(BoundsBase bounds);

  /// Determines if the IBounds oject contains the target Pt.
  ///
  /// @param bounds The Pt object to test for an intersection against.
  ///
  /// @returns Boolean Returns true if it contains the Pt, else false.
  bool containsPt(Pt target);
}
