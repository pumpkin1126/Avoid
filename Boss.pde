class Boss{
  
  PVector loc;
  int r;
  
  PVector collidePoint_debug;
  
  private int holdBeams;
  
  Boss(PVector _loc){
    loc = _loc.copy();
    r = 100;
    
    CoMane.holder.getEvent(CollisionTypes.Beam2Boss).setEvent(
      new IEventT<PVector>(){
        void action(PVector p){
          finishAbsorb(p);
        }
      });
      
    collidePoint_debug = new PVector(-1, -1);
    
    holdBeams = 0;
  }
  
  Boss(){
    this(new PVector(width/2, height/2));
  }
  
  void update(){
    draw();
  }
  
  void draw(){
    noStroke();
    fill(255);
    ellipse(loc.x, loc.y, r*2, r*2);
    
    fill(255, 134, 0);
    
    //if(collidePoint_debug.x != -1)
      //ellipse(collidePoint_debug.x, collidePoint_debug.y, 10, 10);
    
    fill(0, 134, 255);
    textSize(75);
    textAlign(CENTER, CENTER);
    text(holdBeams, boss.loc.x, boss.loc.y);
  }
  
  void finishAbsorb(PVector p){
    collidePoint_debug = p.copy();
    holdBeams++;
    
    IEvent e = new IEvent(){
      public void action(){
        holdBeams--;
        
        PVector v = PVector.sub(player.loc, loc).setMag(15);
        PVector start = PVector.add(loc, v.copy().setMag(r));
        
        Beam beam = new Beam(start.x, start.y, v.x, v.y, 13);
        beam.isStandard = false;
        BeMane.beams.add(beam);
      }
    };
    
    TiMane.setTimer(0.7, e);
  }
}
