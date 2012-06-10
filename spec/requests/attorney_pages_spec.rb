
require 'spec_helper'

describe "Attorney pages" do

  subject { page }
  
  describe "index" do

    let(:attorney) { FactoryGirl.create(:attorney) }

    before(:all)  { 30.times { FactoryGirl.create(:attorney) } }
    after(:all)   { Attorney.delete_all }
    
    before do
      sign_in attorney
      visit attorneys_path
    end


    it { should have_selector('title', text: 'All attorneys') }
    it { should have_selector('h1',    text: 'All attorneys') }

    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each attorney" do
        Attorney.paginate(page: 1).each do |attorney|
          page.should have_selector('li', text: attorney.name)
        end
      end
    end 
     
     describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin attorney" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit attorneys_path
        end

        it { should have_link('delete', href: attorney_path(Attorney.first)) }
        it "should be able to delete another attorney" do
          expect { click_link('delete') }.to change(Attorney, :count).by(-1)
        end
        it { should_not have_link('delete', href: attorney_path(admin)) }
      end
    end
  
  end
  
  describe "signup page" do
    before { visit signup_path }
    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do
    
    let(:attorney) {Factory.create(:attorney)}
    
    before { visit attorney_path(attorney) }

    it { should have_selector('h1',    text: attorney.name) }
    it { should have_selector('title', text: attorney.name) }
  end
  
  describe "edit" do
	  let(:attorney) {Factory.create(:attorney)}
	  before do
	    sign_in attorney
	    visit edit_attorney_path(attorney)
	  end
	
	  describe "page" do
		  it { should have_selector('h1',    text: "Update your profile") }
  		it { should have_selector('title', text: "Edit attorney profile") }
  		it { should have_link('change', href: 'http://gravatar.com/emails') }
  	end

    describe "with invalid information" do
  		before { click_button "Save Changes" }
  		it { should have_content('error') }
  	end
    	
  	describe "with valid information" do
  	  let(:new_name) {"New Name"}
  	  let(:new_email) {"new@example.com"}
  	  before do
  	    fill_in "Email",            with: new_email
  	    fill_in "Password",         with: attorney.password
  	    fill_in "Confirm Password", with: attorney.password
  	    click_button "Save Changes"
  	   end
  	   
  	   it {should have_selector('div.alert.alert-success')}
  	   it { should have_link('Sign out', href: signout_path) }
  	   
       specify { attorney.reload.email.should == new_email }
    end
  end
  
  describe "signup" do

    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create an attorney" do
        expect { click_button submit }.not_to change(Attorney, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        with: "attorney56674@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create an attorney" do
        expect { click_button submit }.to change(Attorney, :count).by(1)
      end
      
      describe "after saving the attorney" do
        before { click_button submit }
        let(:attorney) { Attorney.find_by_email('attorney56674@example.com') }

        it { should have_selector('title', text: attorney.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome')}       
      	it { should have_link('Sign out') }
      end
      
    end
  

  end
  
end
