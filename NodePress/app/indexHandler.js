const content = require('./content')

module.exports = {
  	makeIndexContent: function () {

	var generatedContent = content.generateContent();
    const firstContent = generatedContent[0];

    var finalContent = "<section id=\"content\"><div class=\"container\"><div class=\"row\"><div class=\"banner center-block\"><div><img src=\"/img/banner@2x.png\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-1.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-2.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-3.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-4.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div> <div><img src=\"/img/random/random-5.jpg\" alt=\"Swift Based Blog\" class=\"img-responsive banner center-block\" /></div></div></div><div class=\"row\"><div class=\"col-xs-12\"><h1>";

    finalContent += firstContent["postTitle"];
    finalContent += "</h1><img src=\"";
    finalContent += firstContent["featuredImageURI"];
    finalContent += "\" alt=\"";
    finalContent += firstContent["featuredImageAltText"];
    finalContent += "\" class=\"alignleft feature-image img-responsive\" />";
    finalContent += "<div class=\"content\">";
    finalContent += firstContent["postContent"];
    finalContent += "</div>";
    finalContent += "</div></div</div></section>";

    return finalContent;
	}


};
