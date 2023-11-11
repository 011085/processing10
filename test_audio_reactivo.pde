// Primero importamos las librerías necesarias para poder utilizar
// los recursos de sonido de la computadora via Processing/Java
import ddf.minim.*;
import ddf.minim.analysis.*;

// luego definimos, como vimos en la clase pasada,
// los objetos necesarios para poder hacer la captura del sonido
// y el análisis del mismo
Minim minim;
AudioInput in;
FFT fft;


void setup() {
  size(512, 400);
  smooth();
  minim = new Minim(this);

  in = minim.getLineIn(Minim.MONO, 256);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  rectMode(CENTER);

}

void draw() {
  fft.forward(in.mix);
  background(0);


  float sensibilidad = 100;
    float sensibilidad2 = 200;
  // Este es el punto fuerte de este sketch:
  // el for es una estructura de control
  // que permite repeticiones. En este caso
  // está haciendo un recorrido con la variable i
  // desde su valor inicial 0, mientras esta valga
  // menos que 256, va haciendo un incremento en 1 por vez.
  for (int i = 0; i < 512; i=i+=5) {
    push();
    fill(200, fft.getBand(i)*sensibilidad-1);
    noStroke();
    rect(width/2, i, i, i);
    pop();
    
    push();
    fill(200, 150, 150, fft.getBand(i)*sensibilidad2-1);
    noStroke();
    rect(i, height/2, i, i);
    pop();
    
    push();
    fill(200, fft.getBand(i)*sensibilidad2-1);
    noStroke();
    rect(width/2, 400-i , i, i);
    pop();
    
    push();
    fill(200, 150, 150, fft.getBand(i)*sensibilidad2-1);
    noStroke();
    rect(512-i, height/2, i, i);
    pop();
  }
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}
