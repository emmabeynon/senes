module FitbitApiHelper
  def format_sleep(mins)
    mins = mins.to_i
    hours = mins / 60
    mins = mins % 60
    return "#{hours}h, #{mins}m"
  end

  def heart_evaluator(heart_rate)
    if heart_rate_bad?(heart_rate.to_i)
      return 0
    elsif heart_rate_good?(heart_rate.to_i)
      return 2
    else
      return 1
    end
  end

  def sleep_evaluator(sleep_mins)
    sleep_mins = sleep_mins.to_i
    if sleep_bad?(sleep_mins)
      return 0
    elsif sleep_ok?(sleep_mins)
      return 1
    else
      return 2
    end
  end

  def steps_evaluator(steps)
    steps = steps.to_i
    if steps_bad?(steps)
      return 0
    elsif steps_ok?(steps)
      return 1
    else
      return 2
    end
  end

  def overall_today_status(heart_parsed, sleep_parsed, steps_parsed)
    result = heart_evaluator(heart_parsed) + sleep_evaluator(sleep_parsed) + steps_evaluator(steps_parsed)
    if result <= 2
      return 'not doing great'
    elsif result <= 4
      return 'doing ok'
    else
      return 'doing great'
    end
  end

  def single_today_status(result)
    if good_result?(result)
      return 'great'
    elsif ok_result?(result)
      return 'ok'
    else
      return 'bad'
    end
  end

  def week_status(result)
    if good_result?(result)
      return 'above average'
    elsif ok_result?(result)
      return 'normal'
    else
      return 'below average'
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def no_content
    head :no_content
  end

  private

  def heart_rate_bad?(heart_rate)
    heart_rate <= 40 && heart_rate > 0 || heart_rate >= 100
  end

  def heart_rate_good?(heart_rate)
    (50..80).include?(heart_rate)
  end

  def sleep_bad?(mins)
    mins < 300
  end

  def sleep_ok?(mins)
    mins < 360
  end

  def steps_bad?(steps)
    steps < 2000
  end

  def steps_ok?(steps)
    steps < 3000
  end

  def good_result?(result)
    result == 2
  end

  def ok_result?(result)
    result == 1
  end
end
