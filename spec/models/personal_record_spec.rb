require 'spec_helper'

describe PersonalRecord do

  before do
    @p = PersonalRecord.new(
                            first_name: "Bob", 
                            last_name:  "Jones",
                            email: "bob.jones@example.com") 
  end

  subject { @p }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
 
 
  
  describe "when email address is already taken" do
    before do
      record_with_same_email = @p.dup
      record_with_same_email.save
    end
        it { should_not be_valid }
  end

end

