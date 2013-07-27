part of stagexl_isometric;

/**
 * The IFill interface defines the interface that fill classes must implement.
 *
 * This is a modified extension of mx.graphics.IFill interface located in the Flex SDK by Adobe.
 */
abstract class FillBase {
  /**
   * Initiates fill logic on target graphics.
   *
   * @param target The target graphics object.
   */
  void begin (Graphics target);

  /**
   * Completes fill logic on the target graphics.
   *
   * @param target The target graphics object.
   */
  void end (Graphics target);

  /**
   * Returns an exact copy of this IFill.
   *
   * @returns IFill The clone of this IFill.
   */
  FillBase clone();
}
