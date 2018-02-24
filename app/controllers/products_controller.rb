class ProductsController < ApplicationController

  before_filter :authenticate,                                 except: [ :show ]
  before_action -> { require_permission_to 'write_products'},  except: [ :show ]

  def index
    @products = Product.by_recently_published
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

  def publish
    product = Product.find(params[:id])
    product.published_at = Time.now
    # newly published should go on top of homepage by default
    first_position = Product.ordered.first.position
    product.position = first_position - 1
    if product.save
      redirect_to products_path, notice: "This product has been published."
    else
      redirect_to :back, :flash => { error: 'There was a problem while publishing this product.' }
    end
  end

  def unpublish
    product = Product.find(params[:id])
    product.published_at = nil
    if product.save
      redirect_to products_path, notice: "This product has been unpublished and is back to being a draft."
    else
      redirect_to :back, :flash => { error: 'There was a problem while unpublishing this product.' }
    end
  end

  def reorder
    @products = Product.ordered
    switch_to_admin_layout
  end

  def sort
    params[:product].each_with_index do |id, index|
      Product.update id, position: index+1
    end
    render nothing: true
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit( :name, :description, :ingredients, :image )
  end

end
