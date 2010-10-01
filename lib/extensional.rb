require 'forwardable'
require 'set'
require 'extensional/class'

# An Extensional Class collects its instances.
# See Class#make_extensional for the usage model.
module Extensional
  include Enumerable

  # This Extensional implementation version.
  VERSION = '2010.1'

  # Returns this Extensional class's Extent.
  def extent
    @extent
  end

  # Returns the instance with the given key arguments, or nil if no association is found.
  #
  # Raises NotImplementedError if the class extent does not implement associative access.
  def for(*key)
    unless @extent.associative? then
      raise NotImplementedError.new("Associative access by key is not implemented for #{self}")
    end
    # extract the key argument from a key array with zero or one members;
    # if key has more than one member, the key remains an array of all arguments
    key = key.first if key.size == 1
    @extent.find(key)
  end

  # Adds an instance of this class to the class extent.
  def <<(instance)
    @extent << instance
  end

  # Calls block an each instance in this class's extent.
  def each(&block)
    @extent.each(&block)
  end

  # Clears this class's extent.
  def clear
    @extent.clear
  end
end
