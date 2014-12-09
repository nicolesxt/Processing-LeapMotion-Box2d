
class Bar {
  Body body;
  float w, h;
  Bar(float x, float y, boolean lock, float r) {
    w = 150;
    h = 20;
    makeBody(x, y, lock, r);
  }

  void makeBody(float x, float y, boolean lock, float r) {
    //build the body
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    if (lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    
    bd.angle = PI*r/180;
    
    body = box2d.createBody(bd);
    
    //define the shape
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    //define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 10;
    fd.friction = 0.3;
    fd.restitution = 0.2;

    //attach fixture to body
    body.createFixture(fd);
  }
 //2atan();
    // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  void display() {
    //need the body location and angle (very important)
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(pos.y != y1 || pos.x != mx){
      //killBody();
      //makeBody(x1, y1, false, hand_pitch);
      body.setTransform(box2d.coordPixelsToWorld(x1, y1), hand_pitch*PI/180);
    }
    float a = body.getAngle();
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(0);
    noStroke();
    rect(0,0,w,h/3);
    popMatrix();
  }
}

