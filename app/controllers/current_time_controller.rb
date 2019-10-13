class CurrentTimeController < ApplicationController
  def index
    now = DateTime.now
    render plain: "datetime(#{now.year}, #{now.month}, #{now.day}, #{now.hour}, #{now.minute})"
  end
end
