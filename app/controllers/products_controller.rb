class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_stack

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = @stack.products.new(product_params)

    if @product.save
      redirect_to product_url(@product), notice: "Product was successfully created."
    else
      render :new, staltus: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if @product.update(product_params)
      redirect_to stack_product_url(@stack, @product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!
    redirect_to stack_url(@stack), notice: "Product was successfully destroyed."
  end

  private
    def set_stack 
      @stack = Stack.find(params[:stack_id])
    end

    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :link, :asin, :price, :brand_id)
    end
end
