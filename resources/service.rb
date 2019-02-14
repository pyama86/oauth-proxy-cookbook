# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
actions :create
default_action :create
attribute :listen, required: true, kind_of: String
attribute :redirect_url, required: true, kind_of: String
attribute :upstream, required: true, kind_of: String
attribute :options, required: false, kind_of: Hash
