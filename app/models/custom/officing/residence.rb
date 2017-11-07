require_dependency Rails.root.join('app', 'models', 'officing', 'residence').to_s

class Officing::Residence

  def residence_in_madrid
    return true

   end

  def allowed_age
    return true
  end

  def geozone
    nil
  end

  def district_code
    nil
  end

  def gender
    nil
  end

  def date_of_birth
    DateTime.now
  end

end
