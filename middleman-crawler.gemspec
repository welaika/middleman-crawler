# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-crawler"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["weLaika", "Filippo Gangi Dino"]
  s.email       = ["info@welaika.com"]
  s.homepage    = "http://dev.welaika.com"
  s.summary     = %q{crawler for Middleman site}
  s.description = %q{it starts a crawler for Middleman sites}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.1.9"])

  # Additional dependencies
  s.add_runtime_dependency("rawler", "~> 0.1.8")
end
