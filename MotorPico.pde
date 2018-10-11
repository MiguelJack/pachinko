class MotorPico{
  Pico pico;
  Base base;
  RevoluteJoint joint;
  float alto = 320;
  int lado;
  
  MotorPico(float x, float y, int ladoP){
    base = new Base(x, y - alto / 2, 10, alto); 
    pico = new Pico(x, y - alto + 5);
    lado = ladoP;
    
    RevoluteJointDef revoluteJointDef = new RevoluteJointDef();
    revoluteJointDef.initialize(base.body, pico.body, pico.body.getTransform().p);
    revoluteJointDef.motorSpeed = PI/2 * lado;
    revoluteJointDef.maxMotorTorque = 500000000;
    revoluteJointDef.referenceAngle = 0;
    
    int lAngle;
    int uAngle;
    if(lado < 0){
      lAngle = -90;
      uAngle = -45;
    }else{
      lAngle = 45;
      uAngle = 90;
    }
    
    revoluteJointDef.lowerAngle = radians(lAngle); 
    revoluteJointDef.upperAngle = radians(uAngle); 
    revoluteJointDef.enableMotor = true;
    revoluteJointDef.enableLimit = true;
    
    joint = (RevoluteJoint) box2d.world.createJoint(revoluteJointDef);
  }
  
  void display(){
    int mult = 1;
    if (lado > 0){
      mult = -1;
    }
    if(joint.getJointAngle() <= joint.getLowerLimit()){
      joint.setMotorSpeed(PI/2 * -lado * mult); 
    }
    if(joint.getJointAngle() >= joint.getUpperLimit()){
      joint.setMotorSpeed(PI/2 * lado * mult); 
    }
    base.display();
    pico.display();
  }
}
