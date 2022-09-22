int i = 0;
MainBranch lightningBolt = new MainBranch(width/2, 0, 0);

color boltColor;

void setup() {
  size(1280, 720);
  background(50, 50, 50);
  frameRate(2);
  boltColor =  color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
  lightningBolt = new MainBranch(width/2, 0, 0);
}

void draw() {
  background(50, 50, 50);
  lightningBolt = new MainBranch(width/2, 0, 0);
  for (LightningSegment seg : lightningBolt.lightningSegments) {
    if (seg !=null)
      seg.drawSegment();
  }
  lightningBolt.drawBranches();
}

void mousePressed() {
  boltColor =  color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
}

class LightningSegment {
  int x0, y0, x1, y1, shift;
  color myColor;
  int weight;

  LightningSegment(int m_x0, int m_y0, int m_x1, int m_y1, color m_color, int m_weight) {
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
  ArrayList <LightningSegment> lightningSegments = new ArrayList <LightningSegment>();
  ArrayList <LightningBolt> branches = new ArrayList <LightningBolt>();
  int x, y, shift;

  LightningBolt(int m_x, int m_y, int m_shift) {
    x = m_x;
    y = m_y;
    shift = m_shift;
  }
  void generateSegments() {

    while (y < height) {
      int x1 = x+(int)(Math.random()*15)-7+shift;
      int y1 = y+(int)(Math.random()*8);
      LightningSegment segment = new LightningSegment(x, y, x1, y1, boltColor, 2);
      lightningSegments.add(segment);
      x = x1;
      y = y1;
    }
  }
}

class MainBranch extends LightningBolt {
  ArrayList <SecondaryBranch> branches = new ArrayList <SecondaryBranch>();

  MainBranch(int m_x, int m_y, int m_shift) {
    super(m_x, m_y, m_shift);
    generateSegments();
  }

  void generateSegments() {
    while (y < height) {
      int x1 = x+(int)(Math.random()*15)-7+shift;
      int y1 = y+(int)(Math.random()*8);
      LightningSegment segment = new LightningSegment(x, y, x1, y1, boltColor, 5);
      lightningSegments.add(segment);
      x = x1;
      y = y1;
      if (Math.random() < 0.02) {
        branches.add(new SecondaryBranch(x, y, (int)(Math.random()*9)-4));
      }
    }
  }

  void drawBranches() {
    for (SecondaryBranch branch : branches) {
      for (int i = 0; i < branch.lightningSegments.size(); i++) {
        branch.lightningSegments.get(i).drawSegment();
      }
    }
  }
}

class SecondaryBranch extends LightningBolt {
  SecondaryBranch(int m_x, int m_y, int m_shift) {
    super(m_x, m_y, m_shift);
    generateSegments();
  }
}
