$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'extensional'
require 'rbconfig'

Extensional::VERSION.replace(ENV['EXTENSIONAL_VERSION']) if ENV['EXTENSIONAL_VERSION']
WINDOWS = (Config::CONFIG['host_os'] =~ /mingw|win32|cygwin/ ? true : false) rescue false
SUDO = WINDOWS ? '' : 'sudo'

desc "Builds the gem"
task :gem do
  load 'extensional.gemspec'
  Gem::Builder.new(SPEC).build
end

desc "Installs the gem"
task :install => :gem do
  sh "#{SUDO} gem install caruby-extensional-#{Extensional::VERSION}.gem --no-rdoc --no-ri"
end
