class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.discounts
  end

  def new
    @discount = Discount.new
  end

  private
    def discount_params
      params.require(:discount).permit(:percent_off, :requirement)
    end
end
