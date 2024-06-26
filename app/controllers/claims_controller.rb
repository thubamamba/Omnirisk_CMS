class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :edit, :update, :destroy]
  before_action :authorize_claim, only: [:update, :show, :edit, :destroy]
  # before_action :process_signature_data, only: :create

  # GET /claims
  def index
    @claims = Claim.all

    if params[:search].present?
      @claims = @claims.where('claim_number ILIKE ?', "%#{params[:search]}%")
    end

    @pagy, @claims = pagy(Claim.sort_by_params(params[:sort], sort_direction))

    # Only users who belong to an account that owns a municipality can view claims belonging to that municipality
    # authorize @claims
  end

  # GET /claims/1 or /claims/1.json
  def show
    @pagy, @claim_comments = pagy(@claim.comments.order(created_at: :desc), items: 20)
    @pagy, @claim_property_electronic_damaged_items = pagy(@claim.damaged_items.order(created_at: :desc), items: 20)
    @pagy, @claim_witnesses = pagy(@claim.witnesses.order(created_at: :desc), items: 20)
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
        attach_signature
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

  def attach_signature
    signature_data = params[:claim][:signature_data]
    if signature_data.present?
      decoded_image = Base64.decode64(signature_data.split(',')[1])
      @claim.signature.attach(
        io: StringIO.new(decoded_image),
        filename: "signature_#{Time.now.to_i}.png",
        content_type: "image/png"
      )
    end
  end

  def generate_filename(claim)
    municipality = claim.municipality.parameterize
    date = Time.now.strftime("%Y%m%d")
    first_name = current_user.first_name.parameterize
    "signature_#{municipality}_#{date}_#{first_name}.png"
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

  def authorize_claim
    authorize @claim
  end

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
    # params.require(:claim).permit(:municipality_id, :status, :claim_number, :signature, :claim_type, :type_of_property_loss, :date_of_loss, :police_ref_number, :police_station_incident_reported_to, :nature_of_incident, :insured_property_ownership, :description_of_incident, :incident_location, :is_property_insured_elsewhere, :have_you_suffered_previous_loss, :has_other_party_interest, :was_property_occupied_during_damage, :declaration_accepted_at, :information_sharing_accepted_at, :created_at, :updated_at, :liability_property_witness_first_name,
    #                                     :liability_property_witness_last_name,
    #                                     :liability_property_witness_contact_number,
    #                                     :liability_property_police_ref_number,
    #                                     :liability_property_police_station_case_reported_to,
    #                                     :liability_property_police_report_date,
    #                                     :liability_property_police_officer_first_name,
    #                                     :liability_property_police_officer_last_name,
    #                                     :liability_is_claim_against_municipality,
    #                                     :liability_description_of_incident,
    #                                     :liability_claim_details,
    #                                     :liability_personal_injury_first_name_of_injured_person,
    #                                     :liability_personal_injury_last_name_of_injured_person,
    #                                     :liability_personal_injury_age_of_injured_person,
    #                                     :liability_personal_injury_details,
    #                                     :liability_personal_injury_address_of_injured_person,
    #                                     :liability_personal_injury_place_of_occurrence,
    #                                     :liability_personal_injury_date_of_occurrence,  :liability_claim_type, :liability_owner_first_name, :liability_owner_last_name, :liability_owner_email_address, :liability_owner_contact_number, :liability_description_of_loss, :public_liability_type, :liability_vehicle_km_completed, :vehicle_value, :liability_vehicle_drivable, :liability_vehicle_towed, :liability_drivers_first_name, :liability_drivers_last_name, :liability_drivers_contact_number, :liability_drivers_email, :liability_drivers_physical_address, :liability_drivers_license_no, :liability_drivers_license_date, :liability_drivers_license_status, :liability_contact_person_first_name, :liability_contact_person_last_name, :liability_contact_person_contact_number, :liability_contact_person_email, :liability_contact_person_physical_address, :liability_vehicle_make, :liability_vehicle_model, :liability_vehicle_year, :liability_vehicle_registration_number, :liability_vehicle_transmission_type, :liability_vehicle_gross_vehicle_mass, :liability_vehicle_inspection_address, :accident_and_health_claim_type, :accident_and_health_claimant_first_name, :accident_and_health_claimant_last_name, :accident_and_health_claimant_id_number, :accident_and_health_claimant_occupation, :accident_and_health_death_claim_claimant_first_name,
    #                                     :accident_and_health_death_claim_claimant_last_name,
    #                                     :accident_and_health_death_claim_claimant_employee_status,
    #                                     :accident_and_health_death_claim_confirmation_of_form_accuracy,
    #                                     :accident_and_health_death_claim_about_claimant_occupation,
    #                                     :accident_and_health_death_claim_date_of_death,
    #                                     :accident_and_health_death_claim_place_of_death,
    #                                     :accident_and_health_death_claim_any_factors_to_death_cause,
    #                                     :accident_and_health_disability_claim_accident_date,
    #                                     :accident_and_health_disability_claim_accident_place,
    #                                     :accident_and_health_disability_claim_saps_and_oar_case_no,
    #                                     :accident_and_health_disability_claim_description_of_accident,
    #                                     :accident_and_health_disability_claim_is_permanently_disabled,
    #                                     :accident_and_health_disability_claim_was_person_on_duty,
    #                                     :accident_and_health_claim_attending_doctor_first_name,
    #                                     :accident_and_health_claim_attending_doctor_last_name,
    #                                     :accident_and_health_claim_attending_doctor_practice_number,
    #                                     :accident_and_health_claim_attending_doctor_contact_number,
    #                                     :accident_and_health_claim_attending_doctor_address,
    #                                     :accident_and_health_ttd_claim_description_of_injuries,
    #                                     :accident_and_health_death_claim_death_cause, :vehicle_claim_type, :vehicle_claim_police_no, :vehicle_claim_accident_address, :vehicle_claim_vehicle_manufacturer, :vehicle_claim_vehicle_model, :vehicle_claim_vehicle_km_completed, :vehicle_claim_vehicle_registration, :vehicle_claim_vehicle_drivers_first_name, :vehicle_claim_vehicle_drivers_last_name, :vehicle_claim_vehicle_drivers_id_number, :vehicle_claim_vehicle_drivers_occupation, :vehicle_claim_vehicle_drivers_license_code, :vehicle_claim_were_there_passengers, :vehicle_claim_were_there_witnesses, :vehicle_claim_accident_description, :vehicle_claim_is_municipal_vehicle_damaged, :vehicle_claim_was_driver_authorized, :vehicle_claim_is_driver_your_employee, :vehicle_claim_has_drivers_license_been_suspended, :vehicle_claim_driver_physical_defects_status, :vehicle_claim_any_other_vehicle_damaged, :vehicle_claim_vehicle_purposes, :accept_declaration, :accept_information_sharing, property_claim_photos_docs: [], health_and_accident_documents: [], vehicle_claim_supporting_docs: [], liability_motor_claim_photos: [])

    params.fetch(:claim, {}).permit(:municipality_id, :user_id, :status, :claim_number, :signature, :claim_type, :type_of_property_loss, :date_of_loss, :police_ref_number, :police_station_incident_reported_to, :nature_of_incident, :insured_property_ownership, :description_of_incident, :incident_location, :is_property_insured_elsewhere, :have_you_suffered_previous_loss, :has_other_party_interest, :was_property_occupied_during_damage, :declaration_accepted_at, :information_sharing_accepted_at, :created_at, :updated_at, :guard_risk_claim_number, :liability_property_witness_first_name, :bank_details_branch_code, :bank_details_account_holder_name, :bank_details_account_number, :bank_details_bank_name,
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
                                    :liability_personal_injury_date_of_occurrence,  :liability_claim_type, :liability_owner_first_name, :liability_owner_last_name, :liability_owner_email_address, :liability_owner_contact_number, :liability_description_of_loss, :public_liability_type, :liability_vehicle_km_completed, :vehicle_value, :liability_vehicle_drivable, :liability_vehicle_towed, :liability_drivers_first_name, :liability_drivers_last_name, :liability_drivers_contact_number, :liability_drivers_email, :liability_drivers_physical_address, :liability_drivers_license_no, :liability_drivers_license_date, :liability_drivers_license_status, :liability_contact_person_first_name, :liability_contact_person_last_name, :liability_contact_person_contact_number, :liability_contact_person_email, :liability_contact_person_physical_address, :liability_vehicle_make, :liability_vehicle_model, :liability_vehicle_year, :liability_vehicle_registration_number, :liability_vehicle_transmission_type, :liability_vehicle_gross_vehicle_mass, :liability_vehicle_inspection_address, :accident_and_health_claim_type, :accident_and_health_claimant_first_name, :accident_and_health_claimant_last_name, :accident_and_health_claimant_id_number, :accident_and_health_claimant_occupation, :accident_and_health_death_claim_claimant_first_name,
                                    :accident_and_health_death_claim_claimant_last_name,
                                    :accident_and_health_death_claim_claimant_employee_status,
                                    :accident_and_health_death_claim_confirmation_of_form_accuracy,
                                    :accident_and_health_death_claim_about_claimant_occupation,
                                    :accident_and_health_death_claim_date_of_death,
                                    :accident_and_health_death_claim_place_of_death,
                                    :accident_and_health_death_claim_any_factors_to_death_cause,
                                    :accident_and_health_disability_claim_accident_date,
                                    :accident_and_health_disability_claim_accident_place,
                                    :accident_and_health_disability_claim_saps_and_oar_case_no,
                                    :accident_and_health_disability_claim_description_of_accident,
                                    :accident_and_health_disability_claim_is_permanently_disabled,
                                    :accident_and_health_disability_claim_was_person_on_duty,
                                    :accident_and_health_claim_attending_doctor_first_name,
                                    :accident_and_health_claim_attending_doctor_last_name,
                                    :accident_and_health_claim_attending_doctor_practice_number,
                                    :accident_and_health_claim_attending_doctor_contact_number,
                                    :accident_and_health_claim_attending_doctor_address,
                                    :accident_and_health_ttd_claim_description_of_injuries,
                                    :accident_and_health_death_claim_death_cause, :vehicle_claim_type, :vehicle_claim_police_no, :vehicle_claim_accident_address, :vehicle_claim_vehicle_manufacturer, :vehicle_claim_vehicle_model, :vehicle_claim_vehicle_km_completed, :vehicle_claim_vehicle_registration, :vehicle_claim_vehicle_drivers_first_name, :vehicle_claim_vehicle_drivers_last_name, :vehicle_claim_vehicle_drivers_id_number, :vehicle_claim_vehicle_drivers_occupation, :vehicle_claim_vehicle_drivers_license_code, :vehicle_claim_were_there_passengers, :vehicle_claim_were_there_witnesses, :vehicle_claim_accident_description, :vehicle_claim_is_municipal_vehicle_damaged, :vehicle_claim_was_driver_authorized, :vehicle_claim_is_driver_your_employee, :vehicle_claim_has_drivers_license_been_suspended, :vehicle_claim_driver_physical_defects_status, :vehicle_claim_any_other_vehicle_damaged, :vehicle_claim_vehicle_purposes, :accept_declaration, :accept_information_sharing, property_claim_photos_docs: [], health_and_accident_documents: [], vehicle_claim_supporting_docs: [], liability_motor_claim_photos: [], damaged_items_attributes: %i[id item_name serial_number estimated_value _destroy])

    # Uncomment to use Pundit permitted attributes
    # params.require(:claim).permit(policy(@claim).permitted_attributes)
  end
end
