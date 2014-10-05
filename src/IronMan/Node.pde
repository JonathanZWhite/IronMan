abstract class Node {
  color nodeColor;
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
    super.nodeColor = color(78, 141, 234);
    super.radius = 150;
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
    super.nodeColor = color(78, 141, 250);
    super.radius = parentRadius/10;
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
