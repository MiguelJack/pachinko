
class Boton {
  String nombre;
  float x;
  float y;
  float w;
  float h;
  
  Boton(String labelB, float xpos, float ypos, float widthB, float heightB)
  {
    nombre = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  void dibujar()
  {
    fill(#F3E3FA);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    textSize(16);
    fill(#581474);
    text(nombre, x + (w / 2), y + (h / 2));
  }
  
  boolean mouseEncima()
  {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }else{
      return false;
    }
  }
}
