require 'spec_helper'

describe "Attorney pages" do

  subject { page }

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
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create an attorney" do
        expect { click_button submit }.to change(Attorney, :count).by(1)
      end

	 describe "after saving the attorney" do
        before { click_button submit }
        let(:attorney) { Attorney.find_by_email('user@example.com') }

        it { should have_selector('title', text: attorney.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome')}       
      	it { should have_link('Sign out') }
      end
    end
  end




end
