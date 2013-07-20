$(function() {

	//TODO, make this a function that initializes when the level loads, not the page.

stage0 = new Stage(0, "Stage 0:\n\nNo Pizza,\nNo Party");
stages.push(stage0);

stage0.bullets = [];
stage0.win_condition = "turtles.length > 3 && baddies.length <= 0"
stage0.loss_condition = "turtles.length < 3 && baddies.length > 0"



//PLANETS
mars = new Planet(new Vector(20, 20), 30, 200, 80, 20);
mars.name = "Mars";
mars.direction = new Vector(.4, .6);
mars.energy = 100;
mars.speed = .5;

mercury = new Planet(new Vector(400, 30), 18, 200, 200, 200);
mercury.name = "Mercury";
mercury.direction = new Vector(-.1, -.5);
mercury.energy = 100;
mercury.speed = .8;

stage0.planets = [mars, mercury];



//TURTLES
ralph = new Turtle("Ralph", new Vector(100, 200), 20, 20, 100, 28);//204, 28,28);
ralph.think = function(){
	this.mine(mars);
	this.run(this.closest_bullet);
}

leo = new Turtle("Leo", new Vector(450, 250), 30, 20, 100, 28);//204, 28,28);0, 136, 206);
leo.think = function(){};

donna = new Turtle("Donna", new Vector(200, 200), 15, 20, 100, 28);//204, 28,28);114, 132, 194);
donna.think = function() {
	this.run(this.closest_bullet);
	if (this.energy < 10){this.mine(mars);}
}

mitch = new Turtle("Mitch", new Vector(400, 200), 30, 20, 100, 28);//204, 28,28);231, 120, 23);
mitch.think = function() {
	if (this.energy < 10){
		this.mine(mars);
	}
	else{
	this.chase(this.closest_turtle);
	}
	this.shoot(this.closest_turtle);
}

stage0.turtles = [
    leo,
    ralph,
    donna,
    mitch
];

//Baddies
badman = new Turtle("Badman", new Vector(100, 100), 25, 0, 0, 0);
badman.think = function() {
	if (this.energy < 10){
		this.mine(mars);
	}
	else{
	this.chase(this.closest_turtle);
	}
	this.shoot(this.closest_turtle);
}

stage0.baddies = [
	badman
]

})