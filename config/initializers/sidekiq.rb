require 'yaml'

sidekiq_config = {
  :redis => {
    :namespace => "todoapp_sidekiq_#{Rails.env}",
    :url => Rails.application.secrets["redis_url_sidekiq"] || "redis://localhost"
  }
}

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config[:redis]
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file("#{File.dirname(__FILE__)}/../sidekiq_scheduler.yml")
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config[:redis]
end

 Sidekiq::Extensions.enable_delay!
