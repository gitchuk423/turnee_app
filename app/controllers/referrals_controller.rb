class ReferralsController < ApplicationController
  
  #before_filter :find_referral, except: [:new, :create]
  #before_filter :find_attorney, except: [:new, :create]
  #before_filter :find_client, except: [:new, :create]
  
  def new
    @attorney = Attorney.find(params[:attorney_id])
    @referral = @attorney.referrals.new
    #@client   = @referral.build_client
  end
  
  def create
          
    @attorney = Attorney.find(params[:attorney_id])
    
    @referral = Referral.new(params[:referral])
    
    @referral.attorney_id = @attorney.id
    
    if @referral.save
      flash[:success] = "Referral successfully created!" 
      redirect_to @attorney
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render 'new'
    end
  end
  
  def index
    @attorney = Attorney.find(params[:attorney_id])
    r1 = @attorney.referrals
    @referrals = r1.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @referral = Referral.find(params[:id])
    @client   = Client.find(@referral.client_id)
    @attorney = Attorney.find(params[:attorney_id])
  end
  
  private
  
    def find_referral
		  @referral = Referral.find(params[:id])
	  end
    
    def find_attorney
		  r = find_referral
	    @attorney = Attorney.find(r.attorney_id)
	  end
  
    def find_client
      r = find_referral
      @client = Client.find(r.client_id)
    end
end
