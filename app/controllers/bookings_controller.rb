class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @dailybookings = {}
    @range = (Date.today..Date.today + Option.first.bdates)
    @range.each do |d|
      @dailybookings[d] = bookable_slots(d) - Booking.where(bdate: d).count
    end
  end

  def all
    @title = t(:bookings)
    if @current_user.role == 3
      @bookings = Booking.where( company_id: @current_user.company_id )
    else
      if params[:datum] && params[:datum] != ""
        @title = "Buchungen für den #{l(params[:datum].to_date)}"
        @bookings = Booking.where( bdate: params[:datum].to_date).order('btime ASC')
      else
        @bookings = Booking.all.order('bdate ASC')
      end
      @deletables_count = Booking.where("bdate < ?", Time.now - 3.days).count
    end
  end

  def cleanup
    Booking.where("bdate < ?", Time.now - 3.days).each do |oldbk|
      oldbk.destroy
    end
    redirect_to all_path
  end
  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    if @current_user.role == 3
      @booking = Booking.new( company_id: @current_user.company_id )
    else
      @booking = Booking.new
    end
    @booking.bdate = params[:datum]
    @booking.wludate = @booking.bdate.to_date + 1.days + 10.hours
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.created_by = @current_user.nname + ", " + @current_user.vname

    respond_to do |format|
      # format.js
      if @booking.save
        format.html { redirect_to bookings_path, notice: 'Die Buchung wurde im System gespeichert.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to all_path, notice: 'Die Buchung wurde aktualisiert.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to all_path, notice: 'Die Buchung wurde gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:company_id, :approved, :ddate, :vname, :nname, :birthdate, :lwohnort, :lsdate, :wludate, :bdate, :btime, :deliveryoption_id)
    end
end
