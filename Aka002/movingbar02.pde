
class MovingBar02 {
  Body body;
  float w, h;
  MovingBar02(float x, float y, boolean lock, float r) {
    w = 80;
    h = 10;
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
    fd.friction = 0.9;
    fd.restitution = 0.2;

    //attach fixture to body
    body.createFixture(fd);
    
    
    //define the shape
//    PolygonShape sd = new PolygonShape();
//    Vec2[] vertices = new Vec2[8];
//    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-30,-30));
//    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(-20,-30));
//    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(-20,-5));
//    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(20,-5));
//    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(20,-30));
//    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(30,-30));
//    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(30,5));
//    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-30,5));
//    sd.set(vertices, vertices.length);
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
      //body.setTransform(box2d.coordPixelsToWorld(150, y1a-40), hand_pitchL*PI/180);
      body.setTransform(box2d.coordPixelsToWorld(width/2, y1a-80), 0);
    }
    float a = body.getAngle();
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(0);
    noStroke();
    rect(0,0,w,h);
//    beginShape();
//    for (int i = 0; i < ps.getVertexCount(); i++) {
//      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
//      vertex(v.x, v.y);
//    }
//    endShape(CLOSE);
    popMatrix();
  }
}

