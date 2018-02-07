every 1.day, at: '0:00 am' do
  runner "FlatsUpdateJob.perform_later"
end

every :hour do
  runner "FlatsCreateJob.perform_later"
end
