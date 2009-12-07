require "mongrel_cluster/recipes"

set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

depend :remote, :gem, "mongrel", ">=1.1.5"
depend :remote, :gem, "mongrel_cluster", ">=1.0.5"
