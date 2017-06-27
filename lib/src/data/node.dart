part of stagexl_isometric;

/**
 * A base hierachical data structure class.
 */
class Node extends EventDispatcher implements NodeBase {

  ////////////////////////////////////////////////////////////////////////
  //      CONSTRUCTOR
  ////////////////////////////////////////////////////////////////////////

  /**
   * Constructor
   */

  Node(): super();

  ////////////////////////////////////////////////////////////////////////
  //      ID
  ////////////////////////////////////////////////////////////////////////

  static int _IDCount = 0;

  final int UID = _IDCount++;
  String _setID = null; // protected

  String get id => (_setID == null || _setID == "") ? "node$UID" : _setID;

  set id(String value) {
    _setID = value;
  }

  ////////////////////////////////////////////////
  //      NAME
  ////////////////////////////////////////////////

  String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  ////////////////////////////////////////////////////////////////////////
  //      DATA
  ////////////////////////////////////////////////////////////////////////

  dynamic _data = null;

  dynamic get data => _data;

  set data(dynamic value) {
    _data = value;
  }

  //////////////////////////////////////////////////////////////////
  //      OWNER
  //////////////////////////////////////////////////////////////////

  dynamic _ownerObject = null;

  dynamic get owner => _ownerObject != null ? _ownerObject : _parentNode;

  ////////////////////////////////////////////////////////////////////////
  //      PARENT
  ////////////////////////////////////////////////////////////////////////

  NodeBase _parentNode = null;

  bool get hasParent => (_parentNode != null);

  NodeBase get parent => _parentNode;

  ////////////////////////////////////////////////////////////////////////
  //      ROOT NODE
  ////////////////////////////////////////////////////////////////////////

  NodeBase getRootNode() {
    NodeBase p = this;
    while (p.hasParent) {
      p = p.parent;
    }
    return p;
  }

  List<NodeBase> getDescendantNodes([bool includeBranches = false]) {

    var descendants = new List<NodeBase>();

    for (var child in _childrenArray) {

      if (child.children.length > 0) {
        descendants.addAll(child.getDescendantNodes(includeBranches));
        if (includeBranches) descendants.add(child);
      } else {
        descendants.add(child);
      }
    }

    return descendants;
  }

  ////////////////////////////////////////////////////////////////////////
  //      CHILD METHODS
  ////////////////////////////////////////////////////////////////////////

  bool contains(NodeBase value) {

    if (value.hasParent) {

      return value.parent == this;

    } else {

      for(var child in _childrenArray) {
        if ( child == value ) return true;
      }

      return false;
    }
  }

  List<NodeBase> _childrenArray = new List<NodeBase>();
  List<NodeBase> get children => _childrenArray;

  int get numChildren => _childrenArray.length;

  void addChild(NodeBase child) {
    addChildAt(child, numChildren);
  }

  void addChildAt(NodeBase child, int index) {

    //if it already exists here, do nothing
    if (getChildByID(child.id) != null) {
      return;
    }

    //if it has another parent, then remove it there
    if (child.hasParent) {
      var parent = child.parent;
      parent.removeChildByID(child.id);
    }

    (child as Node)._parentNode = this;
    _childrenArray.insert(index, child);

    var evt = new IsoEvent(IsoEvent.CHILD_ADDED);
    evt.newValue = child;

    dispatchEvent(evt);
  }

  NodeBase getChildAt(int index) {
    if ( index >= numChildren ) throw new ArgumentError();
    return _childrenArray[index];
  }

  int getChildIndex(NodeBase child) {
    for(int i = 0; i < numChildren; i++) {
      if (child == _childrenArray[i]) return i;
    }
    return -1;
  }

  void setChildIndex(NodeBase child, int index) {

    int i = getChildIndex( child );

    // Don't bother if it's already at this index
    if (i == index) return;
    if (i == -1 )  throw new ArgumentError("Node is not a children.");

    _childrenArray.removeAt(i);

    if (index >= numChildren) {
      _childrenArray.add(child);
    } else {
      _childrenArray.insert(index, child);
    }
  }

  NodeBase removeChild(NodeBase child) {
    return removeChildByID(child.id);
  }

  NodeBase removeChildAt(int index) {
    if (index >= numChildren) {
      return null;
    } else {
      var child = _childrenArray[index];
      return removeChildByID(child.id);
    }
  }

  NodeBase removeChildByID(String id) {

    Node child = getChildByID(id);

    if (child != null) {
      child._parentNode = null;

      for (int i = 0; i < _childrenArray.length; i++ ) {
        if (child == _childrenArray[i]) {
          _childrenArray.removeAt(i);
          break;
        }
      }

      var evt = new IsoEvent( IsoEvent.CHILD_REMOVED );
      evt.newValue = child;
      dispatchEvent( evt );
    }

    return child;
  }

  void removeAllChildren() {

    for(Node child in _childrenArray) {
      child._parentNode = null;
    }

    _childrenArray.length = 0;
  }

  NodeBase getChildByID(String id) {

    for (var child in _childrenArray) {
      if (child.id == id) return child;
    }

    return null;
  }

}