class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
      if authenticate_user! 
	if current_user.role == 'admin'
        @product = Product.new
      	else 
          respond_to do |format|
             format.html { redirect_to products_url, notice: 'Permission denied.' }
          end
        end
      end
  end

  # GET /products/1/edit
  def edit
	unless current_user.role == 'admin'
	 	respond_to do |format|
		     format.html { redirect_to products_url, notice: 'Permission denied.' }
		end
	end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
   if current_user.role == 'admin'
   Item.all do |item|
       if item.product_id == @product.id 
           item.destroy
       end
   end
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  else
	respond_to do |format|
	     format.html { redirect_to products_url, notice: 'Permission denied.' }
	end
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:p_name, :description, :price, :quantity)
    end
end
