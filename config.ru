# encoding: utf-8

require File.expand_path("../rack_try_static", __FILE__)
require 'rack/rewrite'

use Rack::Rewrite do
  r301 '/lifegroups', 'https://docs.google.com/a/gtccf.org/spreadsheet/viewform?formkey=dDAwS0x1cHhUNTU1OWVwcGQ1YnhOaEE6MQ#gid=0'
end

use ::Rack::TryStatic,
  :root => "build",
  :urls => ["/"],
  :try  => [".html", "index.html", "/index.html"]

run lambda { [404, {"Content-Type" => "text/html"}, File.read('404.html')] }
