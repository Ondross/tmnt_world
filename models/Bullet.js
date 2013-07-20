var Bullet = function(pos, target, shooter){
	Dude.apply(this);

	this.target = target;
	this.pos = pos;
	this.shooter = shooter;
	this.speed = 3;
	this.damage = 1;
	this.range = 300;
	this.health = 1;
	this.dead = false;
};
Bullet.prototype = new Dude();

	Bullet.prototype.move = function(direction, speed){
		this.pos.x += direction.x * (speed);
		this.pos.y += direction.y * (speed);
		this.range -= speed;
		if (this.range <= 0){this.die()}

		if (this.pos.x<0){this.pos.x=mapx;}
		if (this.pos.x>mapx){this.pos.x=0;}
		if (this.pos.y<0){this.pos.y=mapy;}
		if (this.pos.y>mapy){this.pos.y=0;}
		var objects = turtles.concat(planets);
		objects = objects.concat(bullets);
		objects = objects.concat(baddies);
		for(var i=0; i<objects.length; i++){
			var object = objects[i];
			if (object != this.shooter && object != this){
				var dist = object.pos.subtract(this.pos).magnitude() - object.radius;
				if (dist < 1){
					object.health -= this.damage;
					object.radius -= this.damage;
					this.die();
					object.speed += .1;
				}
			}
		}
	};

	Bullet.prototype.die= function(){bullets.remove(this); this.shooter.bullets.remove(this)},

	Bullet.prototype.update= function(){
		this.direction = this.target.pos.subtract(this.pos).unit_vector();
		this.move(this.direction, this.speed);
		if(this.target.health <= 0 || this.health <=0 ){this.die()}
	};
