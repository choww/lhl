module ApplicationHelper

  def full_name(person)
    "#{person.firstname} #{person.lastname}"
  end
  
  def format_date(date)
    date.strftime("%B %d, %Y")
  end
end
