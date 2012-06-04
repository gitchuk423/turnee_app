require 'spec_helper'

describe Attorney do

  before do
    @a = Attorney.new(password: "foobar")
  end

  subject { @a }
  it { should respond_to(:password_digest)}
  it { should respond_to(:authenticate) }
  
  describe "with a password that's too short" do
    before { @a.password = @a.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

 

end

