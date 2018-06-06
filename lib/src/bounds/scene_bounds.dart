part of stagexl_isometric;

/**
 * The IBounds implementation for IIsoScene implementors.
 */
class SceneBounds implements BoundsBase {

  IsoSceneBase _target;
  num _left = 0;
  num _right = 0;
  num _back = 0;
  num _front = 0;
  num _bottom = 0;
  num _top = 0;
  bool _excludeAnimated = false;

  ////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////////////////

  SceneBounds (IsoSceneBase target):_target = target {
    _calculateBounds();
  }

  ////////////////////////////////////////////////////////////////
  //      EXCLUDE ANIMATED
  ////////////////////////////////////////////////////////////////

  bool get excludeAnimatedChildren => _excludeAnimated;

  /**
   * Flag indicating to exclude animated child objects when calculating the scene's bounds.
   */
  set excludeAnimatedChildren(bool value) {
    _excludeAnimated = value;
    _calculateBounds();
  }

  ////////////////////////////////////////////////////////////////
  //      VOLUME
  ////////////////////////////////////////////////////////////////

  num get volume => width * length * height;

  ////////////////////////////////////////////////////////////////
  //      W / L / H
  ////////////////////////////////////////////////////////////////

  num get width => _right - _left;
  num get length => _front - _back;
  num get height => _top - _bottom;

  ////////////////////////////////////////////////////////////////
  //      LEFT / RIGHT
  ////////////////////////////////////////////////////////////////

  num get left => _left;
  num get right => _right;

  ////////////////////////////////////////////////////////////////
  //      BACK / FRONT
  ////////////////////////////////////////////////////////////////

  num get back => _back;
  num get front => _front;

  ////////////////////////////////////////////////////////////////
  //      TOP / BOTTOM
  ////////////////////////////////////////////////////////////////

  num get bottom => _bottom;
  num get top => _top;

  ////////////////////////////////////////////////////////////////
  //      CENTER PT
  ////////////////////////////////////////////////////////////////

  Pt get centerPt {
    var pt = new Pt();
    pt.x = (_right - _left) / 2;
    pt.y = (_front - _back) / 2;
    pt.z = (_top - _bottom) / 2;
    return pt;
  }

  /**
   * Returns a list all edge [Pt]s created by the edges of the scene.
   */
  List<Pt> getPts() {
    return [
      new Pt(_left, _back, _bottom),
      new Pt(_right, _back, _bottom),
      new Pt(_right, _front, _bottom),
      new Pt(_left, _front, _bottom),
      new Pt(_left, _back, _top),
      new Pt(_right, _back, _top),
      new Pt(_right, _front, _top),
      new Pt(_left, _front, _top)];
  }

  ////////////////////////////////////////////////////////////////
  //      COLLISION
  ////////////////////////////////////////////////////////////////

  bool intersects (BoundsBase bounds) {
    return false;
  }

  bool containsPt (Pt target) {
    return
      (_left <= target.x && target.x <= _right) &&
      (_back <= target.y && target.y <= _front) &&
      (_bottom <= target.z && target.z <= _top);
  }

  ////////////////////////////////////////////////////////////////
  //      CALCUALTE BOUNDS
  ////////////////////////////////////////////////////////////////

  /**
   * Determines the bounds of the scene based on the outermost child objects in each 
   * direction.
   */
  void _calculateBounds() {

    _left = double.nan;
    _right = double.nan;
    _back = double.nan;
    _front = double.nan;
    _bottom = double.nan;
    _top = double.nan;

    for (var child in _target.displayListChildren) {

      if (_excludeAnimated && child.isAnimated) continue;

      if (_left.isNaN || child.isoBounds.left < _left) _left = child.isoBounds.left;
      if (_right.isNaN || child.isoBounds.right > _right) _right = child.isoBounds.right;
      if (_back.isNaN || child.isoBounds.back < _back) _back = child.isoBounds.back;
      if (_front.isNaN || child.isoBounds.front > _front) _front = child.isoBounds.front;
      if (_bottom.isNaN || child.isoBounds.bottom < _bottom) _bottom = child.isoBounds.bottom;
      if (_top.isNaN || child.isoBounds.top > _top) _top = child.isoBounds.top;
    }

    if (_left.isNaN) _left = 0;
    if (_right.isNaN) _right = 0;
    if (_back.isNaN) _back = 0;
    if (_front.isNaN) _front = 0;
    if (_bottom.isNaN) _bottom = 0;
    if (_top.isNaN) _top = 0;
  }
}