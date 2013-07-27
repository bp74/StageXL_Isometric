library example01;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_isometric/stagexl_isometric.dart';

void main() {

  var canvas = html.query('#stage');
  var stage = new Stage('myStage', canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  var a1 = new IsoApplication1();
  stage.addChild(a1);

}

class IsoApplication1 extends Sprite {

  IsoApplication1() {
    var box = new IsoBox();
    box.setSize(25, 25, 25);
    box.moveTo(200, 0, 0);

    var scene = new IsoScene();
    scene.hostContainer = this;
    scene.addChild(box);
    scene.isoRender();
  }
}