class MotorRueda{
  RevoluteJoint joint;
  Base base;
  Rueda rueda;
  
  MotorRueda(Base baseP, Rueda ruedaP){
    base = baseP;
    rueda = ruedaP;
    
    RevoluteJointDef revoluteJointDef = new RevoluteJointDef();
    revoluteJointDef.initialize(base.body, rueda.body, rueda.body.getTransform().p);
    revoluteJointDef.motorSpeed = PI * 2;
    revoluteJointDef.maxMotorTorque = 1;
    revoluteJointDef.enableMotor = false;
    
    joint = (RevoluteJoint) box2d.world.createJoint(revoluteJointDef);
  }
  
  void display(){
    base.display();
    rueda.display();
  }
}
