class V1::StreamsController < ApplicationController
  protect_from_forgery :except => :new
  before_action :validate_access, only: [:list, :last]

  def new
    key = request.headers['key']
    device = Device.find_by_key(key) if key
    body = request.body.read

    if device && is_json_valid?(body)
      device.streams.create(body: body)
      return_array = ['status' => 'success']
      check_triggers(device, body)
      render json: return_array
    else
      #change error code for a global constant
      return_array = ['status' => 'error', 'error_code' => '001']
      render json: return_array
    end
  end

  def list
    id = params[:id]

    if params[:date]
      date = params[:date]
      end_date = params[:end_date] == nil ? date : params[:end_date]
      end_date = Date.parse end_date
      end_date += 1.day
    end

    begin
      device = Device.find(id) if id
      streams = device.streams.select(:body,:created_at,:id).order("created_at DESC").limit(100)

      streams = streams.where("created_at >= ?", date) if date
      streams = streams.where("created_at < ?", end_date) if end_date

      @streams = streams.map do |stream|
        stream.body = JSON.parse(stream.body)
        stream
      end
      render json: @streams
    rescue ActiveRecord::RecordNotFound
      render json: {}
    end
  end

  def last
    id = params[:id]

    begin
      device = Device.find(id) if id
      streams = device.streams.select(:body,:created_at,:id).order("created_at DESC").limit(1)
      @streams = streams.map do |stream|
        stream.body = JSON.parse(stream.body)
        stream
      end
      render json: @streams
    rescue ActiveRecord::RecordNotFound
      render json: {}
    end
  end


  private
    def validate_access
      user = User.find_by_token(params[:token])
      if user.nil? || !user.devices.where(id: params[:id])
        render status: :unauthorized
        return
      end
    end

    def is_json_valid?(json_string)
      begin
        JSON.parse(json_string)
        true
      rescue
        false
      end
    end

    def check_triggers(device,stream)
      device.triggers.each do |trigger|
        puts trigger.to_s
        path = JsonPath.new(trigger.property)
        puts path.to_s
        
        #remove doble quotes
        value = path.on(stream_to_json(stream))
        binding.pry
        if (value.size > 0 && value[0].to_s.send(trigger.operation, trigger.value))
           TriggerMail.welcome_email(trigger.email).deliver
        end
      end
    end

    def stream_to_json(stream)
      JSON.parse(stream)
    end
end
