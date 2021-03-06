# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "inside_sales/version"

Gem::Specification.new do |s|
  s.name        = "inside_sales"
  s.version     = InsideSales::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Guterl"]
  s.email       = ["mguterl@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{InsideSales API}
  s.description = %q{InsideSales API}

  s.rubyforge_project = "inside_sales"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rest-client"
  s.add_dependency "json"

  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end
