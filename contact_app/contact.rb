require 'byebug'
require 'pg'
#require_relative 'phone_numbers'

# Represents a person in an address book.
class Contact
  attr_reader :id
  attr_accessor :name, :email
  def initialize(name, email,  id=nil)
    @id = id
    @name = name
    @email = email   
  end
  
  def save
    if id.nil?  
      query = Contact.connection.exec_params("INSERT INTO contacts (name,email) VALUES($1, $2) RETURNING id;", [name,email])
      @id = query[0]['id']
    else
      Contact.connection.exec_params("UPDATE contacts SET name=$1, email=$2 WHERE id=$3;", [@name, @email, @id])
    end
  end  

  def destroy
    Contact.connection.exec_params("DELETE FROM contacts WHERE id=$1",[id])
  end

  def phone_numbers
    numbers = []
    results = Contact.connection.exec_params("SELECT p.label, p.number FROM contacts AS c INNER JOIN phone_numbers as p ON c.id = p.contact_id WHERE c.id = $1 GROUP BY p.label, p.number", [id])
    results.each do |number|
      numbers << PhoneNumbers.create(number['label'], number['number'], number['contact_id'])
    end
    numbers
  end
 
  # Provides functionality for managing a list of Contacts in a database.
  class << self
    def connection
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'testuser',
        password: 'supworld'
      );
    end

   def duplicate_email?(email)
     !search(email).empty?     
  end
  
   def check_duplicate_email!(email)
     if duplicate_email?(email)
       raise ArgumentError, "Email already exists!"
     end
   end 

   # Returns an Array of Contacts loaded from the database.
    def all 
      contacts = []
      results = connection.exec_params('SELECT * FROM contacts;')
      results.each do |contact|
        contacts << self.new(contact['name'], contact['email'], contact['id'])
      end 
      contacts
    end
  
    # Creates a new contact, adding it to the database, returning the new contact.
    # phone should be in the format: label1 number1 label2 number2 ...and so on
    def create(name, email, *phone)
      check_duplicate_email!(email)
      new_contact = self.new(name, email)         
      new_contact.save
     
      phone.flatten!
      if phone.length > 0
        (0...phone.length).step(2) do |item|
          new_number = PhoneNumbers.create(phone[item], phone[item+1], new_contact.id.to_i)
          p new_number
        end
      end
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      result = connection.exec_params("SELECT * FROM contacts WHERE id=$1 LIMIT 1;", [id])
      contact = result[0]
      self.new(contact['name'], contact['email'], contact['id'])
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      results = connection.exec_params("SELECT * FROM contacts WHERE name LIKE concat('%', $1::text, '%') OR email LIKE concat('%', $1::text, '%');", [term])
      contacts = []
      results.each do |contact|
        contacts << Contact.new(contact['name'], contact['email'],contact['id'])
      end
      contacts
      # TODO: account for phone #s
    end
  end

end
