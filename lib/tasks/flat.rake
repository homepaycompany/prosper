namespace :flat do
  desc "Enriching Flats with API"
  task update_all: :environment do
    FlatsUpdateJob.perform_later
  end

  desc "Updating Flats with API"
  task create_all: :environment do
    FlatsCreateJob.perform_later
  end
end
