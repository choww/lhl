module ApplicationHelper

  def full_name(person)
    "#{person.firstname} #{person.lastname}"
  end
end
