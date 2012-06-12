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
  
  factory :client do |c|
    c.sequence(:first_name) { |n| "Clive #{n}"}
    c.sequence(:last_name)  { |n| "Ant #{n}"}
    c.sequence(:email)      { |n| "cliveant#{n}@example.com" }
  end
  
  factory :referral do
    status "created"
    public_comments "These are public comments"
    private_comments "These are private comments"
    referred_to_attorney_id 2
    client_id 1
    attorney
  end
   
end



