module UsersHelper
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => h(user.display_name),
                                            :class => 'gravatar',
                                            :gravatar => options)
  end

  def status_for(user)
    return "online with battery at #{@user.last_battery_value}%" if user.online_status?
    return "offline"
  end

end
