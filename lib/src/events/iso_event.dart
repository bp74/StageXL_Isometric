part of stagexl_isometric;

/// The IsoEvent class represents the event object passed to the listener for various isometric display events.
class IsoEvent extends Event {
  /////////////////////////////////////////////////////////////
  //      CONST
  /////////////////////////////////////////////////////////////

  /// The IsoEvent.INVALIDATE constant defines the value of the type property of the event object for an iso event.
  static const String INVALIDATE = "as3isolib_invalidate";

  /// The IsoEvent.RENDER constant defines the value of the type property of the event object for an iso event.
  static const String RENDER = "as3isolib_render";

  /// The IsoEvent.RENDER_COMPLETE constant defines the value of the type property of the event object for an iso event.
  static const String RENDER_COMPLETE = "as3isolib_renderComplete";

  /// The IsoEvent.MOVE constant defines the value of the type property of the event object for an iso event.
  static const String MOVE = "as3isolib_move";

  /// The IsoEvent.RESIZE constant defines the value of the type property of the event object for an iso event.
  static const String RESIZE = "as3isolib_resize";

  /// The IsoEvent.CHILD_ADDED constant defines the value of the type property of the event object for an iso event.
  static const String CHILD_ADDED = "as3isolib_childAdded";

  /// The IsoEvent.CHILD_REMOVED constant defines the value of the type property of the event object for an iso event.
  static const String CHILD_REMOVED = "as3isolib_childRemoved";

  /////////////////////////////////////////////////////////////
  //      DATA
  /////////////////////////////////////////////////////////////

  /// Specifies the property name of the property values assigned in oldValue and newValue.
  String propName;

  /// Specifies the previous value assigned to the property specified in propName.
  dynamic oldValue;

  /// Specifies the new value assigned to the property specified in propName.
  dynamic newValue;

  /// Constructor
  IsoEvent(String type, [bool bubbles = false]) : super(type, bubbles);

  Event clone() {
    var evt = IsoEvent(type, bubbles);
    evt.propName = propName;
    evt.oldValue = oldValue;
    evt.newValue = newValue;
    return evt;
  }
}
