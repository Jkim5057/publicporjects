#!/usr/bin/env ruby

require 'aws-sdk-s3'
require 'awesome_print'

#Send a file by key name from one bucket to another
#Simple transfer
#Configurable to add step functions


bucket_origin = '--origin--'                          #<---------- Enter bucket of origin
bucket_destination = '--destination--'                #<---------- Enter bucket destination
obj_key = '--name of file(s)--'                       #<---------- Enter object name (file name)
s3 = Aws::S3::Client.new(region: '--region--')        #<---------- Enter region name of buckets




resp=s3.copy_object(bucket: to_bucket,copy_source: "#{bucket_origin}/#{obj_key}",key: obj_key)
puts "Sending #{obj_key} from #{bucket_origin} to #{bucket_destination}"
puts "Response: #{resp}"
puts "Send Object(s) to Bucket (#{bucket_destination}):"
s3.list_objects({bucket: bucket_destination,}).contents.each do |item|
    puts " Name: #{item.key}"
end
puts ""
puts "Objects from bucket (#{bucket_origin}):"
s3.list_objects({bucket: bucket_origin,}).contents.each do |item|
    puts " Name: #{item.key}"
end
