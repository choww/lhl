module UsersHelper
  
  def user_modal_header(action)
    action == 'new' ? "Sign Up" : "Edit Profile"
  end
end
