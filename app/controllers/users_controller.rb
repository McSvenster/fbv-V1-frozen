class UsersController < ApplicationController
  skip_before_filter :logged_in, only: [:reset_password, :request_reset]
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @planer = User.where(role: 2).order('nname DESC')
    @bestatter = User.where(role: 3).order('nname DESC')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.role = 3
    @show_password_fields = false
  end

  # GET /users/1/edit
  def edit
  end

  def request_reset
    if params[:email]
      if User.where(email: params[:email]).first
        @user = User.where(email: params[:email]).first
        @user.set_onetimetoken
        UserMailer.password_reset(@user).deliver_now
        redirect_to new_session_path, notice: t(:email_sent)
      else
        redirect_to request_reset_users_path, alert: t(:unknown_email)
      end
    end
  end

  def reset_password
    @user = User.find(params[:id])
    if @user.onetimetoken == params[:onetimetoken]
      session[:user_id] = @user.id
      @current_user = @user
      @user.reset_onetimetoken
    else
      redirect_to new_session_path, alert: t(:wrong_token)
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.set_onetimetoken
    respond_to do |format|
      if @user.save
        # UserMailer.welcome_email(@user).deliver_now
        format.html { redirect_to @user, notice: 'Der Bestatter / Planer wurde angelegt und muss sich nun ein Passwort geben.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user.passwd_upd
          @user.reset_onetimetoken
          format.html { redirect_to root_url, notice: t(:password_changed) }
        else
          format.html { redirect_to @user, notice: 'Die Daten wurden aktualisiert.' }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        if @user.passwd_upd
          flash[:warning] = t(:password_not_changed)
          format.html { render :reset_password }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Der Bestatter / Planer wurde vom System gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :vname, :nname, :password_digest, :password, :password_confirmation, :passwd_upd, :company_id, :hnr, :plz, :strasse, :ort, :tel, :role)
    end
end