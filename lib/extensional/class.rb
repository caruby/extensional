require 'extensional/extent'

class Class
  # Adds the ability of a Class to collect its instances. An extensional class is an Enumerable
  # whose +each+ method iterates over its instances, e.g.:
  #   class Person
  #     make_extensional
  #     def initialize(ssn)
  #       @ssn = ssn
  #       Person << self
  #     end
  #     def to_s
  #       "#{self.class.name}{ssn=>#{@ssn}}"
  #     end
  #     ...
  #   end
  #   Person.new('555-55-5555')
  #   Person.join(', ') #=> Person{ssn=>555-55-5555}
  #
  # The optional callback block adds associative access to instances by key using the class #for method.
  # The callback block is called when an instance is added to the extent. The block arguments include the
  # key=>instance association hash and the new instance, e.g.:
  #   class Person
  #     make_extensional { |hash, person| hash[person.ssn] = person }
  #     ...
  #   end
  #   Person.for('555-55-5555') #=> nil
  #   Person.new('555-55-5555')
  #   Person.for('555-55-5555') #=> Person{ssn=>555-55-5555}
  #
  # The optional hash argument is the association hash. If the association hash is created with a block,
  # then the instance is added to the hash on demand when the #for method is called in accordance with
  # the standard Hash#new behavior, e.g.:
  #   class Person
  #     make_extensional(Hash.new { |hash, ssn| hash[snn] = new(ssn) })
  #     ...
  #   end
  #   Person.for('555-55-5555') #=> Person{ssn=>555-55-5555}
  #   Person.join(', ') #=> Person{ssn=>555-55-5555}
  #   Person.new('666-66-6666') # added to the extent but not the association since there is no callback block
  #   Person.map { |person| person.ssn }.sort #=> ["555-55-5555", "666-66-6666"]
  #   Person.for('666-66-6666') #=> nil
  #
  # The hash factory block above only adds an instance to the extent association if it is accessed using the
  # #for class method. If an instance can be created both on demand and independently of the #for method,
  # then specify both a factory block and a callback block, e.g.:
  #   class Person
  #     make_extensional(Hash.new { |hash, ssn| new(ssn) }) {|hash, person| hash[person.snn] = person }
  #     ...
  #   end
  #   Person.for('555-55-5555') #=> Person{ssn=>555-55-5555}
  #   Person.new('666-66-6666') # added to both the extent and the association
  #   Person.map { |person| person.ssn }.sort #=> ["555-55-5555", "666-66-6666"]
  #   Person.for('666-66-6666') #=> Person{ssn=>666-66-6666}
  #
  # Note that hash assignment is not needed in the hash initializer method, since there is a callback block
  # assigns the hash key to the new instance.
  #
  # This latter make_extensional alternative is the most flexible strategy, since it provides for both
  # iterative and associative access.
  #
  # If neither a callback block nor a hash is given, then associative access is disabled as described
  # in the Extensional#for method.
  def make_extensional(hash=nil, &block) # :yields: hash, instance
    @extent = Extent.new(hash, &block)
    extend(Extensional)
  end
end