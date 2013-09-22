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
    # I really want to just grab the POST body and stuff it in 'payload'.
    # However, I've tried request.body.read, many params properties and many
    # other things and nothing seems to get me the raw request.
    payload_params = params.clone
    payload_params.delete(:response)
    payload_params.delete(:service_id)
    payload_params.delete(:action)
    payload_params.delete(:controller)

    @response = @service.responses.build({service_id: params[:service_id], payload: payload_params.to_s})

    if params[:what] == 'pcap'
        system("(sleep 20 && curl -X POST -H 'Content-Type: application/json' -u admin:test1234 -d '{\"comment\": \"Packet capture completed, id: 17\"}' http://localhost:3000/incidents/#{ params[:incident_id] }/comments) &")
    elsif params[:what] == 'userlookup'
        system("(sleep 20 && curl -X POST -H 'Content-Type: application/json' -u admin:test1234 -d '{\"incident_id\": #{ params[:incident_id] }, \"username\": \"theron\" }' http://localhost:9997/threat/json_event/events/beLBheg39af_Yc7TTd1MlA && curl -X POST -H 'Content-Type: application/json' -u admin:test1234 -d '{\"comment\": \"Updated IP mapping: #{ params[:hosts][0] } is user 'theron'\"}' http://localhost:3000/incidents/#{ params[:incident_id] }/comments) &")
    end

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
end
