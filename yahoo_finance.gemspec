# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yahoo_finance/version"

Gem::Specification.new do |s|
  s.name        = "yahoo_finance"
  s.version     = YahooFinance::VERSION
  s.authors     = ["Rodrigo Navarro"]
  s.email       = ["reu@rnavarro.com.br"]
  s.homepage    = ""
  s.summary     = %q{Simple wrapper for yahoo finance API}
  s.description = %q{Simple wrapper for yahoo finance API}

  s.rubyforge_project = "yahoo_finance"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "vcr"
end
