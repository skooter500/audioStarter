import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioBuffer buffer;
AudioInput ai;

float lerpedAverage = 0;

float[] lerpedBuffer;

float x = 0;

void setup()
{
  size(512, 512);
  colorMode(HSB);
  minim = new Minim(this);
  player = minim.loadFile("Etherwood.mp3", width);
  //player.play();
  //ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.left;

  lerpedBuffer = new float[buffer.size()];
}

int which = 0;

void draw()
{
  background(0);
  float halfH = height / 2;
  
  strokeWeight(1);
  for (int i = 0; i < buffer.size(); i ++)
  {
    
    stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
    lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f);
    float sample = lerpedBuffer[i] * width * 2;    
    stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
    line(i, height / 2 - sample, i, height/2 + sample); 
  }
  
  float sum = 0;
  for (int i = 0; i < buffer.size(); i ++)
  {
    sum += abs(buffer.get(i));
  }

  noStroke();
  float average = sum / buffer.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.1f);
  
}

void keyPressed()
{
  // Set the value of which based on which key was pressed
  if (keyCode >= '0' && keyCode <= '5')
  {
    which = keyCode - '0';
  }
  if (keyCode == ' ')
  {
    if ( player.isPlaying() )
    {
      player.pause();
    }
    else
    {
      player.rewind();
      player.play();
    }
  }
}
