part of stagexl_isometric;

/**
 * The IStroke interface defines the interface that stroke classes must implement.
 *
 * This is a modified extension of mx.graphics.IStroke interface located in the Flex SDK by Adobe.
 */
 abstract class StrokeBase {
  /**
   *  Applies the properties to the specified Graphics object.
   *
   *  @param target The Graphics object to apply the properties to.
   */
  void apply(Graphics target);
}