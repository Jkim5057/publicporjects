1 #!/usr/bin/env ruby


require 'awesome_print'
require 'aws-sdk-sns'
require 'aws-sdk-cloudwatch'
require 'aws-sdk-resources'




accountnum='--#--'          #<----------enter in your account number
bucketname="-----"     #<----------enter in your S3 bucket name
topicname="-----"       #<----------enter in your SNS endpoint


arnobj = Aws::ARN.new(partition: 'aws', service: 'sns', region: 'us-east-1',account_id: accountnum, resource: topicname)
topicarn = arnobj.to_s()
puts "Topic ARN: #{topicarn}"
MyLog.log.info"Topic ARN: #{topicarn}"
cw = Aws::CloudWatch::Client.new(region: 'your region') #<----------enter in your region
alarm_name = "Frequent Commits"

resp=cw.put_metric_alarm({
    alarm_name: alarm_name,
    alarm_description: "S3 Object maintenance; more then one object commit in one hour.", 
    alarm_actions: [ topicarn ],
    actions_enabled: true,
    metric_name: "NumberOfObjects",
    namespace: "AWS/S3",
    statistic: "Average",
    dimensions: [
        {
            name: "BucketName",
            value: bucketname
        },
        {
            name: "StorageType",
            value: "AllStorageTypes"
        }
    ], 
    period: 3600, 
    unit: "Count",
    evaluation_periods: 1, 
    threshold: 1, # One object.
    comparison_operator: "GreaterThanThreshold"
})
