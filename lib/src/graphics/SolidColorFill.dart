part of stagexl_isometric;

class SolidColorFill implements FillBase {

  ////////////////////////////////////////////////////////////////////////
  //      ID
  ////////////////////////////////////////////////////////////////////////

  static int _IDCount = 0;

  final int UID = _IDCount++;
  String _setID = null; // protected

  String get id => (_setID == null || _setID == "") ? "SolidColorFill$UID" : _setID;

  set id (String value) {
    _setID = value;
  }

  /**
   * Constructor
   */
  SolidColorFill (int color, num alpha) {
    this.color = color;
    this.alpha = alpha;
  }

  /**
   * The fill color.
   */
  int color;

  /**
   * The transparency of the fill.
   */
  num alpha;

  ///////////////////////////////////////////////////////////
  //      IFILL
  ///////////////////////////////////////////////////////////

  var _beginFillColor;
  var _beginFillAlpha;

  void begin (Graphics target) {
    _beginFillColor = color;
    _beginFillAlpha = alpha;
  }

  void end(Graphics target ) {
    // ToDo: _beginFillAlpha
    target.fillColor(_beginFillColor);
  }

  FillBase clone() {
    return new SolidColorFill(color, alpha);
  }
}