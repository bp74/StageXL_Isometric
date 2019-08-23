part of stagexl_isometric;

/// The IBounds implementation for Primitive-type classes
class PrimitiveBounds implements BoundsBase {
  IsoDisplayObjectBase _target;

  ////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////////////////

  PrimitiveBounds(IsoDisplayObjectBase target) : _target = target;

  ////////////////////////////////////////////////////////////////
  //      VOLUME
  ////////////////////////////////////////////////////////////////

  num get volume => _target.width * _target.length * _target.height;

  ////////////////////////////////////////////////////////////////
  //      W / L / H
  ////////////////////////////////////////////////////////////////

  num get width => _target.width;
  num get length => _target.length;
  num get height => _target.height;

  ////////////////////////////////////////////////////////////////
  //      LEFT / RIGHT
  ////////////////////////////////////////////////////////////////

  num get left => _target.x;
  num get right => _target.x + _target.width;

  ////////////////////////////////////////////////////////////////
  //      BACK / FRONT
  ////////////////////////////////////////////////////////////////

  num get back => _target.y;
  num get front => _target.y + _target.length;

  ////////////////////////////////////////////////////////////////
  //      BOTTOM / TOP
  ////////////////////////////////////////////////////////////////

  num get bottom => _target.z;
  num get top => _target.z + _target.height;

  ////////////////////////////////////////////////////////////////
  //      CENTER PT
  ////////////////////////////////////////////////////////////////

  Pt get centerPt {
    var pt = Pt();
    pt.x = _target.x + _target.width / 2;
    pt.y = _target.y + _target.length / 2;
    pt.z = _target.z + _target.height / 2;
    return pt;
  }

  List<Pt> getPts() {
    return [
      Pt(left, back, bottom),
      Pt(right, back, bottom),
      Pt(right, front, bottom),
      Pt(left, front, bottom),
      Pt(left, back, top),
      Pt(right, back, top),
      Pt(right, front, top),
      Pt(left, front, top)
    ];
  }

  ////////////////////////////////////////////////////////////////
  //      COLLISION
  ////////////////////////////////////////////////////////////////

  bool intersects(BoundsBase bounds) {
    return (centerPt.x - bounds.centerPt.x).abs() <=
            _target.width / 2 + bounds.width / 2 &&
        (centerPt.y - bounds.centerPt.y).abs() <=
            _target.length / 2 + bounds.length / 2 &&
        (centerPt.z - bounds.centerPt.z).abs() <=
            _target.height / 2 + bounds.height / 2;
  }

  bool containsPt(Pt target) {
    return (left <= target.x && target.x <= right) &&
        (back <= target.y && target.y <= front) &&
        (bottom <= target.z && target.z <= top);
  }
}
