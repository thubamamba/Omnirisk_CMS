class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :edit, :update, :destroy]

  # GET /claims
  def index
    @pagy, @claims = pagy(Claim.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @claims
  end

  # GET /claims/1 or /claims/1.json
  def show
  end

  # GET /claims/new
  def new
    @claim = Claim.new

    # Uncomment to authorize with Pundit
    # authorize @claim
  end

  # GET /claims/1/edit
  def edit
  end

  # POST /claims or /claims.json
  def create
    @claim = Claim.new(claim_params)

    # Uncomment to authorize with Pundit
    # authorize @claim

    respond_to do |format|
      if @claim.save
        format.html { redirect_to @claim, notice: "Claim was successfully created." }
        format.json { render :show, status: :created, location: @claim }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claims/1 or /claims/1.json
  def update
    respond_to do |format|
      if @claim.update(claim_params)
        format.html { redirect_to @claim, notice: "Claim was successfully updated." }
        format.json { render :show, status: :ok, location: @claim }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claims/1 or /claims/1.json
  def destroy
    @claim.destroy!
    respond_to do |format|
      format.html { redirect_to claims_url, status: :see_other, notice: "Claim was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_claim
    @claim = Claim.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @claim
  rescue ActiveRecord::RecordNotFound
    redirect_to claims_path
  end

  # Only allow a list of trusted parameters through.
  def claim_params
    params.require(:claim).permit(:municipality_id, :status, :claim_number, :claim_type, :type_of_property_loss, :date_of_loss, :police_ref_number, :police_station_incident_reported_to, :nature_of_incident, :insured_property_ownership, :description_of_incident, :incident_location, :is_property_insured_elsewhere, :have_you_suffered_previous_loss, :has_other_party_interest, :was_property_occupied_during_damage, :property_claim_photos, :declaration_accepted_at, :information_sharing_accepted_at, :created_at, :updated_at)

    # Uncomment to use Pundit permitted attributes
    # params.require(:claim).permit(policy(@claim).permitted_attributes)
  end
end
