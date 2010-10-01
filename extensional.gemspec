require 'extensional'
SPEC = Gem::Specification.new do |s|
  s.name          = "caruby-extensional"
  s.summary       = "Collects Class instances." 
  s.description   = <<-eof
    The extensional gem adds the ability of a Class to collect its instances.
    An extensional class is an Enumerable whose <tt>each</tt> method iterates over its instances.
    An optional callback block enables associative access to instances by key.
    Usage is described in the Class#make_extensional RDoc.
  eof
  s.version       = Extensional::VERSION
  s.date          = "2010-09-30"
  s.author        = "OHSU"
  s.email         = "loneyf@ohsu.edu"
  s.homepage      = "http://github.com/caruby/extensional/"
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir.glob("{lib,test}/**/*") + ['LEGAL', 'LICENSE', 'README.md']
  s.require_paths = ['lib']
  s.has_rdoc      = 'extensional'
  s.rubyforge_project = 'caruby'
end