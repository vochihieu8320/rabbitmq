require 'sendgrid-ruby'
include SendGrid

class SendGridService
  def perform

    from = Email.new({email: 'your_email@example.com', name: 'Your Name'})
    to = Email.new({email: 'recipient@example.com'})
    subject = 'Your Subject'
    content = Content.new({type: 'text/plain', value: 'Hello, this is the body of the email.'})

    mail = Mail.new(from, subject, to, content)

    # Set up additional parameters including the "from" object
    mail.from = from

    # Create a SendGrid client
    sg = SendGrid::API.new(api_key: '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')

    # Send the email
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    # Check the response
    puts response.status_code
    puts response.body
    puts response.headers

  end
end