struct CommonHandler {
    
    func getHeader() -> String {
        return "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\"><title>PerfectPress</title><link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css\"><link rel=\"stylesheet\" type=\"text/css\" href=\"/inc/slick.css\"/><link rel=\"stylesheet\" type=\"text/css\" href=\"/inc/slick-theme.css\"/><link rel=\"stylesheet\" href=\"/style.css\"></head><body><header><div class=\"container\"><div class=\"row\"><div class=\"col-sm-6\"><a href=\"/\"><img src=\"/img/logo@2x.png\" class=\"logo img-responsive\" id=\"header-logo\" /></a></div><div class=\"col-sm-6 text-right\"><nav><ul><li><a href=\"/\">Home</a></li><li><a href=\"/blog\">Blog</a></li></ul></nav></div></div></div></header>"
    }
    
    func getFooter() -> String {
        return "<footer><script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\"></script><script type=\"text/javascript\" src=\"http://code.jquery.com/jquery-1.11.0.min.js\"></script><script type=\"text/javascript\" src=\"http://code.jquery.com/jquery-migrate-1.2.1.min.js\"></script><script type=\"text/javascript\" src=\"https://raw.githubusercontent.com/kenwheeler/slick/master/slick/slick.min.js\"></script><script src=\"/inc/dynamics.min.js\"></script><script src=\"/inc/animations.js\"></script></footer></body></html>"
    }
    
}
