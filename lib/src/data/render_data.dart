part of stagexl_isometric;

/// A data object containing the bitmapData of a rendered IIsoDisplayObject and the relative x &amp; y coordinates.
/// This data object is useful for blitting engines.
class RenderData {
  /// A bitmapData object containing the rendered data of the IIsoDisplayObject
  BitmapData bitmapData;

  /// The x location in screen coordintates where this bitmapData should be placed.
  /// This value corresponds to the left-most boundaries of this object.
  num x;

  /// The y location in screen coordintates where this bitmapData should be placed.
  /// This value corresponds to the top-most boundaries of this object.
  num y;
}
