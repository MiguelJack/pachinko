class Maquina{
  ArrayList<Vec2> puntos;
  ArrayList<Pin> pines;
  
  float ancho;

  Maquina(float anchoP){
    ancho = anchoP;
    
    puntos = new ArrayList();
    pines = new ArrayList();
    
    BodyDef bodyDef = new BodyDef();
    bodyDef.position = new Vec2();
    Body body = box2d.createBody(bodyDef);
    
    puntos.add(new Vec2((width - ancho) / 2 + 100, 0));
    puntos.add(new Vec2((width - ancho) / 2, 120));
    puntos.add(new Vec2((width - ancho) / 2, height));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, height));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, 150));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 30, height));
    puntos.add(new Vec2((width - ancho) / 2 + ancho, height));
    
    puntos.add(new Vec2((width - ancho) / 2 + ancho, 120));
    puntos.add(new Vec2((width - ancho) / 2 + ancho - 100, 0));
    puntos.add(new Vec2((width - ancho) / 2 + 100, 0));
    
    Vec2[] puntosMaquina = new Vec2[puntos.size()];
    for(int i = 0; i < puntos.size(); i++){
      puntosMaquina[i] = box2d.coordPixelsToWorld(puntos.get(i));
    }
    ChainShape chainShape = new ChainShape();
    chainShape.createChain(puntosMaquina, puntosMaquina.length);
    body.createFixture(chainShape, 1);
    
    colocarPines();
  }
  
  void display(){
    stroke(255);
    strokeWeight(5);
    for(int i = 0; i < puntos.size() - 1; i++){
      Vec2 v1 = puntos.get(i);
      Vec2 v2 = puntos.get(i + 1);
      line (v1.x, v1.y, v2.x, v2.y);
    }
    
    for(Pin p : pines){
      p.display();
    }
  }
  
  void colocarPines(){
    ArrayList<Vec2> puntos = new ArrayList();
    
    //puntos.add(new Vec2(width / 3 + 100, 80));
    //puntos.add(new Vec2(width / 3 + 250, 150));
    
    for(int i = 0; i < 50; i++){
      float x = random((width - ancho) / 2 + 5, (width - ancho) / 2 + ancho - 35);
      float y = random(120, height - 5);
      puntos.add(new Vec2(x, y));
    }
    
    for(Vec2 v : puntos){
       pines.add(new Pin(5, v.x, v.y));
    }
  }
}
