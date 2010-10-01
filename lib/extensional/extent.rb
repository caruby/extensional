require 'forwardable'
require 'set'

# An Extent is a thin Array wrapper with optional associative access.
class Extent
  include Enumerable

  # The key=>instance association hash.
  attr_reader :association

  # Creates a new Extent. The block is called when an instance is added to the extent.
  def initialize(hash=nil, &block) # :yields: hash, instance
    @extent = Set.new
    @association = hash
    @association ||= {} if block_given?
    @callback = block
  end

  # Adds the given obj to this extent.
  def <<(obj)
    @callback.call(@association, obj) if @callback
    @extent << obj
  end

  # Calls the given block an each instance in this extent.
  def each(&block)
    @extent.each(&block)
  end

  # Returns whether this Extent implements associative access by key.
  def associative?
    not @association.nil?
  end

  # Returns the instance for the given key.
  #
  # Raises NotImplementedError if this extent does not implement associative access.
  def find(key)
    raise NotImplementedError.new("Associative access by key is not implemented for this class extent") unless associative?
    @association[key]
  end

  # Removes all instances from this Extent's extent and association.
  def clear
    @extent.clear
    @association.clear if associative?
  end
end