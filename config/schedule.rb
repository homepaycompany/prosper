every 1.day, at: '0:00 am' do
  runner "FlatsUpdateJob.perform_later"
end

every :hour do
  runner "FlatsCreateJob.perform_later"
end

every 1.day, at: '1:00 am' do
  runner "FlatsCleanJob.perform_later"
end
