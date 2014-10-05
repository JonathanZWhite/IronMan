abstract class Node {
  color nodeColor = color(78, 141, 234);
  int radius;
  PVector position;
    
  abstract void update();
  
  void animate() {
      pushMatrix();
      translate(position.x, position.y, position.z); // x, y, z

      rotateX( radians( frameCount ) );
      rotateY( radians( frameCount ) );
      rotateZ( radians( frameCount ) );
      
      noFill();
      stroke(nodeColor);
      sphere(radius);
      popMatrix();
  }
}

public class ParentNode extends Node {
  Node[] children;

  /* Constructor */
  public ParentNode(PVector position, int childCount) {
    super.radius = 150;
    this.position = position;
    
    children = new Node[childCount];
    for (int i = 0; i < children.length; i++) {
      children[i] = new ChildNode(position, radius);
    }
  }

  /* Draw */
  public void update() {
    animate();

    
    for (int i = 0; i < children.length; i++) {
      children[i].update();
    }
  }
}

public class ChildNode extends Node {
  int parentRadius;
  float theta = 0;
  PVector parentPosition;

  public ChildNode(PVector position, int parentRadius) {
    super.radius = parentRadius/10;
    this.parentRadius = parentRadius;
    parentPosition = position;
  }

  public void update() {
    theta += 0.05;
    float distanceFromParent = parentRadius + 70;
    float posX = distanceFromParent * cos(theta) + parentPosition.x;
    float posY = distanceFromParent * sin(theta) + parentPosition.y;
    float posZ = parentPosition.z;

    position = new PVector(posX, posY, posZ);
    animate();
  }

}
