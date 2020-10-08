# frozen_string_literal: true

action :create do
  systemd_service "oauth_proxy_#{new_resource.name}" do
    unit_description "Systemd unit for oauth proxy #{new_resource.name}"
    after %w(network.target)
    install do
      wanted_by 'multi-user.target'
    end

    exec_start = [
      "/usr/bin/oauth2-proxy",
      "-http-address=#{new_resource.listen}",
      "-redirect-url=#{new_resource.redirect_url}",
    ]

    new_resource.options.each do |k,v|
      if %w(whitelist_domain cookie_domain).include?(k.to_s)  && v.is_a?(Array)
        v.each do |vv|
          exec_start << "-#{k.to_s.gsub(/_/, '-')}=#{vv}"
        end
      else
        exec_start << "-#{k.to_s.gsub(/_/, '-')}=#{v}"
      end
    end
    service do
      type 'simple'
      exec_start exec_start.join(" ")
      restart 'on-failure'
      restart_sec '30s'
    end
    verify false
  end
end

action :delete do
  systemd_service "oauth_proxy_#{new_resource.name}" do
    action :delete
    verify false
  end
end
