class Case::CarsController < Case::ApplicationController
  def welcome
    
  end
  
  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car }
    end
  end

  # GET /cars/new
  # GET /cars/new.json
  def new
    @car = Car.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car }
    end
  end

  def new_car_accident
    @car = Car.new

    respond_to do |format|
      format.html # new.html.erb      
    end
  end

  def upload_car_files
    
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(params[:car])
      if @car.save
        flash_t :success
        redirect_to case_cars_path
      else
        title_t :new
        render :action => :new
      end
  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    @car = Car.find(params[:id])

    respond_to do |format|
      if @car.update_attributes(params[:car])
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car = Car.find(params[:id])
    @car.destroy

    respond_to do |format|
      format.html { redirect_to case_cars_url }
      format.json { head :no_content }
    end
  end
end