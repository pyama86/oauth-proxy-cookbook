# frozen_string_literal: true

action :create do
  systemd_service "oauth_proxy_#{new_resource.name}" do
    unit_description "Systemd unit for oauth proxy #{new_resource.name}"
    after %w(network.target)
    install do
      wanted_by 'multi-user.target'
    end

    exec_start = [
      "/usr/bin/oauth2_proxy",
      "-http-address=#{new_resource.listen}",
      "-redirect-url=#{new_resource.redirect_url}",
      "-upstream=#{new_resource.redirect_url}"
    ]

    exec_start << "-email-domain=#{new_resource.email_domain}" if new_resource.email_domain
    exec_start << "-cookie-domain=#{new_resource.cookie_domain}" if new_resource.cookie_domain
    exec_start << "-cookie-refresh=#{new_resource.cookie_refresh}" if new_resource.cookie_refresh
    exec_start << "-client-id=#{new_resource.client_id}" if new_resource.client_id
    exec_start << "-client-secret=#{new_resource.client_secret}" if new_resource.client_secret
    exec_start << "-cookie-secret=#{new_resource.cookie_secret}" if new_resource.cookie_secret
    exec_start << "-cookie-secret=#{new_resource.cookie_secret}" if new_resource.cookie_secret
    exec_start << "-oauth_provider=#{new_resource.oauth_provider}" if new_resource.oauth_provider

    service do
      type 'simple'
      environment_file "/etc/default/oauth_proxy_#{new_resource.name}"
      exec_start exec_start.join(" ")
      restart 'on-failure'
      restart_sec '30s'
    end
    verify false
  end
end
