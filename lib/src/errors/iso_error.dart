part of stagexl_isometric;

class IsoError extends Error {
  //////////////////////////////////////////////////////////////////////
  //      CONST
  //////////////////////////////////////////////////////////////////////

  /*
  throw new Error("parameter child does not implement IContainer.");
  throw new Error("parameter child is not found within node structure.");
  throw new Error("validation of geometry failed.");
  throw new Error("cellSize must be a positive value greater than 2");
  throw new Error ("parameter child is not of type IIsoDisplayObject");
  throw new Error("skin asset is not of the following types: DisplayObject or Class cast as DisplayOject.");
  throw new Error("IsoView instance already contains parameter scene");
  */

  //////////////////////////////////////////////////////////////////////
  //      PROPS
  //////////////////////////////////////////////////////////////////////

  /// The message explaining this error.
  String message;

  /// The additional information (if any) for this error.
  String info;

  /// The data associated with this error.
  dynamic data;

  //////////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  //////////////////////////////////////////////////////////////////////

  /// Constructor
  ///
  /// @param message The message associated with this error.
  /// @param info The specific information associated with this error.
  /// @param data The data associated with this error.
  IsoError(String message, [String info = "", dynamic data])
      : this.message = message,
        this.info = info,
        this.data = data,
        super();
}
