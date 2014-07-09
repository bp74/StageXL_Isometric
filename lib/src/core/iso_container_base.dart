part of stagexl_isometric;

/**
 * The IContainer interface defines the methods necessary for display visual content associated with a particular data node.
 */
abstract class IsoContainerBase extends NodeBase implements InvalidationBase {

  //////////////////////////////////////////////////////////////////
  //      INCLUDE IN LAYOUT
  //////////////////////////////////////////////////////////////////

  bool get includeInLayout;

  /**
   * Flag indicating whether the <code>container</code> is included in the display list.
   * The allows child objects to persist in memory while being removed from the display list.
   */
  set includeInLayout (bool value);

  /**
   * An array of all children whose <code>container</code> is present within the display list.
   *
   * @see #includeInLayout
   */
  List get displayListChildren;

  //////////////////////////////////////////////////////////////////
  //      CONTAINER
  //////////////////////////////////////////////////////////////////

  /**
   * The depth of the <code>container</code> relative to its parent container.
   * If the <code>container</code> is orphaned, then -1 is returned.
   */
  int get depth;

  /**
   * The sprite that contains the visual assets.
   */
  Sprite get container;

  //////////////////////////////////////////////////////////////////
  //      RENDER
  //////////////////////////////////////////////////////////////////

  /**
   * Initiates the various validation processes in order to display the IPrimitive.
   *
   * @param recursive If true will tell child nodes to render through the display list.
   */
  void isoRender([bool recursive = true]);
}