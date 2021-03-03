#!/usr/bin/env ruby

#Look up events from a Cloudtrail you've created
#Maintain awareness of API access
#Can be used monitor for security purposes


$LOAD_PATH << "."
require 'awesome_print'
require 'aws-sdk-cloudtrail'

regionname='---your-region---'

def show_event(event)
    puts 'Event Name: ' + event.event_name.to_s
    puts 'Event ID: ' + event.event_id.to_s
    puts 'Event Time: '+event.event_time.to_s
    puts 'For User: '+event.username.to_s
    puts 'Resources as listed:' 
    event.resources.each do |r|
        puts ' Name: ' + r.resource_name
        puts ' Type: ' + r.resource_type
    end
end
client = Aws::CloudTrail::Client.new(region: regionname)
resp = client.lookup_events()
ap resp
MyLog.log.info resp
puts "Found #{resp.events.count} events in your region:"
resp.events.each do |e|
    show_event(e)
end
 
