namespace :db do
  desc "load some data from db/aytochiloeches_seeds.rb"
  task aytochiloeches_seed: :environment do
    load(Rails.root.join("db", "aytochiloeches_seeds.rb"))
  end
end
