define :steam_game do
  app_path = "#{node[:steamcmd][:apps_dir]}/#{params[:name]}"
  
  template "/etc/init.d/#{params[:name]}" do
    source 'steam_game_service.erb'
    variables({ 
      name:          params[:name],
      pidfile:       "#{node[:steamcmd][:tmp_dir]}/#{params[:name]}.pid",
      screenpidfile: "#{node[:steamcmd][:tmp_dir]}/#{params[:name]}-screen.pid",
      root_dir:      app_path,
      daemon:        "#{app_path}/srcds_run",
      user:          node[:steamcmd][:user],
      title:         node[:steamcmd][params[:name].to_sym][:title],
      id:            node[:steamcmd][params[:name].to_sym][:id],
      game:          node[:steamcmd][params[:name].to_sym][:game],
      map:           node[:steamcmd][params[:name].to_sym][:map],
      ip:            node[:steamcmd][params[:name].to_sym][:ip],
      port:          node[:steamcmd][params[:name].to_sym][:port],
      maxplayers:    node[:steamcmd][params[:name].to_sym][:maxplayers]
    })
    owner 'root'
    group 'root'
    mode '0755'
  end

  service params[:name] do
    supports status: true, restart: true, reload: false
    action [ :enable, :start ]
  end
end
