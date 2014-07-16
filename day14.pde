HDrawablePool pool, pool2;
HOscillator yoBase, yoBase2;

import java.util.Calendar;

void setup() {
  size(640,640);
  H.init(this).background(#242424).autoClear(true);
  smooth();

  final HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600, #FF6464);

    yoBase = new HOscillator()
      .speed(2f)
      .range(0,400)
      .freq(2f) 
      .property(1)
      .waveform(1)
     ;
     
     yoBase2 = new HOscillator()
       .speed(2f)
       .range(0,320)
       .property(1)
       .freq(1f) 
      .waveform(1)
     ;

  pool = new HDrawablePool(100);
  pool.autoAddToStage()
    .add (
      new HRect(9)
      .rounding(2)
      .anchorAt(H.CENTER)
    )
    .layout(new HGridLayout()
      .startX(0)
      .startY(0)
      .spacing(10,6)
      .cols(120)
    )
    .onCreate (
        new HCallback() {
          public void run(Object obj) {
            int i = pool.currentIndex();

            HDrawable d = (HDrawable) obj;
            d.noStroke().fill( colors.getColor() );

          // Create an oscillator with yoBase's values
          HOscillator yo = yoBase.createCopy();
          // set osc's target to d / set osc's current step
          yo.target( d ).currentStep( i * 2 );
        }
      }
    )
    .requestAll();
  pool2 = new HDrawablePool(100);
  pool2.autoAddToStage()
    .add (
      new HRect(8)
      .rounding(2)
      .anchorAt(H.BOTTOM)
    )
    .layout(new HGridLayout()
      .startX(0)
      .startY(640)
      .spacing(10,6)
      .cols(120)
    )
    .onCreate (
        new HCallback() {
          public void run(Object obj) {
            int i = pool2.currentIndex();
            
            HDrawable d2 = (HDrawable) obj;
            d2.noStroke().fill( colors.getColor() );
          
          HOscillator yo2 = yoBase2.createCopy();
          yo2.target( d2 ).currentStep( i * 2);
        }
      }
    )
    .requestAll();
}

void draw() {
  H.drawStage();
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
