module.exports = {
    
    makeJSON: function () {
	    var dict = {}

	    for(i = 1; i < 11; i++) {
		    var randomNumber = Math.floor(Math.random() * 1000);
		    var testNum = "Test Number " + i;
		    dict[testNum] = randomNumber;
	    }

	    return dict
    }
};
