import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.ListIterator;
import org.jbox2d.dynamics.joints.*;
Box2DProcessing box2d;

ArrayList<Bolita> bolitas;
Maquina maquina;

float radioBolitas = 10;
float anchoMaquina;
int tipoMaquina;

void setup(){
  fullScreen();
  bolitas = new ArrayList();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  tipoMaquina = 1; //Esto se tiene que cambiar con un menu en un futuro
  if(tipoMaquina == 1){
    anchoMaquina = width / 2;
  }
  maquina = new Maquina(anchoMaquina, 1);
}

void draw(){
  background(0);
  
  if(mousePressed){
    bolitas.add(new Bolita(0.2, radioBolitas, (width - anchoMaquina) / 2 + anchoMaquina - radioBolitas - 5, height)); 
  }
  
  box2d.step();
  
  maquina.display();
  
  for (Bolita b : bolitas){
    b.display();
  }
  
  ListIterator<Bolita> pennywise = bolitas.listIterator();
  while(pennywise.hasNext()){
    Bolita b = pennywise.next();
    if(b.salio(anchoMaquina)){
      pennywise.remove();
    }
  }
}
