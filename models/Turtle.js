var Turtle = function(name, pos, radius, r, g, b) {
	this.name = name;
	this.pos = pos;
	this.radius = radius;
	this.speed = 1;  //per frame
	this.red = r;
	this.green = g;
	this.blue = b;
	this.health = radius;
	this.energy = 10;
	this.dead = false;
	this.bullets = [];

	this.mining = false;
	this.shooting = false;

	this.direction = new Vector(0,0);}


	Turtle.prototype = new Dude();

	Turtle.prototype.move = function(direction, speed){
		this.pos = this.pos.add(direction.multiply(speed));
		if (this.pos.x<0){this.pos.x=mapx;}
		if (this.pos.x>mapx){this.pos.x=0;}
		if (this.pos.y<0){this.pos.y=mapy;}
		if (this.pos.y>mapy){this.pos.y=0;}
		var objects = turtles.concat(planets);
		for(var i=0; i<objects.length; i++){
			var object = objects[i];
			if (object != this){
				var dist = this.pos.subtract(object.pos).magnitude() - this.radius - object.radius;
				if (dist <=0){
					this.move(this.pos.subtract(object.pos).unit_vector(), 2);
				}
			}
		}
	};

	Turtle.prototype.distance_to = function(object){
		return this.pos.subtract(object.pos).magnitude();
	};

	Turtle.prototype.closest = function(list, ignores){
		var closest_object = this;
		var closest_distance = 1000000;

		var new_list = list.slice();

		if (ignores){
			for (var i = 0; i < ignores.length; i++){
				new_list.remove(ignores[i]);
			}
		}

		for (var i=0; i<new_list.length; i++){
			var object = new_list[i];
			object_distance = this.distance_to(object);
			if (object_distance < closest_distance){
				closest_object = object;
				closest_distance = object_distance;
			}
		}
		return closest_object;
	};

	/*
	Turtle.prototype.find_closest_bullet = function(){
		var closest_bullet = this;
		var closest_distance = 1000000;
		for (var i=0; i<bullets.length; i++){
			var bullet = bullets[i];
			if (bullet.shooter != this){
				bullet_distance = this.pos.subtract(bullet.pos).magnitude();
				if (bullet_distance < closest_distance){
					closest_bullet = bullet;
					closest_distance = bullet_distance;
				}
			}
		}
		return closest_bullet;
	};

	Turtle.prototype.find_closest_planet = function(){
		var closest_planet = this;
		var closest_distance = 1000000;
		for (var i=0; i<planets.length; i++){
			var planet = planets[i];
			planet_distance = this.pos.subtract(planet.pos).magnitude();
			if (planet_distance < closest_distance){
				closest_planet = planet;
				closest_distance = planet_distance;
			}
		}
		return closest_planet;
	};
	*/

	Turtle.prototype.observe = function(){
		this.closest_turtle = this.closest(turtles, [this]);
		this.closest_bullet = this.closest(bullets, this.bullets);	
		this.closest_planet = this.closest(planets);	
	};

	Turtle.prototype.run = function(enemy){
		if (!enemy.dead){
			heading = enemy.pos.subtract(this.pos).unit_vector();
			this.direction = this.direction.subtract(heading);
		}
	};

	Turtle.prototype.chase = function(enemy){
		if (!enemy.dead){
			heading = enemy.pos.subtract(this.pos).unit_vector();
			this.direction = this.direction.add(heading);
		}
	};

	Turtle.prototype.think = function(){
	};

	Turtle.prototype.shoot = function(target){
		if (!target.dead && this.energy > 0){
			if (frameCount%60==0){
				var bullet1 = new Bullet(new Vector(this.pos.x, this.pos.y), target, this);
				bullets.push(bullet1);
				this.bullets.push(bullet1);
				this.energy--;
			}
		}
	};

	Turtle.prototype.mine = function(planet){
		heading = planet.pos.subtract(this.pos).unit_vector();
		this.direction = this.direction.add(heading);
		if (frameCount%60==0){
			if (this.pos.subtract(planet.pos).magnitude() < this.radius + planet.radius + 10){
				this.energy++;
				planet.energy--;
			}
		}
	};

	Turtle.prototype.update = function(){
		this.observe();
		this.think();
		this.direction = this.direction.unit_vector();
		this.move(this.direction, this.speed);
		this.direction = new Vector(0,0);
		if (this.health <= 0){this.die()}
	};

	Turtle.prototype.die = function(){
		turtles.remove(this);
		baddies.remove(this);
		this.dead = true;
	};
