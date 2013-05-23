# vim: tabstop=2 shiftwidth=2 softtabstop=2

# Module: 'flashcache' A module for managing Flashcache
# Author: Morphlabs <Aimon Bustardo (me at aimon dot net)>
# Descr:  This module enables the management of Flashcache settings.
#         It will put your flashcache uuid into a fact 'flashcache_uuid'
#         and put all defined properties into facts 'flashcache_<property>'.
#         Any property that exists on system can be set from this module.

Puppet::Type.type(:flashcache_property).provide(:flashcache_property) do
  @doc = "Manage Flashcache properties"

  def uuid
    resource[:uuid]
  end

  def property
    resource[:property]
  end

  def value
    resource[:value]
  end
  
  def create
    begin
      pfile=File.new("/proc/sys/dev/flashcache/#{uuid}/#{property}", 'w+')
      res = pfile.puts(value)
      pfile.close
      return true
    rescue Exception => e
      raise(Puppet::Error, "Flashcache ERROR: #{e}")
    end
  end

  def destroy
    puts "WARNING: Not Implemented."
  end
 
  def exists?
    begin
      pfile=File.new("/proc/sys/dev/flashcache/#{uuid}/#{property}", 'r')
      old_value = pfile.getc
      pfile.close
      if old_value == value
        return true
      else
        return false
      end
    rescue Exception => e
      raise(Puppet::Error, "Flashcache ERROR: #{e}")
    end
  end
end
