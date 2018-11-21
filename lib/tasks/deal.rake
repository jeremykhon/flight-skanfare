namespace :deal do
  desc "refresh deals"
  task refresh: :environment do
    BuildJob.perform_later
  end
end
