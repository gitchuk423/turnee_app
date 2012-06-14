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
      attorney =  Attorney.create!(first_name: Faker::Name.first_name,
                       last_name:  Faker::Name.last_name,
                       email: "example-#{n+1}@example.org",
                       password: "password",
                       password_confirmation: "password")
                       
                       
                       
      years = ((1988..2003).to_a.sample(2)).sort
      
      
      year1 = years.shift
      month1 = (1..12).to_a.sample
      day1 = (1..28).to_a.sample
      
      year2 = years.shift
      month2 = (1..12).to_a.sample
      day2 = (1..28).to_a.sample
      
            
      attorney.professional_experiences.create!(  name: Faker::Company.name,
                                                  start_date: "#{year1}-#{month1}-#{day1}",
                                                  end_date: "#{year2}-#{month2}-#{day2}",
                                                  position: "#{Faker::Lorem::words.first.capitalize} #{["Counsel", "Attorney"].sample}",
                                                  city: Faker::Address.city,
                                                  state: Faker::Address.state,
                                                  country: Faker::Address.country)
      
      year1 = year2
      month1 = (1..12).to_a.sample
      day1 = (1..28).to_a.sample
      
      
      attorney.professional_experiences.create!(  name: Faker::Company.name,
                                                  start_date: "#{year1}-#{month1}-#{day1}",
                                                  end_date: Time.now.strftime("%Y-%m-%d"),
                                                  position: "#{Faker::Lorem::words.first.capitalize} #{["Counsel", "Attorney"].sample}",
                                                  city: Faker::Address.city,
                                                  state: Faker::Address.state,
                                                  country: Faker::Address.country)
           
                        
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

