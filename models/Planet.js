var Planet = function(vector, radius, r, g, b){
	Dude.apply(this);

	this.pos = vector;
	this.radius = radius;
	this.red = r;
	this.green = g;
	this.blue = b;
}
Planet.prototype = new Dude();

Planet.prototype.update = function(){
	this.move(this.direction, this.speed);
}