class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Будь-ласка активуйте Ваш новий обліковий запис'
  
    @body[:url]  = activate_url(user.activation_code)
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Ваш обліковий запис активовано!'
    @body[:url]  = root_url
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "Zwitter"
      @subject     = "[#{root_url}]"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
