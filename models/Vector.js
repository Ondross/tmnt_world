Vector = function(x,y){
	this.x = x;
	this.y = y;

	this.add = function(other){
		var virtualx = other.x
		var virtualy = other.y
		if (other.x + this.x > mapx/2 + other.speed){virtualx -= mapx;}
		if (other.x + this.x < mapx/(-2)){virtualx += mapx;}
		if (other.y + this.y > mapy/2 + other.speed){virtualy -= mapy;}
		if (other.y + this.y < mapy/(-2)){virtualy += mapy;}

		result = new Vector(this.x + virtualx, this.y + virtualy);
		return result;
	};

	this.subtract = function(other){
		var virtualx = other.x;
		var virtualy = other.y;
		if (this.x - other.x > mapx/2 + 1){virtualx += mapx;}
		if (this.x - other.x < mapx/(-2)){virtualx -= mapx;}
		if (this.y - other.y > mapy/2 + 1){virtualy += mapy;}
		if (this.y - other.y < mapy/(-2)){virtualy -= mapy;}

		result = new Vector(this.x - virtualx, this.y - virtualy);
		return result;
	};

	this.multiply = function(scalar){
		var virtualx = this.x
		var virtualy = this.y
		if (this.x * scalar > mapx/2){virtualx -= mapx;}
		if (this.x * scalar < mapx/(-2)){virtualx += mapx;}
		if (this.y * scalar > mapy/2){virtualy -= mapy;}
		if (this.y * scalar < mapy/(-2)){virtualy += mapy;}

		result = new Vector(scalar * virtualx, scalar * virtualy);
		return result;
	};

	this.magnitude = function(){
		return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
	};

	this.unit_vector = function(){
		var distance = this.magnitude();
		if (distance==0){distance = .001;}
		result = new Vector(this.x/distance, this.y/distance);
		return result;
	};
};
