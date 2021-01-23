class ShoppinglistsController < ApplicationController
  before_action :set_shoppinglist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /shoppinglists
  # GET /shoppinglists.json
  def index
    if current_user.role == 'admin'
	@shoppinglists = Shoppinglist.all
    else
	@shoppinglists = Shoppinglist.select{|l| l.user == current_user}
    end
  end

  # GET /shoppinglists/1
  # GET /shoppinglists/1.json
  def show
    set_shoppinglist
    current_user.lastlist_id= @shoppinglist.id
  end

  # GET /shoppinglists/new
  def new
    @shoppinglist = Shoppinglist.new
  end

  # GET /shoppinglists/1/edit
  def edit
  end

  # POST /shoppinglists
  # POST /shoppinglists.json
  def create
    @shoppinglist = Shoppinglist.new
    @shoppinglist.user = current_user
    respond_to do |format|
      if @shoppinglist.save
        format.html { redirect_to @shoppinglist, notice: 'Shoppinglist was successfully created.' }
        format.json { render :show, status: :created, location: @shoppinglist }
      else
        format.html { render :new }
        format.json { render json: @shoppinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoppinglists/1
  # PATCH/PUT /shoppinglists/1.json
  def update
    respond_to do |format|
      if @shoppinglist.update(shoppinglist_params)
        format.html { redirect_to @shoppinglist, notice: 'Shoppinglist was successfully updated.' }
        format.json { render :show, status: :ok, location: @shoppinglist }
      else
        format.html { render :edit }
        format.json { render json: @shoppinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoppinglists/1
  # DELETE /shoppinglists/1.json
  def destroy
    @shoppinglist.destroy
    respond_to do |format|
      format.html { redirect_to shoppinglists_url, notice: 'Shoppinglist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shoppinglist
      @shoppinglist = Shoppinglist.find(params[:id])
      current_user.lastlist_id= @shoppinglist.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shoppinglist_params
      params.require(:shoppinglist).permit()
    end
end
