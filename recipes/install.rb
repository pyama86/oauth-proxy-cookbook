
name = "oauth2_proxy-#{node["oauth2_proxy"]['version']}.linux-amd64.go1.8.1"

c = Chef::Config[:file_cache_path]
remote_file "#{c}/#{name}.tar.gz" do
  source "https://github.com/bitly/oauth2_proxy/releases/download/v#{node["oauth2_proxy"]['version'].gsub(/\.[0-9]*$/, '')}/#{name}.tar.gz"
  notifies :run, 'execute[install_oauth2_proxy]'
end

execute 'install_oauth2_proxy' do
  command "tar xf #{name}.tar.gz;mv #{name}/oauth2_proxy /usr/bin/oauth2_proxy"
  cwd c
  action :nothing
end
