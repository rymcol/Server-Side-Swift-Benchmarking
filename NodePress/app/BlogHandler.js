const content = require('./content')

module.exports = {
  	makeBlogContent: function () {

        var finalContent = "<section id=\"content\"><div class=\"container\">";
    	const generatedContent = content.generateContent();

    	for (i = 0; i < 6; i++) {
    		var randomIndex = Math.floor(Math.random() * 50);
    		var post = generatedContent[randomIndex];

            finalContent += "<div class=\"row blog-post\"><div class=\"col-xs-12\"><h1>"
            finalContent += post["postTitle"];
            finalContent += "</h1><img src=\""
            finalContent += post["featuredImageURI"];
            finalContent += "\" alt=\"";
            finalContent += post["featuredImageAltText"];
            finalContent += "\" class=\"alignleft feature-image img-responsive\" />";
            finalContent += "<div class=\"content\">";
            finalContent += post["postContent"];
            finalContent += "</div>";
    	}

        finalContent += "</div></div</div></section>";
    	return finalContent;
	}
};
