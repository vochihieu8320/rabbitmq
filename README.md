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
This is one of the important topic In Rabbit Mq.There are four exchange types in Rabbit MQ: direct, faount, header, topic. In fanount exchange, all the consumer will be received exactly number of messages. That mean if the producer publish 2 messages each consumer will be received exactly 2 message. Please be noitce, when consumer subcribe for the channel, their queue will be clean. That mean they dont receive old message, they just receive new message.

This is basic setup for producer

<img width="1070" alt="Screenshot 2024-02-16 at 09 50 03" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/0c075965-c3ad-4c89-9f16-fb6e65920372">

This is basic setup for consumer

<img width="1066" alt="Screenshot 2024-02-16 at 09 50 39" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/64fa370d-35c6-4b73-9b40-7f505ee1d8e2">


As you see in consumer we dont declare queue name, This queue will be generated random name. Last of not least exclusive option will delete consumer queue if they offline

<img width="1169" alt="Screenshot 2024-02-16 at 09 46 04" src="https://github.com/vochihieu8320/rabbitmq/assets/51293321/a1be3b33-4a78-4ad0-9ff2-aa35389fa306">







