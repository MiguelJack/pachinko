class Maquina{
  ArrayList<Vec2> puntos;
  ArrayList<Pin> pines;
  ArrayList<MotorPico> motoresPico;
  
  float ancho;
  int tipo;

  Maquina(float anchoP, int tipoP){
    ancho = anchoP;
    tipo = tipoP;
    
    puntos = new ArrayList();
    pines = new ArrayList();
    motoresPico = new ArrayList();
    
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
    colocarMotores();
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
    
    for(MotorPico mp : motoresPico){
      mp.display();
    }
  }
  
  void colocarPines(){
    ArrayList<Vec2> puntosPines = new ArrayList();
   
    if(tipo == 1){
      puntosPines = pinesMaquina1();
    }
    
    for(Vec2 v : puntosPines){
       pines.add(new Pin(5, v.x, v.y));
    }
  }
  
  void colocarMotores(){
    if(tipo == 1){
      motoresPico.add(new MotorPico((width - ancho) / 2 + 200, height, -1));
      motoresPico.add(new MotorPico((width - ancho) / 2 + ancho - 30 - 200, height, 1));
    }
  }
  
  ArrayList<Vec2> pinesMaquina1(){
    ArrayList<Vec2> puntos = new ArrayList();
    
    int vuelta = 1;
    float y = 130;
    while(y < height / 2){
      float x = ((width - ancho) / 2 + 5);
      if (vuelta < 0){
        x += 45; 
      }
      while(x < ((width - ancho) / 2 + ancho - 40)){
        puntos.add(new Vec2(x, y));
        x += 90;
      }
      y += 54;
      vuelta *= -1;
    }
   
    return puntos;
  }
}
