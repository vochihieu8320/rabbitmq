<h1>What is Rabbit MQ</h1>
Rabbit Mq is a message broker that transfers messages from producer to consumer. U can think of rabbit mq like post offices. All you need to do is send a letter to the post offices and the post offices
will send it to the consumer

<h1>Why we need to use Rabbit MQ</h1>
There are 3 situations that we can consider to use Rabbit MQ:
<li>You have services and you want to sell your service to the client. If you do need to use Rabbit MQ, you have to modify your service for adding client information and handle shipping for clients. However, if you use Rabbit MQ, just tell a client to register with Rabbit MQ, and the Rabbit MQ will ship it for the client</li>
<li>If you want to communicate asynchronously between each service, you can consider using Rabbit MQ</li>
<li>If your service receives a lot of traffic at the same time, you can consider using Rabbit MQ to order your request, to distribute your request for multiple services.</li>

<h1>Message acknowledge</h1>
When rabbit mq sends a message to the consumer. If the rabbit mq server does not receive message confirmation from the consumer. They will put the message back into the queue.
<h3>With a message acknowledging if the consumer stops, they also receive a message back when they are online</h3>
This is the basic setup for subscriber

<img width="849" alt="Screenshot 2024-02-15 at 17 30 29" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/f42b210f-4ff4-4c07-b3b5-79845aeb6b93">

This is the basic setup for the producer

<img width="718" alt="Screenshot 2024-02-15 at 17 31 06" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/be1f9eed-c47d-4f35-93ea-0c24e8db41d2">

<h4>By default, Rabbit MQ uses Round-robin to distribute messages. That means each consumer will receive the same number of messages. For example, you have a service and you have 3 subscribers. If you publish 3 messages: A, B, C, consumer 1 will receive the message: A, consumer 2 will receive the message: B, and consumer 3 will receive the message: C. Please note there is no case consumer receives 2 or 3 messages.</h4>.

<h1>Durable, Persistent</h1>

We already considered solutions that consumers still receive messages even though they are offline. But what happens if the Rabbit Mq server dies, all messages will be lost. There is an option durable to prevent it. Please also add persistently. With the persistent option, Rabbit Mq will save it into the disk. With the Durable option, Rabbit Mq will save queue data into the disk

<img width="788" alt="Screenshot 2024-02-15 at 17 54 23" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/5d599807-f658-4931-98a0-eb13cb127298">
<img width="608" alt="Screenshot 2024-02-15 at 17 54 16" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/96e8dbfe-f185-4ea8-82ea-b36f4a9ef075">

<h1>Fair Dispatch</h1>

By default, Rabbit Mq will send any message without worry about number of message that acknowledge. Perharp, it can make one of the consumer overloaded. So u can use dispatch method to specific each consumer just receive one message, after completely handle message the consumer will continute receive message

<img width="574" alt="Screenshot 2024-02-16 at 09 25 43" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/e4187229-00a0-4ac9-929f-690e7e495746">

<h1>Publish/ Subcribe</h1>
This is one of the important topics In Rabbit Mq. There are four exchange types in Rabbit MQ: direct, fanout, header, and topic. 

<h2>Fanout</h2>

<img width="566" alt="Screenshot 2024-02-16 at 15 30 39" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/6d967ac6-5b28-4226-9fec-747f0abfcebd">

In fanount exchange, all the consumers will receive exactly the number of messages. That means if the producer publishes 2 messages each consumer will receive exactly 2 messages. Please be aware, that when a consumer subscribes to the channel, their queue will be clean. That means they don't receive previous messages, they just receive new messages.

This is the basic setup for the producer

<img width="1070" alt="Screenshot 2024-02-16 at 09 50 03" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/0c075965-c3ad-4c89-9f16-fb6e65920372">

This is the basic setup for consumer

<img width="1066" alt="Screenshot 2024-02-16 at 09 50 39" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/64fa370d-35c6-4b73-9b40-7f505ee1d8e2">


As you see in consumer we don't declare queue names, This queue will generate random names. Last of not least exclusive option will delete the consumer queue if they offline

<img width="1169" alt="Screenshot 2024-02-16 at 09 46 04" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/a1be3b33-4a78-4ad0-9ff2-aa35389fa306">

<h2>Direct</h2>

Similar to the fanout exchange, all consumers will receive exactly the number of message that the producer send. However, by using direct we can determine a group of users can receive messages. You 
may think you have to notify 10000 users. 5000 users register to receive messages by SMS other users only need to receive messages by email. By using direct exchange, you can send noti to all user and can specifically send an SMS queue for those registered SMS and an email queue for those registered emails<img width="563" alt="Screenshot 2024-02-16 at 15 42 05" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/93616747-ac26-4a17-850d-42914260e12f">
.

<img width="607" alt="Screenshot 2024-02-16 at 15 34 28" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/4417a304-5ff7-4032-bf25-3593ea9710b5">

I have set for producer I will publish noti for SMS and email, if the user registers sms they will receive a message from sms queue, and so on

<img width="942" alt="Screenshot 2024-02-16 at 15 59 30" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/b320b7fc-da12-409f-a34b-9a588638fa8a">


I have defined 2 subscribers: one for SMS and one for email

<img width="958" alt="Screenshot 2024-02-16 at 15 59 49" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/08ca05d1-0ac1-4ecc-93f8-4ecf115d19b4">
<img width="966" alt="Screenshot 2024-02-16 at 15 59 39" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/c3881cd7-ac26-4baa-99e2-9c4d358bf6e7">

Now see the achievement

<img width="1173" alt="Screenshot 2024-02-16 at 16 03 38" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/22b0dcde-fa45-44cc-8501-95e94b9fd61e">
<img width="1173" alt="Screenshot 2024-02-16 at 16 03 29" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/eb7f4507-a5af-411d-868f-57c850727004">
<img width="1178" alt="Screenshot 2024-02-16 at 16 03 20" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/64aeb385-3ee2-47af-836d-23f6f5f13af3">


<h2>Topic</h2>
In direct exchange, instead of sending all messages like fanout exchange, we use direct exchange from that exchange only send messages for specific routing keys. Please consider you have notifications, users can pick what kind of information they want to receive notifications. For example, if they want to receive messages from pop music, you can easily use direct exchange with routing key pop But if they want more specific like only want to receive messages from Taylor Swift. How can we handle this, we can't create a queue for each singer. This topic exchange will handle it.

There are 3 wildcards can use here: *,#. 
<li>* only one word can be used after that</li>
<li>* 0 or many word</li>
For example:
a.b* => only access a.b.c not a.b.c.d or a.b
a.b# => access a.b or a.b.c.d
<img width="636" alt="Screenshot 2024-02-16 at 17 18 04" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/8be104a0-058a-4ca9-87fa-e3f0f24a6cdc">


<h2>Header exchange</h2>

Similar to direct exchange but instead of routing key rabbit Mq use headers to match with all and any. If you use all settings, that means the consumer will match exactly producer header to receive and if you use any settings, that mean consumer will match any producer header. 
