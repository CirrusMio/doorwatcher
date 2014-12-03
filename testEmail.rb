require 'mail'


options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'gmail.com',
            :user_name            => 'cirrusmioat',
            :password             => 'soserious',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

  #Apply options
Mail.defaults do
 delivery_method :smtp, options
end

  #Send a test message
Mail.deliver do
      to 'mtshro2@gmail.com, tyler.shipp@uky.edu'
    from 'cirrusmioat@gmail.com'
 subject 'testing sendmail'
    body 'testing sendmail'
  attachments['testattach.txt'] = File.read('testattach.txt')
end
