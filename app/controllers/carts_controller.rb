class CartsController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_cart

  def show
    @current_cart = Cart.find(params[:id])
  end

  def checkout
    cart = Cart.find(params[:id])

    cart.checkout
    if cart.status == "submitted"
      current_user.remove_cart
      redirect_to cart_path(cart), notice: "Cart is empty."
    end
  end

end
