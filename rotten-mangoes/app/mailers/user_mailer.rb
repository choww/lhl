class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default from: 'yay@yay.yay'

  def delete_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account has been deleted')
  end
end
