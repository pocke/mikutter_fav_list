#-*- coding: utf-8 -*-

# Copyright 2013, pocket
# Licensed MIT
# http://opensource.org/licenses/mit-license.php

Plugin.create(:fav_list) do
  settings 'fav_list' do
    input 'list name', :fav_list_name
    #adjustment 'user limit', :fav_list_limit, 1, 5000
  end

  on_favorite do |service, user, msg|
    break unless service.user == user.to_s
    (Service.primary.twitter/'lists/members/create').json(
      slug: UserConfig[:fav_list_name],
      owner_screen_name: service.user,
      screen_name: msg.user
    )
  end
end
