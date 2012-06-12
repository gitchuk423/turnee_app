require 'spec_helper'

describe Referral do

  let(:attorney) { FactoryGirl.create(:attorney) }
  let(:client)   { FactoryGirl.create(:client) }
  
  
  before do
    # This code is wrong!
    @referral = attorney.referrals.build(client_id: client.id, 
                             referred_to_attorney_id: "nil",
                             public_comments: "These are the public comments", 
      private_comments: "These are the private comments")                        
                             
  end

  subject { @referral }

  it { should respond_to(:client_id) }
  it { should respond_to(:referred_to_attorney_id) }
  it { should respond_to(:public_comments) }
  it { should respond_to(:private_comments) }
  
  it { should respond_to(:attorney) }
  its(:attorney) { should == attorney }
  
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to attorney_id" do
      expect do
        Referral.new(attorney_id: attorney.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when attorney_id is not present" do
    before { @referral.attorney_id = nil }
    it { should_not be_valid }
  end
  
  describe "when status is not valid" do
    before { @referral.status = "invalid status" }
    it { should_not be_valid }
  end
  
end


