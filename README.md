# Puppet Flashcache
Puppet module for managing flashcache device properties. Currently this  
module detects one flashcache device only, additional device UUIDs can be  
managed by manually setting the uuid property to flashcache\_property.

## Facts
This modules sets a number of Facts read from the client system:  

    $::flashcache_uuid        # This is ready from /proc/sys/dev/flashcache/
    $::flashcache_<property>  # This is dynamically created, one for each   
                              # in /proc/sys/dev/flashcache/$::flashcache_uuid/  

## Type and Provider
This module defines a new Type and Provider "flashcache\_property" for  
managing Flashcache device properties. The device UUID can be retreived via  
the set fact or inserted to other valid value. Any attempt to set a value  
for a property on a non existent device UUID will raise an error. Any attempt  
to set a value for a non existent property will raise an error.  

### Example

    $property='fallow_delay'
    flashcache_property{"${::flashcache_uuid}_${property}":
      ensure    =>  present,
      uuid      =>  $::flashcache_uuid,
      property  =>  $property,
      value     =>  900,
    }

