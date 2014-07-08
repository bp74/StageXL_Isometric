part of stagexl_isometric;

/**
 * The ISceneRenderer interface defines the methods that all scene renderer-type classes should implement.
 * ISceneRenderer classes are intended to assist IIsoContainers implementors during the rendering phase.
 */
abstract class SceneRendererBase {
  /**
   * Iterates and renders each child of the target.
   *
   * @param scene The IIsoScene to be renderered.
   */
  void renderScene (IsoSceneBase scene);
}