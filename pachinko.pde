import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import java.util.ListIterator;
import org.jbox2d.dynamics.joints.*;
Box2DProcessing box2d;

ArrayList<Bolita> bolitas;
Maquina maquina;

float radioBolitas = 8;
float anchoMaquina;
int tipoMaquina = 0;
float x1, x2;

int pantallaActual = 0;

Boton textoInicio;
Boton botonMaquinaConf1;
Boton botonMaquinaConf2;

void setup(){
  size(1200, 650);
  
  textoInicio = new Boton("Seleccione el tipo de maquina", 600, 325, 300, 50);
  botonMaquinaConf1 = new Boton("Tipo 1", 550, 500, 100, 50);
  botonMaquinaConf2 = new Boton("Tipo 2", 850, 500, 100, 50);
}

void draw(){
  background(0);
  if (pantallaActual == 0)
  {
    pantallaInicio();
  }else{
    eliminarElementsPantallaInicio();
    pantallaJuego();
  }
}

void pantallaInicio(){
  background(0);
  textoInicio.dibujar();
  botonMaquinaConf1.dibujar();
  botonMaquinaConf2.dibujar();
  
  if (mousePressed)
  { 
    if (botonMaquinaConf1.mouseEncima())
    {
      tipoMaquina = 1;
      pantallaActual = 1;
      configurarPantallaJuego();
    }
    
    if (botonMaquinaConf2.mouseEncima())
    {
      tipoMaquina = 2;
      pantallaActual = 1;
      configurarPantallaJuego();
    }
  }
}

void eliminarElementsPantallaInicio()
{
  textoInicio = null;
  botonMaquinaConf1 = null;
  botonMaquinaConf2 = null;
}

void configurarPantallaJuego()
{
  bolitas = new ArrayList();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  switch (tipoMaquina){
    case 1:
      anchoMaquina = 700;
      x1 = (width - anchoMaquina) / 2 + 205;
      x2 = (width - anchoMaquina) / 2 + 285;
      break;
    case 2:
      anchoMaquina = 700;
      x1 = (width - anchoMaquina) / 2 + 205;
      x2 = (width - anchoMaquina) / 2 + 285;  
      break;
  }
  maquina = new Maquina(anchoMaquina, tipoMaquina);
}

void pantallaJuego(){
  background(0);
  
  if(mousePressed){
    float i = random(1,10);
    if(i < 5){
      bolitas.add(new Bolita(0.2, radioBolitas, (width - anchoMaquina) / 2 + anchoMaquina - radioBolitas - 5, height)); 
    }
  }
  
  box2d.step();
  
  maquina.display();
  
  for (Bolita b : bolitas){
    b.display();
  }
  
  ListIterator<Bolita> pennywise = bolitas.listIterator();
  while(pennywise.hasNext()){
    Bolita b = pennywise.next();
    if(b.gano(x1, x2)){
      stop(); 
    }else{
      if(b.salio(anchoMaquina)){
        pennywise.remove();
      }
    }
  }
}
