class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    respond_to do |format|
	format.html{ redirect_to products_url}
	format.json{ head :no_content }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    if params[:shoppinglist_id].blank?
    respond_to do |format|
	format.html{ redirect_to products_url}
	format.json{ head :no_content }
    end
    else
	@shoppinglist_id = params[:shoppinglist_id].to_i
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
   # @item.shoppinglist_id = @shoppinglist_id
    respond_to do |format|
      if @item.save
	if current_user.role == 'admin'
		p = Product.find(@item.product_id)
		p.update(quantity: p.quantity+@item.quantity)
	else
		p = Product.find(@item.product_id)
		p.update(quantity: p.quantity-@item.quantity)
	end
        format.html { redirect_to @item.shoppinglist, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
	if current_user.role == 'admin'
		p = Product.find(@item.product_id)
		p.update(quantity: p.quantity-@item.quantity)
	else
		p = Product.find(@item.product_id)
		p.update(quantity: p.quantity+@item.quantity)
	end
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:quantity,:product_id,:shoppinglist_id)
    end
end
