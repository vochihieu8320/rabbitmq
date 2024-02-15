class SendSmsService
    def perform
        connection = Bunny.new("amqps://iecdgjsz:nOouVvT4l56VKVCuWOu43NmsFc34_I3L@cougar.rmq.cloudamqp.com/iecdgjsz")
        connection.start  # Start a connection with the CloudAMQP server
        channel = connection.create_channel # Declare a channel
        exchange = channel.fanout('logs')
        queue = channel.queue('', exclusive: true)
        queue.bind(exchange)
        puts ' [*] Waiting for logs. To exit press CTRL+C'

        begin
        queue.subscribe(block: true) do |_delivery_info, _properties, body|
            puts "I will send sms"
            puts " [x] #{body}"
        end
        rescue Interrupt => _
        channel.close
        connection.close
        end
    end
end