class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Premium Blocipedia Membership - #{current_user.email}",
      amount: 10_00
    }
  end

  def create
    @amount = 10_00

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app)
      amount: @amount,
      description: "Premium Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
      )

    current_user.update_attributes!( role: 'premium')

    flash[:success] = "Payment was successful, membership upgraded to Premium for  #{current_user.email}!"
    redirect_to root_path # or whereever

    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This 'rescue block' catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end

