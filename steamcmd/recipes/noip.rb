cookbook_file "/etc/no-ip2.conf" do
  source "no-ip2.conf"
  mode 0755
  owner "root"
  group "root"
end

execute "enable EPEL repository" do
  command "yum-config-manager --enable epel"
end

yum_package "noip" do
end

service "noip" do
  action [:enable, :start]
end

