part of stagexl_isometric;

/// The IIsoDisplayObject interface defines methods for any base display class needing rendering within an 3D isometric space.
abstract class IsoDisplayObjectBase extends IsoContainerBase {
  //////////////////////////////////////////////////////////////////
  //      GET RENDER DATA
  //////////////////////////////////////////////////////////////////

  /// Retrieves data for rendering the IIsoDisplayObject for blitting engines.
  ///
  /// @return Object A render data object which contains the bounds information and bitmapData of the IIsoDisplayObject.
  RenderData getRenderData();

  //////////////////////////////////////////////////////////////////
  //      RENDER AS ORPHAN
  //////////////////////////////////////////////////////////////////

  bool get renderAsOrphan;

  /// By default, objects lacking a parent node do not perform rendering logic.
  /// If <code>renderAsOrphan</code> is set to true, then the IsoDisplayObject will render regardless if they have a parent node or not.
  set renderAsOrphan(bool value);

  //////////////////////////////////////////////////////////////////
  //      BOUNDS
  //////////////////////////////////////////////////////////////////

  /// The object that defines the boundries of the IIsoDisplayObject in 3D isometric space.
  BoundsBase get isoBounds;

  /// The screen boundries associated with the IIsoDisplayObject in 2D screen coordinates related to the parent object.
  Rectangle get screenBounds;

  /// The traditional getBounds method of the flash.display.DisplayObject.
  ///
  /// @param targetCoordinateSpace The display object whose coordinate system is used to position the bounding rectangle.
  ///
  /// @return Rectangle The bounding rectangle of the IIsoDisplayObject in the target coordinate space.
  Rectangle getBounds(DisplayObject targetCoordinateSpace);

  num get inverseOriginX;
  num get inverseOriginY;

  //////////////////////////////////////////////////////////////////
  //      POSITION
  //////////////////////////////////////////////////////////////////

  /// Moves the IIsoDisplayObject to the particular 3D isometric coordinates.
  ///
  /// @param x The x value in 3D isometric space.
  /// @param y The y value in 3D isometric space.
  /// @param z The z value in 3D isometric space.
  void moveTo(num x, num y, num z);

  /// Moves the IIsoDisplayObject to a new position relative to the old position by the given amounts in 3D isometric coordinates.
  ///
  /// @param x The relative x value in 3D isometric space.
  /// @param y The relative y value in 3D isometric space.
  /// @param z The relative z value in 3D isometric space.
  void moveBy(num x, num y, num z);

  /// @private
  bool get isAnimated;

  /// Flag indicating if this object will be intended for frequent movement and/or resizing.
  set isAnimated(bool value);

  /// @private
  num get x;

  /// The x value in 3D isometric space.
  set x(num value);

  /// @private
  num get y;

  /// The y value in 3D isometric space.
  set y(num value);

  /// @private
  num get z;

  /// The z value in 3D isometric space.
  set z(num value);

  /// The x value of the container in screen coordinates relative to the parent container.
  num get screenX;

  /// The y value of the container in screen coordinates relative to the parent container.
  num get screenY;

  /// @private
  num get distance;

  /// An arbitrary value set by ISceneLayoutRenderers for calculating the proper z-order depth.  In most cases this should not be used by developers.
  set distance(num value);

  //////////////////////////////////////////////////////////////////
  //      GEOMETRY
  //////////////////////////////////////////////////////////////////

  /// Resizes the IIsoDisplayObject in 3D isometric coordinates.
  ///
  /// @param width The width in 3D isometric space.
  /// @param length The length in 3D isometric space.
  /// @param height The height in 3D isometric space.
  void setSize(num width, num length, num heigh);

  /// @private
  num get width;

  /// The width in 3D isometric space.
  set width(num value);

  /// @private
  num get length;

  /// The length in 3D isometric space.
  set length(num value);

  /// @private
  num get height;

  /// The height in 3D isometric space.
  set height(num value);

  //////////////////////////////////////////////////////////////////
  //      INVALIDATION
  //////////////////////////////////////////////////////////////////

  /// Invalidates the position of the IIsoDisplayObject.
  void invalidatePosition();

  /// Invalidates the size of the IIsoDisplayObject.
  void invalidateSize();

  //////////////////////////////////////////////////////////////////
  //      CLONE
  //////////////////////////////////////////////////////////////////

  /// Clones the IIsoDisplayObject, copying its dimensional and style properties.
  /// Does not copy the position of the original.
  /// Casting to the original class is necessary to avoid compile-time errors.
  ///
  /// @return IIsoDisplayObject The clone of the original.
  dynamic clone();
}
