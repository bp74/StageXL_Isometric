library example01;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_isometric/stagexl_isometric.dart';

void main() {

  var canvas = html.query('#stage');
  var stage = new Stage('myStage', canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  //var app = new IsoApplication1();
  var app = new IsoApplication2();
  app.x = 400;
  app.y = 200;
  stage.addChild(app);

}

class IsoApplication1 extends Sprite {
  IsoApplication1() {
    var box = new IsoBox();
    box.setSize(25, 25, 25);
    box.moveTo(0, 0, 0);

    var scene = new IsoScene();
    scene.hostContainer = this;
    scene.addChild(box);
    scene.isoRender();
  }
}

class IsoApplication2 extends Sprite {
  IsoApplication2() {
    var box = new IsoBox();
    box.styleType = RenderStyleType.SHADED;
    box.fills = [
      new SolidColorFill(0xff0000, .5),
      new SolidColorFill(0x00ff00, .5),
      new SolidColorFill(0x0000ff, .5),
      new SolidColorFill(0xff0000, .5),
      new SolidColorFill(0x00ff00, .5),
      new SolidColorFill(0x0000ff, .5)];
    box.setSize(25, 30, 40);
    box.moveTo(0, 0, 0);

    var scene = new IsoScene();
    scene.hostContainer = this;
    scene.addChild(box);
    scene.isoRender();
  }
}


