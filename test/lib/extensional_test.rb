$:.unshift 'lib'

require 'extensional'

class Extended
  make_extensional

  def initialize
    Extended << self
  end
end

class Associative
  make_extensional { |hash, obj| hash[obj.label] = obj }

  attr_reader :label

  def initialize(label)
    @label = label
    Associative << self
  end
end

class CompoundKey
  make_extensional { |hash, obj| hash[obj.key] = obj }

  attr_reader :key

  def initialize(x, y)
    @key = [x, y]
    CompoundKey << self
  end
end

class CreateOnAccess
  make_extensional(Hash.new { |hash, label| hash[label] = CreateOnAccess.new(label) })

  def initialize(label)
    @label = label
  end
end

class AssociativeCreateOnAccess
  make_extensional(Hash.new { |hash, label| AssociativeCreateOnAccess.new(label) }) { |hash, obj| hash[obj.label] = obj }

  attr_reader :label

  def initialize(label)
    @label = label
    AssociativeCreateOnAccess << self
  end
end

class A
  make_extensional
  def initialize
    self.class << self
  end
end

class B < A
  make_extensional
end

class C < A
  make_extensional
end

class ExtensionalTest < Test::Unit::TestCase
  def test_extent
    assert_equal(Extended.new, Extended.to_a.first, "Instance not added to extension")
  end

  def test_associative
    obj = Associative.new(:test)
    assert_same(obj, Associative.for(:test), "Instance not accessible by label")
  end

  def test_compound_key
    obj = CompoundKey.new(:x, :y)
    assert_same(obj, CompoundKey.for(:x, :y), "Instance not accessible by compound key")
  end

  def test_hash_factory
    obj = CreateOnAccess.for(:test)
    assert_not_nil(obj, "Instance not created")
  end

  def test_associative_hash_factory
    obj = AssociativeCreateOnAccess.for(:on_demand)
    assert_not_nil(obj, "Instance not created")
    assert_same(obj, AssociativeCreateOnAccess.for(:on_demand), "Instance created on demand not accessible by label")
    obj = AssociativeCreateOnAccess.new(:by_new)
    assert(AssociativeCreateOnAccess.extent.association.has_key?(:by_new), "Instance not accessible by label")
  end

  def test_isolation
    a = A.new
    b = B.new
    c = C.new
    assert_equal([a], A.to_a, "Superclass extension incorrect")
    assert_equal([b], B.to_a, "Subclass extension incorrect")
    assert_equal([c], C.to_a, "Subclass extension incorrect")
  end
end