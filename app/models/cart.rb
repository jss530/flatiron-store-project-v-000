require 'pry'

class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.line_items.each.sum do |line_item|
      line_item.item.price * line_item.quantity
    end
  end

  def add_item(item_id)

    if current_item = self.line_items.find_by(item_id: item_id)
      current_item.quantity += 1
    else
      current_item = self.line_items.new(item_id: item_id)
    end
    current_item
  end
