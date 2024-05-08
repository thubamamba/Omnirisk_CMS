class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  def index
    @pagy, @comments = pagy(Comment.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new

    # Uncomment to authorize with Pundit
    # authorize @comment
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    # Uncomment to authorize with Pundit
    # authorize @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!
    respond_to do |format|
      format.html { redirect_to comments_url, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @comment
  rescue ActiveRecord::RecordNotFound
    redirect_to comments_path
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:claim_id, :user_id, :description, :is_verified, :is_active)

    # Uncomment to use Pundit permitted attributes
    # params.require(:comment).permit(policy(@comment).permitted_attributes)
  end
end
