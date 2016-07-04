require 'rake'

namespace :opportunity do
  desc "Change all opportunity dates to today's date."
  task :update_date => :environment do
    Rake::Task['opportunity:update_date'].invoke
    Opportunity.update_all(date: Date.today)
    puts "All opportunities up to date!"
  end
end
