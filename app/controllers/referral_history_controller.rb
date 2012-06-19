class ReferralHistoryController < ApplicationController

  before_filter :signed_in_attorney
  before_filter :correct_attorney, only: :destroy
  
  def show

    @attorney = current_attorney
    
    r = current_attorney.referrals.where(referred_to_attorney_id: params[:referred_to_attorney_id])
    @referrals = r.paginate(page: params[:page]).order('id DESC')
    @referred_to_attorney = Attorney.find(params[:referred_to_attorney_id])
    
  end

end
