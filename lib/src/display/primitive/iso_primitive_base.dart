part of stagexl_isometric;

/// The IIsoPrimitive interface defines methods for any IIsoDisplayObject class that is utilizing Flash's drawing API.
abstract class IsoPrimitiveBase extends IsoDisplayObjectBase {
  //////////////////////////////////////////////////////////////////
  //      STYLES
  //////////////////////////////////////////////////////////////////

  String get styleType;

  /// For IIsoDisplayObjects that make use of Flash's drawing API, it is necessary to develop render logic corresponding to the
  /// varios render style types.
  ///
  /// @see as3isolib.enum.RenderStyleType
  set styleType(String value);

  /// @private
  FillBase get fill;

  /// The primary fill used to draw the faces of this object.  This overwrites any values in the fills array.
  set fill(FillBase value);

  /// @private
  List get fills;

  /// An array of IFill objects used to apply material fills to the faces of the primitive object.
  ///
  /// @see as3isolib.graphics.IFill
  set fills(List value);

  /// @private
  StrokeBase get stroke;

  /// The primary stroke used to draw the edges of this object.  This overwrites any values in the strokes array.
  set stroke(StrokeBase value);

  /// @private
  List get strokes;

  /// An array of IStroke objects used to apply line styles to the face edges of the primitive object.
  ///
  /// @see as3isolib.graphics.IFill
  set strokes(List value);

  //////////////////////////////////////////////////////////////////
  //      INVALIDATION
  //////////////////////////////////////////////////////////////////

  /// Invalidates the styles of the  IIsoDisplayObject.
  void invalidateStyles();
}
