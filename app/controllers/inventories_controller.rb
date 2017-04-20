class InventoriesController < ApplicationController

  def index
    @inventories = Inventory.paginate(page: params[:page], per_page: 15)
  end

  def new
    @inventory = Inventory.new
  end

  def show
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save

    if params.has_key?(:photos)
      params[:photos].each { |photo_object| @inventory.photos.create(image:photo_object)}
    end
      redirect_to inventories_path
    else
      @errors = @inventory.errors.full_messages
      render "new"
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.clear
    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:content, :material_name, :grade_number, :form, :color, :quantity)
  end
end
