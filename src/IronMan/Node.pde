abstract class Node {
  boolean rotate = false;
  color nodeColor;
  int strokeWeight;
  PVector position;
    
  abstract void update();
    
  void animate() {
      if (rotate) {
        rotateX(radians(frameCount/2));
        rotateY(radians(frameCount/2));
        rotateZ(radians(frameCount/2));
      }
      
      noFill();
      stroke(nodeColor);
      strokeWeight(strokeWeight);
      point(position.x, position.y, position.z);
  }
}

public class ParentNode extends Node {
  Node[] children;

  /* Constructor */
  public ParentNode(PVector position, int childCount) {
    nodeColor = color(78, 141, 234);
    strokeWeight = 10;
    this.position = position;
    
    children = new Node[childCount];
    for (int i = 0; i < children.length; i++) {
      children[i] = new ChildNode(position);
    }
  }

  /* Draw */
  public void update() {
    sphereDetail(20, 20);
    
    pushMatrix();
    animate();
    popMatrix();
    
    for (int i = 0; i < children.length; i++) {
      if (rotate) {
        children[i].rotate = true;
      }
      children[i].update();
    }
  }
}

public class ChildNode extends Node {
  float theta = random(-1, 1);
  float increment = random(0, 0.05);
  PVector parentPosition;

  public ChildNode(PVector position) {
    nodeColor = color(78, 209, 78);
    strokeWeight = 5;
    parentPosition = position;
  }

  public void update() {
    float distanceFromParent = width * 0.03;
    float posX = distanceFromParent * cos(theta) * sin(theta) * 1/2 + parentPosition.x;
    float posY = distanceFromParent * cos(theta) * 1/2  + parentPosition.y;
    float posZ = distanceFromParent * sin(theta) * sin(theta) * 1/2 + parentPosition.z;
    
    position = new PVector(posX, posY, posZ);
    pushMatrix();
    animate();
    strokeWeight(.5);
    stroke(255, 255, 255);
    line(posX, posY, posZ, parentPosition.x, parentPosition.y, parentPosition.z);    
    popMatrix();
  }
}
