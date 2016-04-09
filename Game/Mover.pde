public final static int BALL_RADIUS = 10;

class Mover {
PVector location;
PVector velocity;
PVector gravityForce = new PVector();
PVector friction = new PVector();
float difficulty = 0.1f;
int count = 5;

Mover() {
location = new PVector();
velocity = new PVector(0, 0, 0);
float normalForce = 1;
float mu = 0.01;
float frictionMagnitude = normalForce * mu;
PVector friction = velocity.get();
friction.mult(-1);
friction.normalize();
friction.mult(frictionMagnitude);
}

//-sin(rotZ)??
void update() {
gravityForce.x = difficulty * sin(radians(rotX)) * gravityConstant;
gravityForce.z = difficulty * -sin(radians(rotZ)) * gravityConstant;
location.add(velocity.add(gravityForce.add(friction)));
translate(location.x, location.y, location.z);
}

void display() {
sphere(2 * BALL_RADIUS);
}

//velocity * -1?? cf physics how to stop ball at boundaries
void checkEdges() {
  if(location.x + BALL_RADIUS > 300){
    location.x = 300 - BALL_RADIUS;
  }
  
  if(location.x - BALL_RADIUS < - 300){
    location.x = -300 + BALL_RADIUS;
  }
  
  if(location.z + BALL_RADIUS > 300){
    location.z = 300 - BALL_RADIUS;
  }
  
  if(location.z - BALL_RADIUS < - 300){
    location.z = -300 + BALL_RADIUS;
  }
  
if (location.x + BALL_RADIUS ==  300 || location.x - BALL_RADIUS ==  - 300) {
velocity.x = velocity.x * - 0.6 ;
}

if (location.z + BALL_RADIUS  ==  300 || location.z - BALL_RADIUS  ==  - 300) {
velocity.z = velocity.z * - 0.6;
}

}

void checkCylinderCollision(ArrayList<PVector> positions){
  Cylinder cylinder = new Cylinder();
  //float cyRad = cylinder.getBaseSize();
  PVector contact;
  PVector normal;
  PVector normalized;
  for(PVector p: positions){
    float dist = PVector.dist(new PVector(p.x, 0, p.y), location);
    contact = new PVector(location.x - p.x, 0, location.y - p.y);
    
    /*if(dist < BALL_RADIUS +  cylinder.getBaseSize() && velocity.mag() > 0){
      location = contact.get();
    }*/
    
    if(dist <= BALL_RADIUS +  cylinder.getBaseSize()){
      normal = new PVector(location.x - p.x, 0, location.y - p.y);
      normalized = normal.normalize();
      PVector v = normalized.mult(2 * PVector.dot(velocity, normalized));
      velocity = PVector.sub(velocity, v).mult(-0.6);
    }
    
  }
}

}