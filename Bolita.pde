class Bolita{
  Body body;
  float radio;
  float fuerzaRevote;
    
  Bolita(float fuerzaRevoteP, float radioP, float x, float y){
    fuerzaRevote = fuerzaRevoteP;
    radio = radioP;
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = box2d.coordPixelsToWorld(x, y);
    bodyDef.type = BodyType.DYNAMIC;
    body = box2d.createBody(bodyDef);
    
    CircleShape circleShape = new CircleShape();
    circleShape.setRadius(box2d.scalarPixelsToWorld(radio));
    
    FixtureDef fixtureDef = new FixtureDef();
    fixtureDef.shape = circleShape;
    fixtureDef.density = 1;
    fixtureDef.restitution = fuerzaRevote;
    
    body.createFixture(fixtureDef);
    
    body.setLinearVelocity(new Vec2(0, 40));
  }
  
  boolean salio(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    if((posicion.x == width / 2) && (posicion.y == height - radio * 2)){
      box2d.destroyBody(body); 
      return true;
    }
    return false;
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(posicion.x, posicion.y);
    fill(#EAEAEA);
    stroke(#B2B2B2);
    strokeWeight(2);
    ellipse(0, 0, radio * 2, radio * 2);
    popMatrix();
  }
}
