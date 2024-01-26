class ProductsController < ApplicationController
  before_action :set_category, only: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]


  # GET /products or /products.json
  def index
    @products = Product.all
    @products = @category.products
    #  render json: @products, only: [:id, :title, :image, :price, :category_id]

  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  
    # Assuming you have a `category_id` column in your `products` table
    category_id = @product.category_id
    
    # Ensure that category_id is present before attempting to find the category
    if category_id.present?
      @category = Category.find(category_id)
    else
      # Handle the case where the category is not found
      render json: { error: 'Category not found.' }, status: :not_found
      return
    end
  
    # render json: {
    #   id: @product.id,
    #   title: @product.title,
    #   image: @product.image,
    #   price: @product.price,
    #   category_id: @product.category_id,
    #   category: @category.as_json(only: [:id, :name]) # Include category information if needed
    # }
  end
  
  # GET /products/new
  def new
    @product=  Product.new
    #  render json: @products, only: [:id, :title, :image, :price, :category_id]

  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @category = @product.category
    @product.destroy

    redirect_to category_products_path(@category), notice: 'Product was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id].present?
  end
  

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def authorize_admin
      unless current_user.admin?
        flash[:alert] = 'You do not have permission to access this page.'
        redirect_back fallback_location: root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :image, :price, :category_id)
    end
end