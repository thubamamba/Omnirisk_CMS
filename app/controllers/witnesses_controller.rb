class WitnessesController < ApplicationController
  before_action :set_witness, only: [:show, :edit, :update, :destroy]

  # GET /witnesses
  def index
    @pagy, @witnesses = pagy(Witness.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @witnesses
  end

  # GET /witnesses/1 or /witnesses/1.json
  def show
  end

  # GET /witnesses/new
  def new
    @witness = Witness.new

    # Uncomment to authorize with Pundit
    # authorize @witness
  end

  # GET /witnesses/1/edit
  def edit
  end

  # POST /witnesses or /witnesses.json
  def create
    @witness = Witness.new(witness_params)

    # Uncomment to authorize with Pundit
    # authorize @witness

    respond_to do |format|
      if @witness.save
        format.html { redirect_to @witness, notice: "Witness was successfully created." }
        format.json { render :show, status: :created, location: @witness }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @witness.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /witnesses/1 or /witnesses/1.json
  def update
    respond_to do |format|
      if @witness.update(witness_params)
        format.html { redirect_to @witness, notice: "Witness was successfully updated." }
        format.json { render :show, status: :ok, location: @witness }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @witness.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /witnesses/1 or /witnesses/1.json
  def destroy
    @witness.destroy!
    respond_to do |format|
      format.html { redirect_to witnesses_url, status: :see_other, notice: "Witness was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_witness
    @witness = Witness.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @witness
  rescue ActiveRecord::RecordNotFound
    redirect_to witnesses_path
  end

  # Only allow a list of trusted parameters through.
  def witness_params
    params.require(:witness).permit(:claim_id, :witness_prefix, :witness_name, :witness_contact_number, :witness_email, :witness_physical_address)

    # Uncomment to use Pundit permitted attributes
    # params.require(:witness).permit(policy(@witness).permitted_attributes)
  end
end
