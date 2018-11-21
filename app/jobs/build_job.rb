class BuildJob < ApplicationJob
  queue_as :default

  def perform
    Deal.crawl
  end
end
