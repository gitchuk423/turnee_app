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
    
        
    attorneys = Attorney.all(limit: 10)
    50.times do |n|
      
      client = Client.create!(first_name: Faker::Name.first_name,
                              last_name:  Faker::Name.last_name,
                              email: "example-#{n+1}@example.org")
           
      
      referred_to_attorney_id = (11..99).to_a.sample

      attorneys.each { |attny| attny.referrals.create!(
            referred_to_attorney_id: referred_to_attorney_id,
            public_comments: Faker::Lorem.sentence(10),
            private_comments: Faker::Lorem.sentence(5),
            client_id:  client.id)}
    end
    
  end
end

