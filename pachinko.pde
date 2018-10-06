import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.ListIterator;
Box2DProcessing box2d;

ArrayList<Bolita> bolitas;
Maquina maquina;

float radioBolitas = 10;

void setup(){
  fullScreen();
  bolitas = new ArrayList();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  maquina = new Maquina();
  //bolitas.add(new Bolita(0.2, radioBolitas, (width / 3) * 2 - radioBolitas * 2, height)); 
}

void draw(){
  background(0);
  
  if(mousePressed){
    bolitas.add(new Bolita(0.2, radioBolitas, (width / 3) * 2 - radioBolitas, height)); 
  }
  
  box2d.step();
  
  maquina.display();
  
  for (Bolita b : bolitas){
    b.display();
  }
  
  ListIterator<Bolita> pennywise = bolitas.listIterator();
  while(pennywise.hasNext()){
    Bolita b = pennywise.next();
    if(b.salio()){
      pennywise.remove();
    }
  }
}
