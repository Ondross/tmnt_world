Array.prototype.remove = function(item){
	var found = false;
	for(var i = 0; i < this.length; i++){
		if (this[i] == item){
			this.splice(i, 1);
			found = true;
			break;
		}
	}
	if (found == false){}//console.log("Couldn't find object to dëlete");}
}

Array.prototype.property = function(property){
	properties = [];
	for(var i = 0; i < this.length; i++){
		eval("properties.push(this[i]." + property + ");");
	}
	return properties.flatten();
}

Array.prototype.flatten = function(){
	var flat_array = [];
	for(var i = 0; i < this.length; i++){
		if (this[i].constructor == Array){
			this[i] = this[i].flatten();
			flat_array = flat_array.concat(this[i]);
		}
		else { flat_array.push(this[i]); }
	}
	return flat_array;
}