require 'spec_helper'

describe "Attorney" do

  subject { page }
  
  before do
    @a = Attorney.new(first_name: "Bob", middle_initial: "Q", last_name: "Tester",
                      email: "test22@example.com", password: "foobar", 	   
                      password_confirmation: "foobar")
  end

  subject { @a }
  it { should respond_to(:first_name) }
  it { should respond_to(:middle_initial) }
  it { should respond_to(:last_name) }
  it { should respond_to(:admin) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  
  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { @a.toggle!(:admin) }
    it { should be_admin }
  end
    
  describe "with a password that's too short" do
    before { @a.password = @a.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "remember token" do
    before { @a.save }
    its(:remember_token) { should_not be_blank }
  end

 

end

