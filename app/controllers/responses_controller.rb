class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :destroy]
  before_action :set_service, only: [:show, :create]

  # GET /responses
  # GET /responses.json
  def index
    @responses = Response.all
  end

  # GET /services/1/responses/1
  # GET /services/1/responses/1.json
  def show
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = @service.responses.build(response_params)

    respond_to do |format|
      if @response.save
        format.json { render action: 'show', status: :created, location: service_response_url(@service, @response) }
      else
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1/responses/1
  # DELETE /services/1/responses/1.json
  def destroy
    @response.destroy

    respond_to do |format|
      format.html { redirect_to services_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    def set_service
      @service = Service.find(params[:service_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:payload)
    end
end
