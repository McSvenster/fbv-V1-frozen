class DeliveryoptionsController < ApplicationController
  before_action :set_deliveryoption, only: [:show, :edit, :update, :destroy]

  # GET /deliveryoptions
  # GET /deliveryoptions.json
  def index
    @deliveryoptions = Deliveryoption.all
  end

  # GET /deliveryoptions/1
  # GET /deliveryoptions/1.json
  def show
  end

  # GET /deliveryoptions/new
  def new
    @deliveryoption = Deliveryoption.new
  end

  # GET /deliveryoptions/1/edit
  def edit
  end

  # POST /deliveryoptions
  # POST /deliveryoptions.json
  def create
    @deliveryoption = Deliveryoption.new(deliveryoption_params)

    respond_to do |format|
      if @deliveryoption.save
        format.html { redirect_to @deliveryoption, notice: 'Deliveryoption was successfully created.' }
        format.json { render :show, status: :created, location: @deliveryoption }
      else
        format.html { render :new }
        format.json { render json: @deliveryoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveryoptions/1
  # PATCH/PUT /deliveryoptions/1.json
  def update
    respond_to do |format|
      if @deliveryoption.update(deliveryoption_params)
        format.html { redirect_to @deliveryoption, notice: 'Deliveryoption was successfully updated.' }
        format.json { render :show, status: :ok, location: @deliveryoption }
      else
        format.html { render :edit }
        format.json { render json: @deliveryoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveryoptions/1
  # DELETE /deliveryoptions/1.json
  def destroy
    @deliveryoption.destroy
    respond_to do |format|
      format.html { redirect_to deliveryoptions_url, notice: 'Deliveryoption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deliveryoption
      @deliveryoption = Deliveryoption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deliveryoption_params
      params.require(:deliveryoption).permit(:option)
    end
end
