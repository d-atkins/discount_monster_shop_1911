class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.discounts
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = current_user.merchant.discounts.create(discount_params)
    if discount.save
      flash[:success] = "Discount successfully created."
      redirect_to merchant_discounts_path
    else
      error_message(discount)
      @discount = discount
      render :new
    end
  end

  private

    def discount_params
      params.require(:discount).permit(:percent_off, :requirement)
    end
end
