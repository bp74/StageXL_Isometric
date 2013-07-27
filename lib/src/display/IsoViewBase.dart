part of stagexl_isometric;

/**
 * The IIsoView interface defines methods necessary to properly perform panning, zooming and other display task for a given IIsoScene.
 * The implementor normally wraps an IIsoScene with layout constraints.
 */
abstract class IsoViewBase extends EventDispatcher implements InvalidationBase {

  /**
   * An array of all child scenes.
   */
  List get scenes;

  /**
   * The number of scenes.
   */
  int get numScenes;

  /**
   * This point is the coordinate position visually located at the center of the IIsoView relative to the scenes' host containers.
   */
  Pt get currentPt;

  /**
   * @private
   */
  num get currentX;

  /**
   * The current x value of the coordintate position visually located at the center of the IIsoView relative to the scenes' host containers.
   * This property is useful for targeting by tween engines.
   *
   * @see #currentPt
   */
  set currentX(num value);

  /**
   * @private
   */
  num get currentY;

  /**
   * The current y value of the coordintate position visually located at the center of the IIsoView relative to the scenes' host containers.
   * This property is useful for targeting by tween engines.
   *
   * @see #currentPt
   */
  set currentY(num value);

  Pt localToIso(Point localPt);

  Point isoToLocal(Pt isoPt);

  /**
   * Centers the IIsoView on a given pt within the current child scene objects.
   *
   * @param pt The pt to pan and center on.
   * @param isIsometric A flag indicating wether the pt parameter represents a pt in 3D isometric space or screen coordinates.
   */
  centerOnPt(Pt pt, [bool isIsometric = true]);

  /**
   * Centers the IIsoView on a given IIsoDisplayObject within the current child scene objects.
   *
   * @param iso The IIsoDisplayObject to pan and center on.
   */
  centerOnIso(IsoDisplayObjectBase iso);

  /**
   * Pans the iso view by a given amount relative to the current position.
   *
   * @param px The x value to pan by.
   * @param py the y value to pan by.
   *
   * @see panTo
   */
  void panBy(num xBy, num yBy);

  /**
   * Pans the iso view to the current x and y position
   *
   * @param px The x value to pan to.
   * @param py the y value to pan to.
   *
   * @see panBy
   */
  void panTo(num xTo, num yTo);

  /**
   * The current zoom factor applied to the child scene objects.
   */
  num get currentZoom;

  /**
   * Zooms the child scene objects by a given amount.
   *
   * @param zFactor The positive non-zero value to scale the child scene objects by.  This corresponds to the child scene objects' containers' scaleX and scaleY properties.
   */
  void zoom(num zFactor);

  /**
   * Resets the child scene objects to be centered within the IIsoView and returns the zoom factor back to a normal value.
   */
  void reset();

  /**
   * Executes positional changes for background, scene and foreground objects.
   *
   * @param recursive Flag indicating if child scenes render on the view's validation.  Default value is <code>false</code>.
   */
  void isoRender([bool recursive = false]);

  num get width;
  num get height;

  /**
   * @private
   */
  Sprite get mainContainer;
}