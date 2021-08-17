class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
    before_action :set_subscription, only: [:show, :edit, :update, :destroy]

    before_action :current_user_subscribed, only: [:edit, :update, :destroy]

    # GET /subscriptions
    # GET /subscriptions.json
    def index
      @subscriptions = Subscription.all

       if current_user.admin?
        @subscriptions = Subscription.all
      else
        @subscriptions = current_user.subscriptions.where(user_id: current_user)
      end
    end

    # GET /subscriptions/1
    # GET /subscriptions/1.json
    def show
    end

    # GET /subscriptions/new
    def new
      @subscription = Subscription.new
      # @subscription = current_user.subscriptions.all
    end

    # GET /subscriptions/1/edit
    def edit
    end

    # POST /subscriptions
    # POST /subscriptions.json
    def create
      # @subscription = Subscription.new(subscription_params)

      # respond_to do |format|
      #   if @subscription.save
      #     format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
      #     format.json { render :show, status: :created, location: @subscription }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @subscription.errors, status: :unprocessable_entity }
      #   end
      # end


      @subscription = Subscription.new(subscription_params)
      @subscription.user_id = current_user.id


      token = params[:stripeToken]
      card_brand = params[:user][:card_brand]
      card_exp_month = params[:user][:card_exp_month]
      card_exp_year = params[:user][:card_exp_year]
      card_last4 = params[:user][:card_last4]

      charge = Stripe::Charge.create(
        amount: 499,
        currency: "usd",
        description: "Consultly",
        source: token
      )

      current_user.stripe_id = charge.id
      current_user.card_brand = card_brand
      current_user.card_exp_month = card_exp_month
      current_user.card_exp_year = card_exp_year
      current_user.card_last4 = card_last4
      current_user.save!


      respond_to do |format|
        if @subscription.save
          format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
          format.json { render :show, status: :created, location: @subscription }
        else
          format.html { render :new }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end
      end

       rescue Stripe::CardError => e
        flash.alert = e.message
        render action: :new
    end

    # PATCH/PUT /subscriptions/1
    # PATCH/PUT /subscriptions/1.json
    def update
      respond_to do |format|
        if @subscription.update(subscription_params)
          format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
          format.json { render :show, status: :ok, location: @subscription }
        else
          format.html { render :edit }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end
      end



    end

    # DELETE /subscriptions/1
    # DELETE /subscriptions/1.json
    def destroy
      @subscription.destroy
      respond_to do |format|
        format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_subscription
        @subscription = Subscription.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def subscription_params
        # params.require(:subscription).permit(:data, :email, :user_id, :subscription)
        params.require(:subscription).permit(:data, :user_id, :subscription)
      end

     def current_user_subscribed
      user_signed_in? && current_user.subscribed?

      flash[:danger] = "Only Admin can see this content"

      redirect_to root_path
     end


end
