module ProductsHelper
  def show_postee(user_id)
    user = User.find(user_id)
    full_name = "#{user.first_name} " + "#{user.last_name}"
    full_name
  end
end
