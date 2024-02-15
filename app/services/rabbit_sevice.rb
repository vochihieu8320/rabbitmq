require "bunny"

class RabbitSevice
  def initialize(message)
    @message = message
  end

  def perform
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue("bunny_queue") # Declare a queue    
    channel.default_exchange.publish(@message, routing_key: 'bunny_queue')
    connection.close #
  end

  def fanout_exchange
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel
    exchange = channel.fanout('logs')
    exchange.publish(@message)
  end
end