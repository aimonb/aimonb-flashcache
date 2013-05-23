# vim: tabstop=2 shiftwidth=2 softtabstop=2

# Module: 'aimonb-flashcache' A module for managing Flashcache
# Author: Aimon Bustardo (me at aimon dot net)
# Descr:  Custom facts for managing flashcache

flashcache_facts = {}
# Get UUIDs
if File.exist?("/proc/sys/dev/flashcache")
  uuid = Dir.entries('/proc/sys/dev/flashcache')[2]
  flashcache_facts['flashcache_uuid'] = uuid
  # Get all settings for UUID
  Dir.entries("/proc/sys/dev/flashcache/#{uuid}")[2..-1].each do |prop|
    flashcache_facts["flashcache_#{prop}"] = File.new("/proc/sys/dev/flashcache/#{uuid}/#{prop}").gets 
  end

  flashcache_facts.each do |fact, value|
    Facter.add(fact) do
      setcode do
        value
      end
    end
  end
end
