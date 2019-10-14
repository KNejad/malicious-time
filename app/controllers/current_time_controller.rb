class CurrentTimeController < ApplicationController
  def index
    now = DateTime.now.utc
    render plain: "datetime(#{now.year}, #{now.month}, #{now.day}, #{now.hour}, #{now.min})"
  end
end
