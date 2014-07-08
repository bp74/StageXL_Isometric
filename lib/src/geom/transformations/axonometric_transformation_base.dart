part of stagexl_isometric;

/**
 * The IAxonometric interface defines the methods necessary for transforming coordinates between spacial and screen values.
 */
abstract class AxonometricTransformationBase {

  /**
   * Transforms a point from screen coordinates to the equivalent axonometric coordinates.
   *
   * @param screenPt A point in screen coordinates.
   *
   * @return Pt A point whose values are in axonometric space relative to its position on the screen.
   */
  Pt screenToSpace (Pt screenPt);

  /**
   * Transforms a point from axonometric coordinates to the equivalent screen coordinates.
   *
   * @param spacePt A point in axonometric coordinates.
   *
   * @return Pt A point whose values are in screen space relative to its position in axonometric space.
   */
  Pt spaceToScreen (Pt spacePt);
}