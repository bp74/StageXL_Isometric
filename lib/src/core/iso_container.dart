part of stagexl_isometric;

/**
 * IsoContainer is the base class that any isometric object must extend in order to be shown in the display list.
 * Developers should not instantiate this class directly but rather extend it.
 */
class IsoContainer extends Node implements IsoContainerBase {

  ////////////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////////////////////////

  IsoContainer(): super() {

    addEventListener( IsoEvent.CHILD_ADDED, _child_changeHandler );
    addEventListener( IsoEvent.CHILD_REMOVED, _child_changeHandler );

    _createChildren();

    // ToDo: anaylze those proxy event dispatcher stuff
    // proxyTarget = mainContainer;
  }

  //////////////////////////////////////////////////////////////////
  //      INCLUDE IN LAYOUT
  //////////////////////////////////////////////////////////////////

  bool _bIncludeInLayout = true;  // protected
  bool _includeInLayoutChanged = false; // protected

  bool get includeInLayout => _bIncludeInLayout;

  set includeInLayout(bool value) {
    if (_bIncludeInLayout != value ) {
      _bIncludeInLayout = value;
      _includeInLayoutChanged = true;
    }
  }

  ////////////////////////////////////////////////////////////////////////
  //      DISPLAY LIST CHILDREN
  ////////////////////////////////////////////////////////////////////////

  List<IsoContainerBase> _displayListChildrenArray = new List<IsoContainerBase>(); // protected

  List<IsoContainerBase> get displayListChildren {
    return new List<IsoContainerBase>.from(_displayListChildrenArray);
  }

  ////////////////////////////////////////////////////////////////////////
  //      CHILD METHODS
  ////////////////////////////////////////////////////////////////////////

  //      ADD
  ////////////////////////////////////////////////////////////////////////

  void addChildAt(NodeBase child, int index) {

    if (child is! IsoContainerBase)
      throw new ArgumentError("parameter child does not implement IsoContainerBase.");

    super.addChildAt(child, index);

    if ((child as IsoContainerBase).includeInLayout ) {

      _displayListChildrenArray.add(child);

      if (index > _mainContainer.numChildren)
        index = _mainContainer.numChildren;

      //referencing explicit removal of child RTE - http://life.neophi.com/danielr/2007/06/rangeerror_error_2006_the_supp.html
      var p = (child as IsoContainerBase).container.parent;

      if ( p != null && p != _mainContainer ) {
        p.removeChild((child as IsoContainerBase).container );
      }

      _mainContainer.addChildAt(( child as IsoContainerBase).container, index );
    }
  }

  //      SWAP
  ////////////////////////////////////////////////////////////////////////

  void setChildIndex(NodeBase child, int index) {

    if (child is! IsoContainerBase)
      throw new ArgumentError( "parameter child does not implement IsoContainerBase.");

    if ( !child.hasParent || child.parent != this )
      throw new ArgumentError( "parameter child is not found within node structure.");

    super.setChildIndex( child, index );
    _mainContainer.setChildIndex((child as IsoContainerBase).container, index);
  }

  //      REMOVE
  ////////////////////////////////////////////////////////////////////////

  NodeBase removeChildByID(String id) {

    var child = super.removeChildByID(id);

    if ( child != null && (child as IsoContainerBase).includeInLayout ) {

      var i = _displayListChildrenArray.indexOf(child);
      if (i != -1 ) {
        _displayListChildrenArray.removeAt(i);
      }

      _mainContainer.removeChild((child as IsoContainerBase).container );
    }

    return child;
  }

  void removeAllChildren() {

    for(IsoContainerBase child in children) {
      if ( child.includeInLayout )
        _mainContainer.removeChild(child.container);
    }

    _displayListChildrenArray = new List<IsoContainerBase>();
    super.removeAllChildren();
  }

  //      CREATE
  ////////////////////////////////////////////////////////////////////////

  /**
   * Initialization method to create the child IContainer objects.
   */
  _createChildren() {  // protected

    //overriden by subclasses
    _mainContainer = new Sprite();
    _attachMainContainerEventListeners();
  }

  /**
   * Attaches certain listener logic for adding and removing the main container from the stage and display list.
   * Subclasses of IsoContainer that explicitly set/override the mainContainer (e.g. IsoSprite) should call this class afterwards.
   */
  _attachMainContainerEventListeners() { // protected
    if (_mainContainer != null) {
      _mainContainer.addEventListener(Event.ADDED, _mainContainer_addedHandler);
      _mainContainer.addEventListener(Event.ADDED_TO_STAGE, _mainContainer_addedToStageHandler);
      _mainContainer.addEventListener(Event.REMOVED, _mainContainer_removedHandler);
      _mainContainer.addEventListener(Event.REMOVED_FROM_STAGE, _mainContainer_removedFromStageHandler);
    }
  }

  ///////////////////////////////////////////////////////////////////////
  //      DISPLAY LIST & STAGE LOGIC
  ///////////////////////////////////////////////////////////////////////

  bool _bAddedToDisplayList = false;
  bool _bAddedToStage = false;

  bool get isAddedToDisplay => _bAddedToDisplayList;
  bool get isAddedToStage => _bAddedToStage;

  _mainContainer_addedHandler(Event evt) {
    _bAddedToDisplayList = true;
  }

 _mainContainer_addedToStageHandler(Event evt) {
    _bAddedToStage = true;
  }

  _mainContainer_removedHandler(Event evt) {
    _bAddedToDisplayList = false;
  }

  _mainContainer_removedFromStageHandler(Event evt) {
    _bAddedToStage = false;
  }

  /////////////////////////////////////////////////////////////////
  //      IS INVALIDATED
  /////////////////////////////////////////////////////////////////

  bool  _bIsInvalidated;

  bool get isInvalidated => _bIsInvalidated;

  ////////////////////////////////////////////////////////////////////////
  //      RENDER
  ////////////////////////////////////////////////////////////////////////

  isoRender([bool recursive = true]) {
    _preRenderLogic();
    _renderLogic(recursive);
    _postRenderLogic();
  }

   _preRenderLogic() { // protected
    dispatchEvent(new IsoEvent(IsoEvent.RENDER));
  }

  /**
   * Performs actual rendering logic on the IIsoContainer.
   *
   * @param recursive Flag indicating if child objects render upon validation.  Default value is <code>true</code>.
   */
  _renderLogic([bool recursive = true]) {  // protected

    if (_includeInLayoutChanged && _parentNode != null) {

      var p = _parentNode as IsoContainerBase;
      var i = p.displayListChildren.indexOf(this);

      if (_bIncludeInLayout) {
        if ( i == -1 ) p.displayListChildren.add(this);
      } else if (_bIncludeInLayout == false) {
        if ( i >= 0 ) p.displayListChildren.removeAt(i);
      }

      //rather than removing or adding to display list, we leave it be and just leave it to the flash player to maintain
      _mainContainer.visible = _bIncludeInLayout;
      _includeInLayoutChanged = false;
    }

    if (recursive) {
      for (var child in children ) {
        _renderChild( child );
      }
    }
  }

  /**
   * Performs any logic after executing actual rendering logic on the IIsoContainer.
   */
  _postRenderLogic() { // protected
    dispatchEvent( new IsoEvent( IsoEvent.RENDER_COMPLETE ));
  }

  _renderChild(IsoContainerBase child) { // protected
    child.isoRender( true );
  }

  _child_changeHandler(Event evt) {  // protected
    _bIsInvalidated = true;
  }

  ////////////////////////////////////////////////////////////////////////
  //      CONTAINER STRUCTURE
  ////////////////////////////////////////////////////////////////////////

  Sprite _mainContainer;  // protected

  int get depth {
    if (_mainContainer.parent != null) {
      return _mainContainer.parent.getChildIndex(_mainContainer );
    } else {
      return -1;
    }
  }

  Sprite get container => _mainContainer;

}
