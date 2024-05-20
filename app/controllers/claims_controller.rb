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
    @claim = Claim.new(claim_params)

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
        # Process signature
        # if params[:claim][:signature_data].present?
        #   @claim.signature.attach(data_uri_to_image(params[:claim][:signature_data]))
        # end
        if params[:claim][:signature_data].present?
          attach_signature(@claim, params[:claim][:signature_data])
        end
        format.html { redirect_to @claim, notice: 'Claim was successfully created.' }
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
        format.html { redirect_to @claim, notice: 'Claim was successfully updated.' }
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
      format.html { redirect_to claims_url, status: :see_other, notice: 'Claim was successfully destroyed.' }
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
    # params.require(:claim).permit(:municipality_id, :status, :claim_number, :claim_type, :type_of_property_loss, :date_of_loss, :police_ref_number, :police_station_incident_reported_to, :nature_of_incident, :insured_property_ownership, :description_of_incident, :incident_location, :is_property_insured_elsewhere, :have_you_suffered_previous_loss, :has_other_party_interest, :was_property_occupied_during_damage, :property_claim_photos, :declaration_accepted_at, :information_sharing_accepted_at, :created_at, :updated_at, :property_claim_photos)

    params.fetch(:claim, {}).permit(:municipality_id, :status, :claim_number, :signature, :claim_type, :type_of_property_loss, :date_of_loss, :police_ref_number, :police_station_incident_reported_to, :nature_of_incident, :insured_property_ownership, :description_of_incident, :incident_location, :is_property_insured_elsewhere, :have_you_suffered_previous_loss, :has_other_party_interest, :was_property_occupied_during_damage, :property_claim_photos, :declaration_accepted_at, :information_sharing_accepted_at, :created_at, :updated_at, :property_claim_photos, :liability_property_witness_first_name,
                                    :liability_property_witness_last_name,
                                    :liability_property_witness_contact_number,
                                    :liability_property_police_ref_number,
                                    :liability_property_police_station_case_reported_to,
                                    :liability_property_police_report_date,
                                    :liability_property_police_officer_first_name,
                                    :liability_property_police_officer_last_name,
                                    :liability_is_claim_against_municipality,
                                    :liability_description_of_incident,
                                    :liability_claim_details,
                                    :liability_personal_injury_first_name_of_injured_person,
                                    :liability_personal_injury_last_name_of_injured_person,
                                    :liability_personal_injury_age_of_injured_person,
                                    :liability_personal_injury_details,
                                    :liability_personal_injury_address_of_injured_person,
                                    :liability_personal_injury_place_of_occurrence,
                                    :liability_personal_injury_date_of_occurrence)

    # Uncomment to use Pundit permitted attributes
    # params.require(:claim).permit(policy(@claim).permitted_attributes)
  end

  def attach_signature(claim, signature_data)
    decoded_data = Base64.decode64(signature_data.split(",")[1])
    io = StringIO.new(decoded_data)
    io.content_type = "image/png"
    io.original_filename = generate_filename(claim)
    claim.signature.attach(io)
  end

  def data_uri_to_image(data_uri, claim)
    decoded_data = Base64.decode64(data_uri.split(',')[1])
    io = StringIO.new(decoded_data)
    io.content_type = 'image/png'
    io.original_filename = generate_filename(claim)
    # io.original_filename = "signature.png"
    io
  end

  def generate_filename(claim)
    municipality = claim.municipality.parameterize
    date = claim.created_at.strftime('%Y%m%d')
    first_name = claim.user.first_name.parameterize
    "signature_#{municipality}_#{date}_#{first_name}.png"
  end
end
