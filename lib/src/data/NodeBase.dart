part of stagexl_isometric;

abstract class NodeBase extends EventDispatcher {

  ////////////////////////////////////////////////
  //      ID
  ////////////////////////////////////////////////

  /**
   * @private
   */
  String get id;

  /**
   * The identifier string.
   */
  set id(String value);

  ////////////////////////////////////////////////
  //      NAME
  ////////////////////////////////////////////////

  /**
   * @private
   */
  String get name;

  /**
   * An additional identifier string.
   */
  set name(String value);

  ////////////////////////////////////////////////
  //      DATA
  ////////////////////////////////////////////////

  /**
   * @private
   */
  dynamic get data;

  /**
   * A generic data storage property.
   */
  set data(dynamic value);

  //////////////////////////////////////////////////////////////////
  //      OWNER
  //////////////////////////////////////////////////////////////////

  /**
   * The owner of this INode.  By default this is the parent object, however more abstract relationships may exist.
   */
  dynamic get owner;

  ////////////////////////////////////////////////
  //      PARENT
  ////////////////////////////////////////////////

  /**
   * The parent INode within the node heirarchy structure.
   */
  NodeBase get parent;

  /**
   * A flag indicating if this INode has a parent node.
   */
  bool get hasParent;

  /**
   * Retrieves the top-most INode within this node hierarchy.
   *
   * @returns INode The top-most INode.
   */
  NodeBase getRootNode();

  /**
   * Retrieves the furthest descendant nodes within the node hierarchy.
   *
   * @param includeBranches Flag indicating that during each point of recursion adds descendant nodes.  If false, only leaf nodes are returned.
   * @return Array A flat array consisting of all possible descendant nodes.
   */
  List<NodeBase> getDescendantNodes([bool includeBranches = false]);

  ////////////////////////////////////////////////
  //      CHILD METHODS
  ////////////////////////////////////////////////

  /**
   * Determines if a particular INodes is an immediate child of this INode.
   *
   * @param value The INode to check for.
   * @returns Boolean Returns true if this INode contains the given value as a child INode, false otherwise.
   */
  bool contains(NodeBase value);

  /**
   * An array representing the immediate child INodes.
   */
  List<NodeBase> get children;

  /**
   * Indicates how many child nodes fall underneath this node within a particular heirarchical structure.
   */
  int get numChildren;

  /**
   * Adds a child at the end of the display list.
   *
   * @param child The INode to add this node's heirarchy.
   */
  void addChild(NodeBase child);

  /**
   * Adds a child to the display list at the specified index.
   *
   * @param child The INode to add this node's heirarchy.
   * @param index The target index to add the child.
   */
  void addChildAt(NodeBase child, int index);

  /**
   * Returns the index of a given child node or -1 if the child doesn't exist within the node's hierarchy.
   *
   * @param child The INdode whose index is to be retreived.
   * @return int The child index or -1 if the child's parent is null.
   */
  int getChildIndex(NodeBase child);

  /**
   * Returns the child node at the given index.
   *
   * @param index The index of the child to retrieve.
   * @returns INode The child at the given index.
   */
  NodeBase getChildAt(int index);

  /**
   * Returns the child node with the given id.
   *
   * @param id The id of the child to retrieve.
   * @returns INode The child at with the given id.
   */
  NodeBase getChildByID(String id);

  /**
   * Moves a child node to the provided index
   *
   * @param child The child node whose index is to be changed.
   * @param index The destination index to move the child node to.
   */
  void setChildIndex(NodeBase child, int index);

  /**
   * Removes the specified child.
   *
   * @param child The INode to remove from the children hierarchy.
   * @return INode The child that was removed.
   */
  NodeBase removeChild(NodeBase child);

  /**
   * Removes the child at the specified index.
   *
   * @param index The INode's index to remove from the children hierarchy.
   * @return INode The child that was removed.
   */
  NodeBase removeChildAt(int index);

  /**
   * Removes the child with the specified id.
   *
   * @param id The INode's id to remove from the children hierarchy.
   * @return INode The child that was removed.
   */
  NodeBase removeChildByID(String id);

  /**
   * removes all child INodes.
   */
  void removeAllChildren();
}
