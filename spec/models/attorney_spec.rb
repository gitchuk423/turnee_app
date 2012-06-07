require 'spec_helper'

describe Attorney do

  before do
    @a = Attorney.new(email: "test22@example.com", password: "foobar", 	   
                      password_confirmation: "foobar")
  end

  subject { @a }
  it { should respond_to(:password_digest)}
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  
  describe "with a password that's too short" do
    before { @a.password = @a.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "remember token" do
    before { @a.save }
    its(:remember_token) { should_not be_blank }
  end

 

end

