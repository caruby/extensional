require 'extensional'

SPEC = Gem::Specification.new do |s|
  s.name          = "extensional"
  s.summary       = "Collects Class instances." 
  s.description   = <<-eof
    The extensional gem adds the ability of a Class to collect its instances.
    An extensional class is an Enumerable whose each method iterates over its instances.
    An optional callback block enables associative access to instances by key.
  eof
  s.version       = Extensional::VERSION
  s.date          = "2010-09-30"
  s.author        = "OHSU"
  s.email         = "caruby.org@gmail.com"
  s.homepage      = "http://github.com/caruby/extensional/"
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir.glob("{doc,lib,test}/**/*") + ['History.txt', 'LEGAL', 'LICENSE', 'README.md']
  s.require_paths = ['lib']
  s.has_rdoc      = 'extensional'
  s.rubyforge_project = 'caruby'
end