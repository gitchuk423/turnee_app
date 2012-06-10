namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = Attorney.create!(first_name: "John",
                     middle_initial: "Q",
                     last_name: "Public",
                     email: "example@example.org",
                     password: "foobar",
                     password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      Attorney.create!(first_name: Faker::Name.first_name,
                       last_name:  Faker::Name.last_name,
                       email: "example-#{n+1}@example.org",
                       password: "password",
                       password_confirmation: "password")
    end
  end
end

