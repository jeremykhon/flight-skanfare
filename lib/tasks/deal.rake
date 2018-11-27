namespace :deal do
  desc "refresh deals"
  task refresh: :environment do
    BuildJob.perform_now
  end
end
