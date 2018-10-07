class MotorPico{
  Pico pico;
  Base base;
  Joint joint;
  
  MotorPico(float x, float y){
    base = new Base(x, y - 90, 10, 180); 
    pico = new Pico(x, y - 180 + 5);
    
    RevoluteJointDef revoluteJointDef = new RevoluteJointDef();
    revoluteJointDef.initialize(base.body, pico.body, pico.body.getTransform().p);
    revoluteJointDef.motorSpeed = PI * 1;
    revoluteJointDef.maxMotorTorque = 50000;
    revoluteJointDef.enableMotor = true;
    
    joint = box2d.world.createJoint(revoluteJointDef);
  }
  
  void display(){
    base.display();
    pico.display();
  }
}
