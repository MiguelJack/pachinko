class Bolita{
  Body body;
  float radio;
  float fuerzaRevote;
  float densidad;
  color c;
  float friccion;
  boolean metal;
    
  Bolita(float fuerzaRevoteP, float radioP, float x, float y,float d,color c,float f,boolean m, float velocidad){
    this.c = c;
    metal = m;
    friccion = f;
    densidad = d;
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
    fixtureDef.density = densidad;
    fixtureDef.restitution = fuerzaRevote;
    fixtureDef.friction = friccion;
    
    body.createFixture(fixtureDef);
    
    body.setLinearVelocity(new Vec2(0, velocidad));
  }
  
  boolean gano(float x1, float x2){
     Vec2 posicion = box2d.getBodyPixelCoord(body);
     if((posicion.y >= (height - radio * 2)) && (posicion.x >= x1) && (posicion.x <= x2)){
       return true;  
     }
     return false;
  }
  
  boolean salio(float anchoMaquina){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    if((posicion.y >= (height - radio * 2)) && (posicion.x < (width - anchoMaquina) / 2 + anchoMaquina - 30)){
      box2d.destroyBody(body); 
      return true;
    }
    return false;
  }
 
   void attract(float x,float y) {
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getWorldCenter();
    worldTarget.subLocal(bodyVec);
    worldTarget.normalize();
    worldTarget.mulLocal((float) 8);
    body.applyForce(worldTarget, bodyVec);
  }

   void repel(float x,float y) {
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getWorldCenter();
    worldTarget.subLocal(bodyVec);
    worldTarget.normalize();
    worldTarget.mulLocal((float) -10);
    body.applyForce(worldTarget, bodyVec);
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(posicion.x, posicion.y);
    fill(c);
    stroke(#B2B2B2);
    strokeWeight(2);
    ellipse(0, 0, radio * 2, radio * 2);
    popMatrix();
  }
}
