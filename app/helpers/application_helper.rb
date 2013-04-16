module ApplicationHelper


  def start_time
    if params["/searches"]
      @start_time
    else
      DateTime.now
    end
  end

  def end_time
    if params["/searches"]
      @end_time
    else
      DateTime.now + 24.hours
    end
  end

  def location
    if params["/searches"]
      @location
    else
      "San Francisco"
    end
  end
end
