class MunicipalitiesController < ApplicationController
  before_action :set_municipality, only: [:show, :edit, :update, :destroy]

  # GET /municipalities
  def index
    @pagy, @municipalities = pagy(Municipality.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    authorize @municipalities
  end

  # GET /municipalities/1 or /municipalities/1.json
  def show
  end

  # GET /municipalities/new
  def new
    @municipality = Municipality.new

    # Uncomment to authorize with Pundit
    authorize @municipality
  end

  # GET /municipalities/1/edit
  def edit
  end

  # POST /municipalities or /municipalities.json
  def create
    @municipality = Municipality.new(municipality_params)

    # Uncomment to authorize with Pundit
    # authorize @municipality

    respond_to do |format|
      if @municipality.save
        format.html { redirect_to @municipality, notice: "Municipality was successfully created." }
        format.json { render :show, status: :created, location: @municipality }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @municipality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipalities/1 or /municipalities/1.json
  def update
    respond_to do |format|
      if @municipality.update(municipality_params)
        format.html { redirect_to @municipality, notice: "Municipality was successfully updated." }
        format.json { render :show, status: :ok, location: @municipality }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @municipality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /municipalities/1 or /municipalities/1.json
  def destroy
    @municipality.destroy!
    respond_to do |format|
      format.html { redirect_to municipalities_url, status: :see_other, notice: "Municipality was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipality
    @municipality = Municipality.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @municipality
  rescue ActiveRecord::RecordNotFound
    redirect_to municipalities_path
  end

  # Only allow a list of trusted parameters through.
  def municipality_params
    params.require(:municipality).permit(:account_id, :name, :is_active)

    # Uncomment to use Pundit permitted attributes
    # params.require(:municipality).permit(policy(@municipality).permitted_attributes)
  end
end
