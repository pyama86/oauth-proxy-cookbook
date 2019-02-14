# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
actions :create
default_action :create
attribute :listen, required: true, kind_of: String
attribute :redirect_url, required: true, kind_of: Hash
attribute :upstream, required: true, kind_of: String
attribute :email_domain, required: false, kind_of: String
attribute :cookie_domain, required: false, kind_of: String
attribute :cookie_refresh, required: false, kind_of: String
