# aws-sdk-ruby-examples

aws-sdk-ruby sample codes

## Initial Setup

```.sh
bundle install
```

## sqs-xml

aws-sdk-core >= 3.192.0 may be not compatible with AWS SQS XML API.

### main.rb

1. Set `MY_SQS_URL` your sqs url

```.sh
export MY_SQS_URL="https://sqs.ap-northeast-1.amazonaws.com/000000000000/my_sqs_url"
```

2. Send message to the queue from AWS Management Console.

3. Execute a ruby script for receiving the message.

```.sh
bundle ex ruby sqs-xml/main.rb
```

You can customize gem versions with `AWS_SDK_CORE_VERSION` and `AWS_SDK_SQS_VERSION`.

#### Result

**aws-sdk-core 3.191.6 and aws-sdk-sqs 1.65.0**

You can receive the message.

```
#<struct Aws::SQS::Types::ReceiveMessageResult messages=[#<struct Aws::SQS::Types::Message message_id=... >]>
```

**aws-sdk-core 3.192.0 and aws-sdk-sqs 1.65.0**

You **cannot** receive the message.

```
#<struct Aws::SQS::Types::ReceiveMessageResult messages=[]>
```

**aws-sdk-core 3.192.0 and aws-sdk-sqs 1.66.0**

You can receive the message.

```
#<struct Aws::SQS::Types::ReceiveMessageResult messages=[#<struct Aws::SQS::Types::Message message_id=... >]>
```

### parse.rb

I prepared a dummy AWS SQS ReciveMessage response in XML format and a ruby script for parsing it.

Use aws-sdk-sqs 1.65.0

```
export AWS_SDK_SQS_VERSION=1.65.0
```

When aws-sdk-core is 3.191.6, 

```
export AWS_SDK_CORE_VERSION=3.191.6
bundle install
bundle ex ruby sqs-xml/parse.rb
```

parsing succeeds:

```
#<struct result=#<struct Aws::SQS::Types::ReceiveMessageResult messages=[#<struct Aws::SQS::Types::Message message_id="dummy", receipt_handle="dummy", md5_of_body="dummy", body="dummy", attributes={}, md5_of_message_attributes=nil, message_attributes={}>]>, response_metadata=#<struct request_id="dummy">>
```

When aws-sdk-core is 3.192.0,

```
export AWS_SDK_CORE_VERSION=3.191.6
bundle install
bundle ex ruby sqs-xml/parse.rb
```

we got an empty message:

```
#<struct result=#<struct Aws::SQS::Types::ReceiveMessageResult messages=[]>, response_metadata=#<struct request_id="dummy">>
```
