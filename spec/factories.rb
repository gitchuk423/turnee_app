require 'factory_girl'

FactoryGirl.define do
  factory :attorney do |a|
  
    a.sequence(:first_name) { |n| "Thing #{n}"}
    a.sequence(:last_name) { |n| "Suess #{n}"}
    a.sequence(:email) { |n| "test#{n}@example.com" }

    a.password "foobar"
    a.password_confirmation "foobar"
  
    factory :admin do
      admin true
    end
  
    a.after_build{ |attorney|
      attorney.build_personal_record
      attorney.build_professional_record
    }
    a.after_create {|attorney|
      attorney.personal_record.save; attorney.professional_record.save}
  end    
end



