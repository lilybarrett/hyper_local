# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
causes = [
  "Climate Change",
  "Income Inequality",
  "Criminal Justice Reform",
  "Education Reform",
  "Racial Justice",
  "Women's Issues",
  "Immigration",
  "Refugee Support",
  "Technology and Privacy",
  "Healthcare Access",
  "LGBTQ Rights",
  "Disability Advocacy"
]

causes.each do |cause|
  Cause.find_or_create_by!(cause: cause)
end
