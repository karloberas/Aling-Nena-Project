require 'sinatra'
require './boot.rb'
require './money_calculator'


get '/' do
  @products = Item.all
  @random_machine = []
  erb :home
end

get '/about' do
  erb :about
end

get '/products' do
  @products = Item.all
  @success = false
  erb :products
end

get '/purchase_product/:id' do
  @product = Item.find(params[:id])  
  @bool = true
  @bool2 = true
  @bool3 = true
  erb :purchase
end

post '/calculate/:id' do
  product = Item.find(params[:id])  
  quantity = params[:quantity].to_i
  if product.quantity >= quantity
    calculate = MoneyCalculator.new(params[:ones].to_i, params[:fives].to_i, params[:tens].to_i, params[:twenties].to_i, params[:fifties].to_i, params[:hundreds].to_i, params[:five_hundreds].to_i, params[:thousands].to_i)
    total = quantity*product.price
    payment = calculate.get_total
    if payment < total
      @product = product
      @bool = true  
      @bool2 = false
      @bool3 = true
      erb :purchase
    elsif quantity==0
      @product = product
      @bool = true
      @bool2 = true  
      @bool3 = false
      erb :purchase
    else
      @bool = true
      @bool2 = true
      @bool3 = true
      product.update_attributes!(
        quantity: (product.quantity - quantity), 
        sold: (product.sold + quantity)
      )
      @change = calculate.change(total.to_i, payment.to_i)
      @product = product
      @products = Item.all
      erb :change
    end
  else
    @product = product
    @bool=false
    @bool2=true
    @bool3=true
    erb :purchase
  end
end



# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION
