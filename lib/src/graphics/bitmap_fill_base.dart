part of stagexl_isometric;

/// The IBitmapFill interface defines the interface that fill classes utilizing bitmaps must implement.
abstract class BitmapFillBase extends FillBase {
  /// The matrix object describing any additional transformations to be applied to the fill.
  Matrix get matrix;
  set matrix(Matrix value);

  /// Flag indicating if the fill is to repeat or stretch.
  bool get repeat;
  set repeat(bool value);
}
