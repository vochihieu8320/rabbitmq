require "bunny"

class SubsciberService
  def perform
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start  # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue("test5") # Declare a queue
    channel.prefetch(1)
    begin # Consume messages
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      queue.subscribe(manual_ack: true, block: true) do |_delivery_info, _properties, body|
        puts " [x] Consumed message: []"
        puts body
        channel.ack(_delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      connection.close # Close the connection
      exit(0)
    end
  end

  def fanout_subscriber
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start  # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue('', exclusive: true)
    queue.bind('logs')
    
    puts ' [*] Waiting for logs. To exit press CTRL+C'

    begin
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] #{body}"
      end
    rescue Interrupt => _
      channel.close
      connection.close
    end
  end

  def sms_direct_subscriber
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start  # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue('', exclusive: true)
    exchange = channel.direct('noti')
    queue.bind(exchange, routing_key: "sms")
    puts ' [*] Waiting for logs. To exit press CTRL+C'
    begin
      queue.subscribe(block: true) do |delivery_info, _properties, body|
        puts " [x] #{delivery_info.routing_key}:#{body}"
      end
    rescue Interrupt => _
      channel.close
      connection.close
      exit(0)
    end
  end

  def email_direct_subscriber
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start  # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    exchange = channel.direct('noti') # declare the exchange
    queue = channel.queue('', exclusive: true) # declare the queue
    queue.bind(exchange, routing_key: "email") # binding exchange
    puts ' [*] Waiting for logs. To exit press CTRL+C'
    begin
      queue.subscribe(block: true) do |delivery_info, _properties, body|
        puts " [x] #{delivery_info.routing_key}:#{body}"
      end
    rescue Interrupt => _
      channel.close
      connection.close
      exit(0)
    end
  end
end