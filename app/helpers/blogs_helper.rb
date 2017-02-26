module BlogsHelper
  def is_owner?
    current_user && current_user.id == @blog.user_id
  end
end
