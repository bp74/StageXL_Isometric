part of stagexl_isometric;

/**
 * The IViewRenderer interface defines the methods that all view renderer-type classes should implement.
 * IViewRenderer classes are intended to assist IIsoView implementors during the rendering phase.
 * Generally this is used to clean up items from the display list that may reside outside of the viewing area.
 */
abstract class ViewRendererBase {
  /**
   * Renders the view.
   *
   * @param view The IIsoView to render.
   */
  void renderView (IsoView view);
}
