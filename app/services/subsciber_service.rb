require "bunny"

class SubsciberService
  def perform
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start  # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue("bunny_queue") # Declare a queue
    
    begin # Consume messages
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] Consumed message: []"
        puts _delivery_info
        puts _properties
        puts body
      end
    rescue Interrupt => _
      connection.close # Close the connection
      exit(0)
    end
  end
end