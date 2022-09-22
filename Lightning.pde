int i = 0;
 MainBranch lightningBolt = new MainBranch(width/2, 0, 0);

color boltColor;

void setup() {
  size(1280, 720);
  background(50, 50, 50);
  frameRate(2);
  boltColor =  color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
}

void draw() {
  //if (i > lightningBolt.lightningSegments.length - 2) {
  //  background(50, 50, 50);
  //  lightningBolt = new MainBranch(width/2, 0, 0);
  //  i = 0;
  //}
  //lightningBolt.lightningSegments[i].drawSegment();
  //lightningBolt.drawBranches();
  //i++;
  background(50, 50, 50);
  lightningBolt = new MainBranch(width/2, 0, 0);
  for (LightningSegment seg : lightningBolt.lightningSegments) {
    seg.drawSegment();
  }
  lightningBolt.drawBranches();
}

void mousePressed() {
  boltColor =  color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
}

class LightningSegment {
  float x0, y0, x1, y1, shift;
  color myColor;
  int weight;
  
  LightningSegment(float m_x0, float m_y0, float m_x1, float m_y1, color m_color, int m_weight) {
    x0 = m_x0;
    y0 = m_y0;
    x1 = m_x1;
    y1 = m_y1;
    myColor = m_color;
    weight = m_weight;
  }
  
  void drawSegment() {
    stroke(myColor);
    strokeWeight(weight);
    line(x0, y0, x1, y1);
  }
}

class LightningBolt {
  LightningSegment[] lightningSegments;
  ArrayList<LightningBolt> branches = new ArrayList<LightningBolt>();
  float x, y, shift;
  
  LightningBolt(float m_x, float m_y, float m_shift) {
    x = m_x;
    y = m_y;
    shift = m_shift;
  }
  void generateSegments() {
    ArrayList<LightningSegment> lightningList = new ArrayList<LightningSegment>();
    
    while (y < height) {
      float x1 = x+(int)(Math.random()*15)-7+shift;
      float y1 = y+(int)(Math.random()*8);
      LightningSegment segment = new LightningSegment(x, y, x1, y1, boltColor, 2);
      lightningList.add(segment);
      x = x1;
      y = y1;
    }
    lightningSegments = new LightningSegment[lightningList.size()];
    lightningList.toArray(lightningSegments);
  }
}

class MainBranch extends LightningBolt {
  ArrayList<SecondaryBranch> branches = new ArrayList<SecondaryBranch>();
  
  MainBranch(float m_x, float m_y, float m_shift) {
    super(m_x, m_y, m_shift);
    generateSegments();
  }
  
  void generateSegments() {
    ArrayList<LightningSegment> lightningList = new ArrayList<LightningSegment>();
    
    while (y < height) {
      float x1 = x+(int)(Math.random()*15)-7+shift;
      float y1 = y+(int)(Math.random()*8);
      LightningSegment segment = new LightningSegment(x, y, x1, y1, boltColor, 5);
      lightningList.add(segment);
      x = x1;
      y = y1;
      if (Math.random() < 0.02) {
        branches.add(new SecondaryBranch(x, y, (int)(Math.random()*9)-4));
      }
    }
    lightningSegments = new LightningSegment[lightningList.size()];
    lightningList.toArray(lightningSegments);
  }
  
  void drawBranches() {
    for (SecondaryBranch branch : branches) {
      for (int i = 0; i < branch.lightningSegments.length; i++) {
        branch.lightningSegments[i].drawSegment();
      }
    }
  }
}

class SecondaryBranch extends LightningBolt {
  SecondaryBranch(float m_x, float m_y, float m_shift) {
    super(m_x, m_y, m_shift);
    generateSegments();
  }
}
