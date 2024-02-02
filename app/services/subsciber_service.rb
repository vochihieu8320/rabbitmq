require "bunny"

class SubsciberService
  def perform
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start  # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue("bunny_queue") # Declare a queue
    
    begin # Consume messages
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      queue.subscribe(manual_ack: true, block: true) do |_delivery_info, _properties, body|
        puts " [x] Consumed message: []"
        Order.create({product_id: 1, price: 2000, quantity: 1})
        puts body
        channel.ack(_delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      connection.close # Close the connection
      exit(0)
    end
  end
end