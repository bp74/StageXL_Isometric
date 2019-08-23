part of stagexl_isometric;

typedef ClassGenerator = dynamic Function();

class ClassFactory implements FactoryBase {
  ClassGenerator _generator;

  ClassFactory(ClassGenerator generator) : _generator = generator;

  /// A collection of event listener descriptors used to assign eventListeners to each instance created by <code>newInstance()</code>.
  List eventListenerDescriptors = [];

  dynamic newInstance() {
    var instance = _generator();
/*
    if (instance is EventDispatcher) {
      var eventDispatcher = instance as EventDispatcher;
      for (var descriptor in eventListenerDescriptors) {
        eventDispatcher.addEventListener(descriptor.type, descriptor.listener, useCapture:descriptor.useCapture);
      }
    }
*/
    return instance;
  }
}
