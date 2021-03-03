#!/usr/bin/env ruby

#Delete a trail from a specified region that you can provide before running this script
#Make sure to enter in variable information


require 'awesome_print'
require 'aws-sdk-cloudtrail'


name="----"                 #<-----------enter trail name to delete
regiontouse="----"          #<-----------enter region




client = Aws::CloudTrail::Client.new(region: regiontouse)
begin
    resp = client.delete_trail({
        name: name, # required
    })
    ap resp
    MyLog.log.info resp
    puts 'Deleted ' + name + ' in '+ regiontouse + ' Successfully'
    MyLog.log.info 'Deleted ' + name + ' in '+ regiontouse + ' Successfully'
    MyLog.log.info resp
    
rescue StandardError => err
    puts 'Error deleting' + name
    puts err
exit 1
end
