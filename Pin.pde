class Pin{
  Body body; 
  float radio;
  float x;
  float y;
  
  Pin(float radioP, float xP, float yP){
    radio = radioP;
    x = xP;
    y = yP;
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = box2d.coordPixelsToWorld(x, y);
    bodyDef.type = BodyType.STATIC;
    body = box2d.createBody(bodyDef);
    
    CircleShape circleShape = new CircleShape();
    circleShape.setRadius(box2d.scalarPixelsToWorld(radio));
    
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = circleShape;
    fixtureDef.density = 1;
    fixtureDef.restitution = 0.8;
    
    body.createFixture(fixtureDef);
  }
  
  void display(){
    fill(#1D8B00);
    stroke(#2FDE00);
    strokeWeight(2);
    ellipse(x, y, radio * 2, radio * 2);
  }
}
