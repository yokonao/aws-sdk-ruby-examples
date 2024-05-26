require 'debug'
require 'aws-sdk-sqs'

url = ENV['MY_SQS_URL']
raise 'MY_SQS_URL is required' if url.nil?

p Aws::SQS::Client.new.build_request(:receive_message, queue_url: url).send_request
