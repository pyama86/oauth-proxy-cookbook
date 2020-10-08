c = Chef::Config[:file_cache_path]
name = "oauth2-proxy-v#{node["oauth2_proxy"]['version']}.linux-amd64.tar.gz"
remote_file "#{c}/#{name}" do
  source "https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v#{node["oauth2_proxy"]['version']}/#{name}"
  notifies :run, 'execute[install_oauth2_proxy]'
end

execute 'install_oauth2_proxy' do
  command "tar xf #{name};mv oauth2-proxy-v#{node["oauth2_proxy"]['version']}.linux-amd64/oauth2_proxy /usr/bin/oauth2-proxy"
  cwd c
  action :nothing
end
