require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'is valid with valid attributes - name, price, quantity, category' do
      @category = Category.new(name: 'Toys')
      @category.save!
      @product = @category.products.create!(name: 'Ball', price: 50, quantity: 10, category: @category)
      @product.save
      expect(@product).to be_valid
    end
    it 'is not valid without category' do
      @product = Product.new(name: 'Ball', price: 50, quantity: 10, category: nil )
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product).to_not be_valid
    end
    it 'is not valid without name' do
      @category = Category.new(name: 'Toys')
      @category.save!
      @product = @category.products.create(name: nil, price: 50, quantity: 10, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product).to_not be_valid   
    end
    it 'is not valid without price' do
      @category = Category.new(name: 'Toys')
      @category.save!
      @product = @category.products.create(name: 'Ball', price: nil, quantity: 10, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include('Price cents is not a number', 'Price is not a number', "Price can't be blank")
      expect(@product).to_not be_valid       
    end
    it 'is not valid without quantity' do
      @category = Category.new(name: 'Toys')
      @category.save!
      @product = @category.products.create(name: 'Ball', price: 50, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product).to_not be_valid       
    end
  end
end
