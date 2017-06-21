class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    if user_signed_in?
      @is_user_staff = current_user.is_staff
    else
      @is_user_staff = false
    end
    @games = Game.all
    if params[:title]
      @games = @games.where("lower(title) like ?", "%#{params[:title]}%")
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    if Purchase.exists?(user_id: current_user.id, game_id: @game.id)
      @user_has_game = true
    else
      @user_has_game = false
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    is_user_staff = current_user.is_user_staff
    if is_user_staff
      redirect_to action: "index"
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ajaxFunction
    valor = params['game_id']
    if Purchase.exists?(user_id: current_user.id, game_id: valor)
      Purchase.where(user_id: current_user.id, game_id: valor).destroy_all
    else
      @Purchase = Purchase.new
      @Purchase.user = current_user
      @Purchase.game = Game.find(valor)
      @Purchase.save
    end
    #course = Course.find(valor)
    #likes = course.people.count
    #answer = {"create" => "true"}
    #respond_to do |format|
    #  format.json { render json: rez }  # respond with the created JSON object
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :description, :image_url)
    end
end
