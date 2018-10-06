class Pin{
  Body body; 
  float radio;
  
  Pin(float radioP, float x, float y){
    radio = radioP;
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
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    fill(#1D8B00);
    stroke(#2FDE00);
    strokeWeight(2);
    ellipse(posicion.x, posicion.y, radio * 2, radio * 2);
  }
}
