class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit show update destroy]
  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]


  
  def index
    @categories = Category.all
    # @user_email = current_user.email if user_signed_in?

    # render json: @categories, only: [:name ]
  end
  


  

  # GET /categories/1 or /categories/1.json
  def show
  #   @category = Category.find(params[:id])
  #  @products = @category.products
  # render json: @category
  end

  # GET /categories/new
  def new

    @category = Category.new
    # render json: @category, only: [:name ]

  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def authorize_admin
      redirect_to root_path, alert: 'You do not have permission.' unless current_user.admin?
    end

    
    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end