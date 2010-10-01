extensional: Class extent collector
===================================

**Git**:          [http://github.com/caruby/extensional](http://github.com/caruby/extensional)    
**Author**:       OHSU Knight Cancer Institute    
**Copyright**:    2010    
**License**:      MIT License    
**Latest Version**: 2010.1    
**Release Date**: September 30th 2010    

Synopsis
--------

The extensional gem adds the ability of a Class to collect its instances.
An extensional class is an Enumerable whose each method iterates over its instances.
An optional callback block enables associative access to instances by key.

Feature List
------------

1. Add instances to a Class extent

2. Associative access by a designated key

3. Custom unit definition

4. Measurement parser

Installing
----------

To install UOM, use the following command:

    $ gem install caruby-uom

(Add `sudo` if you're installing under a POSIX system as root)

Alternatively, if you've checked the source out directly, you can call
`rake install` from the root project directory.

Usage
-----

An extensional class is an Enumerable whose <tt>each</tt> method iterates over its instances, e.g.:

    class Person
      make_extensional
    end
    Employee.new(20195) #=> Employee@2653
    Employee.to_a #=> [Employee@2653]

An optional callback block adds associative access to instances by key using the class <tt>for</tt>
method, e.g.:

    class Employee
      make_extensional { |hash, emp| hash[emp.number] = emp }
      ...
    end
    Employee.for(20196) #=> nil
    Employee.new(20196) #=> Employee@2654
    Employee.for(20196) #=> Employee@2654

The Class.make_extensional RDoc includes additional examples.

Changelog
---------

- **September.30.10**: 2010.1 release
    - Initial public release

Copyright
---------

UOM &copy; 2010 by [OHSU](mailto:loneyf@ohsu.edu).
UOM is licensed under the MIT license. Please see the {file:LICENSE} and {file:LEGAL}
documents for more information.
