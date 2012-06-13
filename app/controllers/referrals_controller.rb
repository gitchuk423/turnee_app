class ReferralsController < ApplicationController
  

  layout "main"
  
  before_filter :signed_in_attorney, only: [:create, :destroy]
  before_filter :correct_attorney, only: :destroy
  
  def new
    @attorney = current_attorney
    @referral = current_attorney.referrals.new
  end
  
  def create

    # note there should be a signed_in check here (via filter) to make sure
    # attorneys are signed in before creating referrals
    
    @referral = current_attorney.referrals.build(params[:referral])
    
    if @referral.save
      flash[:success] = "Referral successfully created!" 
      redirect_to current_attorney
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render 'new'
    end
  end
  
  def index

    @attorney = current_attorney
    @referrals = current_attorney.referrals.paginate(page: params[:page], per_page: 10)
  end
  
  def show

    @attorney = Attorney.find_by_id(params[:attorney_id])
    @referral = @attorney.referrals.find_by_id(params[:id])
    @client   = Client.find(@referral.client_id)
  end
  
  def destroy
  	@referral.destroy
  	redirect_to current_attorney
  end
  
  private
 	def correct_attorney
 		# make sure that we only find referrals from the current attorney
 		@referral = current_attorney.referrals.find_by_id(params[:id])
 		redirect_to root_path if @referral.nil?

 	end

end

