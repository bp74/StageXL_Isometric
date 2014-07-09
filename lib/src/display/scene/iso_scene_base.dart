part of stagexl_isometric;

/**
 * The IIsoScene interface defines methods for scene-based classes that expect to group and control child objects in a similar fashion.
 */
 abstract class IsoSceneBase extends IsoContainerBase {

   /**
   * The IBounds for the displayable content in 3D isometric space.
   */
  BoundsBase get isoBounds;

  /**
   * An array of all invalidated children.
   */
  List get invalidatedChildren;

  /**
   * @private
   */
  DisplayObjectContainer get hostContainer;

  /**
   * The host container which will contain the display list of the isometric display list.
   *
   * @param value The host container.
   */
  set hostContainer (DisplayObjectContainer value);
}