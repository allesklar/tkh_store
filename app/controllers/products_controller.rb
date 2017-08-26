class ProductsController < ApplicationController

  before_filter :authenticate,                                 except: [ :show ]
  before_action -> { require_permission_to 'write_products'},  except: [ :show ]

  def index
    @products = Product.by_recent
    switch_to_admin_layout
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    switch_to_admin_layout
  end

  def edit
    @product = Product.find(params[:id])
    switch_to_admin_layout
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to @product, notice: "The product was created in the database."
    else
      flash[:warning] = "There was a problem creating this product"
      render action: "new", layout: 'admin'
    end
  end

  def update
    @product = Product.find params[:id]
    if @product.update_attributes product_params
      redirect_to @product, notice: "This product was successfully updated."
    else
      flash[:warning] = "There was a problem creating this product"
      render action: "edit", layout: 'admin'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, notice: t('products.destroy.notice')
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit( :name, :description, :ingredients, :image )
  end

end
