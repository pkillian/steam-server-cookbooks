cookbook_file "/etc/no-ip2.conf" do
  source "no-ip2.conf"
  mode 0755
  owner "root"
  group "root"
end

yum_repository "epel" do
  enabled true
end

yum_package "noip" do
end

service "noip" do
  action [:enable, :start]
end

