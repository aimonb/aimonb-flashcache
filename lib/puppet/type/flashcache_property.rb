# vim: tabstop=2 shiftwidth=2 softtabstop=2

# Module: 'puppet-flashcache' A module for managing Flashcache
# Author: Aimon Bustardo (me at aimon dot net)
# Descr:  This module enables the management of Flashcache settings.
#         It will put your flashcache uuid into a fact 'flashcache_uuid'
#         and put all defined properties into facts 'flashcache_<property>'.
#         Any property that exists on system can be set from this module.

Puppet::Type.newtype(:flashcache_property) do
  @doc = "Manage Flashcache properties"

  ensurable

  newparam(:uuid, :namevar => :true) do
     desc "The UUID of the flashcache device to manage"
     newvalues(/^([a-z]{2}[1-9][0-9]{2,4})\+[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$/)
  end 

  newproperty(:property) do
     desc "The name of the property to manage"
     newvalues(/^[a-z_]+$/) 
  end 
  
  newproperty(:value) do
    desc "Property Value"
    newvalues(/^[0-9]+$/)
  end 
  
end
