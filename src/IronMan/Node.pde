abstract class Node {
  boolean rotate = false;
  color nodeColor;
  int radius;
  PVector position;
    
  abstract void update();
  
  void animate() {
      pushMatrix();
      
      if (rotate) {
        rotateX(radians(frameCount/2));
        rotateY(radians(frameCount/2));
        rotateZ(radians(frameCount/2));
      }
      
      noFill();
      stroke(nodeColor);
      strokeWeight(10);
      point(position.x, position.y, position.z);
      popMatrix();
  }
}

public class ParentNode extends Node {
  Node[] children;

  /* Constructor */
  public ParentNode(PVector position, int childCount) {
    nodeColor = color(78, 141, 234);
    radius = 50;
    this.position = position;
    
    children = new Node[childCount];
    for (int i = 0; i < children.length; i++) {
      children[i] = new ChildNode(position, radius);
    }
  }

  /* Draw */
  public void update() {
    sphereDetail(20, 20);
    animate();
    
    for (int i = 0; i < children.length; i++) {
      children[i].update();
    }
  }
}

public class ChildNode extends Node {
  int parentRadius;
  float theta = random(0, 1);
  float increment = random(0, 0.05);
  PVector parentPosition;

  public ChildNode(PVector position, int parentRadius) {
    nodeColor = color(78, 141, 250);
    radius = parentRadius/10;
    this.parentRadius = parentRadius;
    parentPosition = position;
  }

  public void update() {
    // Generate a random theta
    theta += increment;
    float distanceFromParent = parentRadius + 0;
    float posX = distanceFromParent * cos(theta) + parentPosition.x;
    float posY = distanceFromParent * sin(theta) + parentPosition.y;
    float posZ = distanceFromParent * cos(theta) + parentPosition.z;
    
    System.out.println(parentPosition);

    position = new PVector(posX, posY, posZ);
    sphereDetail(4, 4);
    animate();
  }

}
