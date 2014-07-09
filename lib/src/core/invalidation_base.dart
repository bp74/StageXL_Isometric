part of stagexl_isometric;
/**
 * The IInvalidation interface defines the methods necessary for determining if an object is invalidated.
 */

abstract class InvalidationBase {

  /**
   * Flag indicating if the object is invalidated.  If true, validation will occur during the next render pass.
   */

  bool get isInvalidated;
}