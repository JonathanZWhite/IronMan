//abstract class Node {
//  
//}

public class Node {
  boolean isChild;
  
  int parentRadius = 150;
  int childRadius = 150/10;
  
  color parentColor = color(78, 141, 234);
  color childColor = color(78, 141, 234);
  
  float theta = 0;
  Node[] children;
  PVector position;

  /* Constructor */
  public Node(PVector position, int childCount, boolean isChild) {
    this.position = position;
    this.isChild = isChild;
    
    if (!this.isChild) {        
      children = new Node[childCount];
      for (int i = 0; i < children.length; i++) {
        children[i] = new Node(this.position, 0, true);
      }        
      System.out.println("Creating children");
    }
  }

  /* Draw */
  public void update() {
    // Children updates
    if (isChild) {
      float distanceFromParent = parentRadius + 70;
      float childX = distanceFromParent * cos(theta) + position.x;
      float childY = distanceFromParent * sin(theta) + position.y;
      float childZ = position.z;
      theta += .05;
      
      pushMatrix();
      translate(childX, childY, childZ); // x, y, z
      noFill();
      stroke(childColor);
      sphere(childRadius);
      popMatrix();
    } else {
    
      // Parent update
      pushMatrix();
      translate(position.x, position.y, position.z); // x, y, z

      rotateX( radians( frameCount ) );
      rotateY( radians( frameCount ) );
      rotateZ( radians( frameCount ) );
      
      noFill();
      stroke(parentColor);
      sphere(parentRadius);
      popMatrix();
      
      for (int i = 0; i < children.length; i++) {
        children[i].update();
      }
    }
  }
  
//    /* Creates child nodes */
//    public void updateChildren() {
//      // TODO: Export into recursive function which instantiates nodes
//      // TODO: Use some sin function to create orbit
//      // TODO: Orbit only children
//      float distanceFromParent = parentRadius + 70;
//      theta += .05;
//      float childX = distanceFromParent * cos(theta) + position.x;
//      float childY = distanceFromParent * sin(theta) + position.y;
//      float childZ = position.z;
//      
//      pushMatrix();
//      translate(childX, childY, childZ); // x, y, z
//  
//      noFill();
//      stroke(childColor);
//      sphere(childRadius);
//      popMatrix();
//    }
}
