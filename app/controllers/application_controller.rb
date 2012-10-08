class ApplicationController < ActionController::Base
  protect_from_forgery

    def get_dates()
      #FIXME: should be a better way to do this
      if params[:get_movements]
          params[:from_date] = Date.new(params[:get_movements]["from(1i)"].to_i,params[:get_movements]["from(2i)"].to_i).to_s(:db)
          params[:to_date] = Date.new(params[:get_movements]["to(1i)"].to_i,params[:get_movements]["to(2i)"].to_i).to_s(:db)
      end
      from_month = (params[:from_date]) ?
          Date.new(params[:get_movements]["from(1i)"].to_i,params[:get_movements]["from(2i)"].to_i) :
          Date.today.beginning_of_month.beginning_of_day
      to_month = (params[:to_date]) ?
          Date.new(params[:get_movements]["to(1i)"].to_i,params[:get_movements]["to(2i)"].to_i).end_of_month :
          Date.today.end_of_month.end_of_day
      return from_month,to_month
    end
end
