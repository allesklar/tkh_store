class CategoriesController < ApplicationController

  before_filter :authenticate,                                 except: [ :show ]
  before_action -> { require_permission_to 'write_products'},  except: [ :show ]

  def index
    @categories = Category.alphabetically
    switch_to_admin_layout
  end

  def new
    @category = Category.new
    switch_to_admin_layout
  end

  def edit
    @category = Category.find(params[:id])
    switch_to_admin_layout
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to categories_path, notice: "The category was created in the database."
    else
      flash[:warning] = "There was a problem creating this category"
      render action: "new", layout: 'admin'
    end
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      redirect_to categories_path, notice: "This category was successfully updated."
    else
      flash[:warning] = "There was a problem updating this category"
      render action: "edit", layout: 'admin'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_url, notice: "This category was successfully deleted."
  end

  def reorder
    @categories = Category.by_position
    switch_to_admin_layout
  end

  def sort
    params[:category].each_with_index do |id, index|
      Category.update id, position: index+1
    end
    render nothing: true
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit :name
  end

end
