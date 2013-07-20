paused = true;

// Setup the Processing Canvas
void setup(){
  state = "welcome";
  size( mapx, mapy );
  strokeWeight( 6 );
  fRate = 60;
  frameRate( fRate );
  setup_stars();
}

// Main draw loop
void draw(){  
  frameRate ( fRate );
  window.frameCount = frameCount;


  switch(state){

  case "welcome":
    background( 0, 0, 10 );    
    stroke(0, 120, 10);
    fill(0, 102, 153);
    textSize(25);
    textAlign(CENTER);
    update_stars();
    draw_stars();
    text("TMNT World:\n In Space", 0, 30, mapx, mapy); 
    load_stages();
    break;

  case stage0:
    background( 0, 0, 10 );    
    stroke(0, 120, 10); 

    if(!paused) {update_stars();}
    draw_stars();
    updateturtles();
    updatebullets();
    updateplanets();
    break;
  }
}

void mousePressed(){
  switch(state){
  case "welcome":
    if (stage_hover != null){
      state = stage_hover;
      textAlign(LEFT);
      window.turtles = state.turtles;
      window.bullets = state.bullets;
      window.planets = state.planets;
      window.baddies = state.baddies;
    }
    break;
  case stage0:
    paused = !paused;
    break; 
  }
}

//update functions
void updateturtles(){

  strokeWeight( 6 );
  stroke(120, 190, 10); 
  objects = turtles.concat(baddies);
  for (int i = 0; i<turtles.length + baddies.length; i++){
    var turtle = objects[i];

    if (!paused){turtle.update();}

    //draw turtle
    if (i > turtles.length - 1){ stroke(200, 0, 0);}
    fill(turtle.red, turtle.green, turtle.blue);
    var draw_radius = turtle.radius + sin(frameCount/fRate * 20  + 6.28 /(turtles.length) * i);
    ellipse( turtle.pos.x, turtle.pos.y, draw_radius *2, draw_radius * 2);

    if (mouseX > turtle.pos.x - turtle.radius && 
        mouseX < turtle.pos.x + turtle.radius &&
        mouseY > turtle.pos.y - turtle.radius &&
        mouseY < turtle.pos.y + turtle.radius){
        var hover = turtle;
    }


  }

    //tooltip
    if (hover){
    String tipText = hover.name
    + "\nHealth : " + hover.health
    + "\nEnergy : " + hover.energy;
      popup(mouseX, mouseY, tipText);
    }



    //tooltip
    if (eval(state.loss_condition)){
      popup(mapx/2, mapy/2, "YOU DIED!");
    }

    if (eval(state.win_condition)){
      popup(mapx/2, mapy/2, "YOU WON!");
      state = "welcome";  
    }
}
//Done updating turtles (if you forgot what was going on)

void popup = function(x, y, text){
  toolTip = new ToolTip(x, y, text);
  toolTip.setBackground(color(100,123,123,123));
  toolTip.clip=false;
  toolTip.display(); 
};

void updatebullets(){
  for (int i = 0; i<bullets.length; i++){
    var bullet = bullets[i];
    if (paused == false){bullet.update();}

    //draw it
    strokeWeight(2);
    fill(200,200,255);
    stroke(255,255,80);
    rect(bullet.pos.x, bullet.pos.y, 6 ,6);
  }
}

void updateplanets(){
  for (int i = 0; i<planets.length; i++){
  var planet = planets[i];

  if (paused == false){planet.update();}

  //draw planet
  fill(planet.red,planet.green,planet.blue);
  stroke(0,0,0);
  strokeWeight( 2 );
  ellipse(planet.pos.x, planet.pos.y, 2 * planet.radius, 2 * planet.radius);
  //craters
  ellipse(planet.pos.x + .5 * planet.radius, planet.pos.y - .6 * planet.radius, 4, 4);
  ellipse(planet.pos.x + .2 * planet.radius, planet.pos.y - .4 * planet.radius, 3, 3);
  ellipse(planet.pos.x  -.4 * planet.radius, planet.pos.y - .4 * planet.radius, 5, 5);
  ellipse(planet.pos.x + .4 * planet.radius, planet.pos.y + .2 * planet.radius, 3, 3);

  //hover
  if (mouseX > planet.pos.x - planet.radius && 
      mouseX < planet.pos.x + planet.radius &&
      mouseY > planet.pos.y - planet.radius &&
      mouseY < planet.pos.y + planet.radius){
      var hover = planet;
  }

  }

  //tooltip
  if (hover){
    String tipText = hover.name
    + "\nEnergy : " + hover.energy; 
    popup(mouseX, mouseY, tipText);
  }

}

void setup_stars(){
  window.stars = [];
  for(var i = 0; i<100; i++){
    var radius = random(100)/45;
    stars.push({x: random(mapx), y: random(mapy), radius: radius}); 
  }
}

void update_stars(){
  for(var i=0; i<stars.length/2; i++){
    stars[i].x += .66;
    stars[i].y += .25;
    if (stars[i].x<0){stars[i].x=mapx;}
    if (stars[i].x>mapx){stars[i].x=0;}
    if (stars[i].y<0){stars[i].y=mapy;}
    if (stars[i].y>mapy){stars[i].y=0;}
  };
  for(var i=0; i<stars.length/2; i++){
    stars[i+stars.length/2].x += .4;
    stars[i+stars.length/2].y += .15;
    if (stars[i+stars.length/2].x<0){stars[i+stars.length/2].x=mapx;}
    if (stars[i+stars.length/2].x>mapx){stars[i+stars.length/2].x=0;}
    if (stars[i+stars.length/2].y<0){stars[i+stars.length/2].y=mapy;}
    if (stars[i+stars.length/2].y>mapy){stars[i+stars.length/2].y=0;}
  }
}
void draw_stars(){
  stroke(220, 220, 30); 
  strokeWeight(1);
  for(var i = 0; i<stars.length; i++){
    ellipse(stars[i].x, stars[i].y, stars[i].radius, stars[i].radius);
  }
  stroke(0, 120, 10);
  strokeWeight(6);
}

void load_stages(){
  

  stage_hover = null;
  for (var i = 0; i < stages.length; i++){
    stage = stages[i];
    stroke(255);
    if (mouseX > 50 + 160 * stage.number && 
        mouseX < 170 + 160 * stage.number &&
        mouseY > 100 &&
        mouseY < 250){
      stage_hover = stage;
      stroke(200, 200, 0);
    }
    strokeWeight(3);
    fill(100, 200, 180);
    rect(50 + 160 * stage.number, 100, 120, 150);
    textSize(15);
    textAlign(CENTER);
    fill(0);
    text(stage.name, 50 + 160 * stage.number, 120, 120, 150);
 }

}

/****
* roundRect  method
* ToolTip    class
* 
* Author: James Durbin 
*       http://bayesianconspiracy.blogspot.com
* 
*       See running example here:
*       http://bayesianconspiracy.blogspot.com/2011/09/tooltip-class-for-html5-canvas-written.html
* 
* -----------------------
* Rounded rectangle class and color scheme came from here:
* http://bocoup.com/processing-js/docs/index.php?page=Rounded%20Corners%20with%20Processing.js
* 
* Tooltip class combines implements a snazzy tooltip that is semi-transparent.  .  
* 
* Include this library pde in your script header, separated from other .pde files, by a space, like:
* 
* <script type="text/javascript" src="processing.js"></script>
* <canvas id="tooltiptest" datasrc="ToolTip.pde ToolTipTest.pde"></canvas>
* 
* For static sketches (ones that don't use draw() ), you can update the tooltip based 
* on mouse position in a canvas with something like this in your mouseMoved() method:
* 
* void mouseMoved(){  
*     // Look up a new tool tip each time x,y cell changes...
*     x = mouseX;
*     y = mouseY;
* 
*     String tipText = "X112U375\nStatus:Normal\nx="+x+" y="+y; 
*     toolTip = new ToolTip(x,y,tipText);
*     toolTip.display();
* }
* 
* For sketches that invoke the draw() method, simply put the toolTip code lines as the 
* last thing in the draw() method.  In this situation ToolTip doesn't need to handle 
* clipping, so you will need to tell the toolTip this with: toolTip.doClip=false;  The
* default value is true. 
* 
* 
* TODO: Fade in/out tooltip. 
*/ 
 
 
/***
* A method to produce a rounded rectangle.  
**/
void roundedRect(int left, int top, int width, int height, int roundness)
{
  beginShape();               
  vertex(left + roundness, top);
  vertex(left + width - roundness, top);
  bezierVertex(left + width - roundness, top,
               left + width, top,
               left + width, top + roundness);
                          
  vertex(left + width, top + roundness);
  vertex(left + width, top + height - roundness);
  bezierVertex(left + width, top + height - roundness,
               left + width, top + height,
               left + width - roundness, top + height);
        
  vertex(left + width - roundness, top + height);
  vertex(left + roundness, top + height);        
  bezierVertex(left + roundness, top + height,
               left, top + height,
               left, top + height - roundness);
        
  vertex(left, top + height - roundness);
  vertex(left, top + roundness);
  bezierVertex(left, top + roundness,
               left, top,
               left + roundness, top);        
  endShape();
}
 
 
/***
* A class to display a tooltip in a nice bubble. 
**/
class ToolTip{
  String mText; 
  int x;
  int y; 
  
  boolean doClip = true;
  
  int myWidth;
  int fontSize = 16;
  int totalHeight = 0;
  
  int rectWidthMargin;
  int rectHeightMargin;
    
  int shadowOffset = 8;
    
  color tbackground = color(80,150,0,200);  
  Pfont ttfont;
  
  // Saved part of image that will be painted over by tooltip..
  static PImage clip = null;
  static int clipx;
  static int clipy;
  
  void setBackground(color c){
    tbackground = c;
  }
      
  ToolTip(_x,_y,tttext){
    x = _x;
    y = _y;
    mText = tttext;
    ttfont = createFont("Arial",20,true);
    textFont(ttfont,fontSize);    
        
    // Figure out text size... font metrics don't seem quite right, at least on Chrome
    String lines[] = split(mText,"\n");
    int maxWidth = 0;
    totalHeight = 0;
    for(int i = 0;i < lines.length;i++){
      totalHeight += fontSize;
      String line = lines[i];
      myWidth = textWidth(line);
      if (int(myWidth) > int(maxWidth)){
        maxWidth = myWidth;
      }
    }
    myWidth = int(maxWidth);    
  }
  
  void restoreClip(){
    imageMode(CORNER);
    image(clip,clipx,clipy);
  }
  
  void hide(){
    restoreClip();
  }
  
  
  void drawText(String mText,int x,int y,int fontSize){ 
    // Print the text to screen
    fill(255);
    xindent = int(myWidth*(10/128));
    yindent = int(fontSize*(10/128));
    text(mText,x+xindent, y-yindent);
  }
 
  void drawBalloon(int x,int y, int w,int h){
 
    w = int(w);
    h = int(h);
    rectWidthMargin = int(w*(10/64));
    rectHeightMargin = int(h*(10/64));
 
    rounding = int(h*(10/64));
 
    //size(200,100);
    strokeWeight(2);
    stroke(0,0,0,10);  
    fill(0,0,0,50);
 
    roundedRect(x+shadowOffset+2,y+shadowOffset+2,w+rectWidthMargin,h+rectHeightMargin,rounding)     
 
    stroke(255,255,255,200);  
    fill(tbackground);
    roundedRect(x,y, w+rectWidthMargin, h+rectHeightMargin,rounding)
 
    // Highlight x,y coords... at top left...
    //fill(0,0,255);
    //rect(x,y,4,4);
  }
        
  void display(){   
    
    if ((clip != null) && (doClip)){
      restoreClip();
    }
    
    // x and y are mouse coordinates, so determine where tip should be relative to that...              
    int bx = int(x+5);
    int by = int(y-totalHeight);    
    rectRight = bx+myWidth +20;
    rectTop = by-totalHeight+30;
    
    rectWidthMargin = int(myWidth*(10/64));
    rectHeightMargin = int(totalHeight*(10/64));
    
    if (rectRight >= width){
      bx = int(x-5-myWidth-rectWidthMargin); 
    } 
    
    if (rectTop <= 0){
      by = int(y+totalHeight+rectHeightMargin);
    } 
        
    // Grab whatever is going to be behind our tooltip...
    imageMode(CORNER);
    clip = get(bx-20,by-20,myWidth+rectWidthMargin+60,totalHeight+rectHeightMargin+60);
    clipx = bx-20;
    clipy = by-20;    
    
    //bx = x+10;
    //by = y - totalHeight;
 
        
    drawBalloon(bx,by-fontSize,myWidth,totalHeight);        
    drawText(mText,bx,by,fontSize)
  }
}