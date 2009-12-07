on :load do
  strategy = fetch(:daemon_strategy, :mongrel_cluster)

  if [:passenger, :mongrel_cluster].include? strategy
    load File.join(File.dirname(__FILE__), "daemon_strategies", "#{strategy}.rb")
  end
end
