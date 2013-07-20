//Globals
$(function(){
mapx = 700;
mapy = 300;

stages = [];

speedup = $("#speedup");
speedup.click(function(){
	fRate += 10;
})

slowdown = $("#slowdown");
slowdown.click(function(){
	fRate -= 10;
})

playback = $("#playback");
playback.click(function(){
	fRate = 60;
})

//temporary. This will eventually be integrated into the canvas.
brainwasher = $("#brainwasher");
brainwasher.click(function(){

	new_brain = $("#brainwash_leo").val().toLowerCase();
	new_brain = new_brain.replace(/closest/g, "this.closest");
	new_brain = new_brain.replace(/chase/g, "this.chase");
	new_brain = new_brain.replace(/run/g, "this.run");
	new_brain = new_brain.replace(/mine/g, "this.mine");
	new_brain = new_brain.replace(/shoot/g, "this.shoot");
	new_brain = new_brain.replace(/distance_to/g, "this.distance_to")
	new_brain = new_brain.replace(/evade/g, "this.run")

	for (var i = 0; i < state.turtles.length; i++){
		var turtle = state.turtles[i];
		try{
			eval("turtles[" + i + "].think = function(){" + new_brain + "}");
			turtle.shooting = false;
			turtle.mining = false;
		}
		catch(err){
			console.log("You had an error");
			console.log("You're parsed code looks like: ");
			console.log(new_brain);
			console.log("It's probably my fault, but the error is: ");
			console.log(err.toString());
		}
	}
});

})