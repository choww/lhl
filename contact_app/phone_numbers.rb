require 'pg'
require_relative 'contact'

class PhoneNumbers < Contact
  attr_reader :id, :contact_id
  attr_accessor :label, :number
  def initialize(label, number, contact_id, id=nil)
    @label = label
    @number = number
    @id = id
    @contact_id = contact_id
  end
  
  def set_contact_id(id)
    @contact_id = id
  end

  def save
    if id.nil?
      query = PhoneNumbers.connection.exec_params("INSERT INTO phone_numbers (label, number, contact_id) VALUES($1,$2,$3) RETURNING id;", [label, number, contact_id])
      @id = query[0]['id']
      self
    else
      PhoneNumbers.connection.exec_params("UPDATE contacts SET label=$1, number=$2 WHERE id=$3;", [@label, @number, @id])
    end
  end

  class << self
    def connection
      super
    end

    def create(label, number, contact_id)
      new_number = self.new(label, number, contact_id)
      new_number.save
    end
  end
end
