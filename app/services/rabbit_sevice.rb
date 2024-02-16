require "bunny"

class RabbitSevice
  def initialize(message)
    @message = message
  end

  def perform
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel # Declare a channel
    queue = channel.queue("test5") # Declare a queue    
    channel.default_exchange.publish(@message, routing_key: 'test5', persistent: true)
    connection.close #
  end

  def fanout_exchange
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel
    exchange = channel.fanout('logs')
    exchange.publish(@message)
  end

  def direct_exchange
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel
    exchange = channel.direct('noti')
    exchange.publish(@message, routing_key: "sms")
    exchange.publish(@message, routing_key: "email")
  end

  def topic_exchange
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel
    exchange = channel.topic('topic_logs')
    exchange.publish(@message, routing_key: "animal.monkey")
    exchange.publish(@message, routing_key: "monkey.red")
  end

  def header_exchange
    connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
    connection.start # Start a connection with the CloudAMQP server
    channel = connection.create_channel
    exchange = channel.headers('example_exchange')
    exchange.publish("8 cores/Linux", :headers => {"os" => "linux", "cores" => 8})
  end
end