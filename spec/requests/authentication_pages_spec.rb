require 'spec_helper'

describe "Authentication" do
	
	subject {page}
	
	describe "signin page" do
		before {visit signin_path}
		
		it {should have_selector('h1', text: 'Sign in')}
		it {should have_selector('title', text: 'Sign in')}
	end
	
	describe "signin" do
		before {visit signin_path}
		
		describe "with invalid information" do
     		before { click_button "Sign in" }
		
			it {should have_selector('title', text: 'Sign in')}
			it {should have_selector('div.alert.alert-error', text: 'Invalid')}
		end
		
		describe "with valid information" do
      let(:attorney) { Factory.create(:attorney) }
		  before {sign_in attorney} # via helper in utilities
		  
		  it { should have_selector('title', text: attorney.name) }
		  
		  it { should have_link('Attorneys',    href: attorneys_path) }
		  it { should have_link('Profile', href: attorney_path(attorney)) }
		  it { should have_link('Sign out', href: signout_path) }
		  it { should_not have_link('Sign in', href: signin_path) }
		  it { should have_link('Settings', href: edit_attorney_path(attorney)) }
		  
		  describe "followed by signout" do
        	before { click_link "Sign out" }
        	it { should have_link('Sign in') }
      end
		end
	end
	
  describe "authorization" do

    describe "for non-signed-in attorneys" do
      let(:attorney) { Factory.create(:attorney) }

      describe "in the attorneys controller" do

        describe "visiting the edit page" do
          before { visit edit_attorney_path(attorney) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put attorney_path(attorney) }
          specify { response.should redirect_to(signin_path) }
        end
        
         describe "visiting the attorney index" do
          before { visit attorneys_path }
          it { should have_selector('title', text: 'Sign in') }
        end        
      end
     end 
      
    describe "as wrong attorney" do
        let(:attorney) { FactoryGirl.create(:attorney) }
        let(:wrong_attorney) { FactoryGirl.create(:attorney, 
                                                  email:     "wrong@example.com") }
        before {sign_in attorney} 
      

      describe "visiting attorneys#edit page" do
        before { visit edit_attorney_path(wrong_attorney) }
        it { should_not have_selector('title', text: full_title('Edit attorney')) }
      end

      describe "submitting a PUT request to the attorneys#update action" do
        before { put attorney_path(wrong_attorney) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "for non-signed-in attorneys" do
      let(:attorney) { FactoryGirl.create(:attorney) }

      describe "when attempting to visit a protected page" do
          before do
            visit edit_attorney_path(attorney)
            fill_in "Email",    with: attorney.email
            fill_in "Password", with: attorney.password
            click_button "Sign in"
          end

          describe "after signing in" do

            it "should render the desired protected page" do
              page.should have_selector('title', text: 'Edit attorney')
            end
          end
      end
      
      describe "in the Attorney controller" do     
        describe "visiting the attorney index" do
          before { visit attorneys_path }
          it { should have_selector('title', text: 'Sign in') }
        end
      end
      
      describe "as non-admin attorney" do
        let(:attorney) { FactoryGirl.create(:attorney) }
        let(:non_admin) { FactoryGirl.create(:attorney) }

        before { sign_in non_admin }

        describe "submitting a DELETE request to the Attorneys#destroy action" do
        before { delete attorney_path(attorney) }
        specify { response.should redirect_to(root_path) }        
      end
    end
      
      
      end  
    end
 end
