require "bunny"

class RabbitService
  def perform
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue("bunny_queue") # Declare a queue    
    channel.publish('Hello World!', routing_key: 'bunny_queue')
    connection.close #
  end
end