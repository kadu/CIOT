class V1::StreamsController < ApplicationController
  protect_from_forgery :except => :new
  
  def new
    key = request.headers['key']
    device = Device.find_by_key(key) if key
    body = request.body.read
    
    if device && is_json_valid?(body)
      device.streams.create(body: body)
      render status: :ok
    else
      render status: :bad_request
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
      streams = device.streams.select(:body,:created_at,:id).limit(100)
      
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

  private
    def is_json_valid?(json_string)
      begin
        JSON.parse(json_string)
        true
      rescue
        false
      end
    end
end
