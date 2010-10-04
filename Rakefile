$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'extensional'
require 'rbconfig'

# the gem name
GEM = 'extensional'
GEM_VERSION = Extensional::VERSION
GEM_VERSION.replace(ENV['EXTENSIONAL_VERSION']) if ENV['EXTENSIONAL_VERSION']

WINDOWS = (Config::CONFIG['host_os'] =~ /mingw|win32|cygwin/ ? true : false) rescue false
SUDO = WINDOWS ? '' : 'sudo'

# the archive include files
TAR_FILES = Dir.glob("{bin,lib,sql,*.gemspec,doc/website,test/{bin,fixtures,lib}}") +
  ['.gitignore', 'History.txt', 'LEGAL', 'LICENSE', 'Rakefile', 'README.md']

desc "Builds the gem"
task :gem do
  load "#{GEM}.gemspec"
  Gem::Builder.new(SPEC).build
end

desc "Installs the gem"
task :install => :gem do
  sh "#{SUDO} gem install #{GEM}-#{GEM_VERSION}.gem --no-rdoc --no-ri"
end

desc "Archives the source"
task :tar do
  if WINDOWS then
    sh "echo Windows archive not supported"
  else
    sh "tar -czf #{GEM}-#{GEM_VERSION}.tar.gz #{TAR_FILES.join(' ')}"
  end
end