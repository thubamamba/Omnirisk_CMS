class DamagedItemsController < ApplicationController
  before_action :set_damaged_item, only: [:show, :edit, :update, :destroy]

  # GET /damaged_items
  def index
    @pagy, @damaged_items = pagy(DamagedItem.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @damaged_items
  end

  # GET /damaged_items/1 or /damaged_items/1.json
  def show
  end

  # GET /damaged_items/new
  def new
    @damaged_item = DamagedItem.new

    # Uncomment to authorize with Pundit
    # authorize @damaged_item
  end

  # GET /damaged_items/1/edit
  def edit
  end

  # POST /damaged_items or /damaged_items.json
  def create
    @damaged_item = DamagedItem.new(damaged_item_params)

    # Uncomment to authorize with Pundit
    # authorize @damaged_item

    respond_to do |format|
      if @damaged_item.save
        format.html { redirect_to @damaged_item, notice: "Damaged item was successfully created." }
        format.json { render :show, status: :created, location: @damaged_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @damaged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /damaged_items/1 or /damaged_items/1.json
  def update
    respond_to do |format|
      if @damaged_item.update(damaged_item_params)
        format.html { redirect_to @damaged_item, notice: "Damaged item was successfully updated." }
        format.json { render :show, status: :ok, location: @damaged_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @damaged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /damaged_items/1 or /damaged_items/1.json
  def destroy
    @damaged_item.destroy!
    respond_to do |format|
      format.html { redirect_to damaged_items_url, status: :see_other, notice: "Damaged item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_damaged_item
    @damaged_item = DamagedItem.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @damaged_item
  rescue ActiveRecord::RecordNotFound
    redirect_to damaged_items_path
  end

  # Only allow a list of trusted parameters through.
  def damaged_item_params
    params.require(:damaged_item).permit(:item_name, :serial_number, :estimated_value, :claim_id)

    # Uncomment to use Pundit permitted attributes
    # params.require(:damaged_item).permit(policy(@damaged_item).permitted_attributes)
  end
end
