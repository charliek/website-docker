name              "blog"
maintainer        "Charlie Knudsen"
maintainer_email  "charlie.knudsen@gmail.com"
license           "Apache 2.0"
description       "Recipe to show how to use docker with chef"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ docker nginx apt }.each do |cb|
  depends cb
end
