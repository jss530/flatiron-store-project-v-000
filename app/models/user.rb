class User < ActiveRecord::Base
  has_many :carts
  belongs_to :current_cart, class_name: 'Cart'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def current_cart=(cart)
    self.current_cart_id = cart.id if cart
    @current_cart = cart
    self.save
  end

  def current_cart
    @current_cart = Cart.find_by(id: self.current_cart_id)
  end
end
