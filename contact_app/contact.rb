require 'pg'

# Represents a person in an address book.
class Contact
  attr_reader :id
  attr_accessor :name, :email, :phone
  def initialize(name, email, id=nil)
    @id = id
    @name = name
    @email = email   
    @phone = []
  end
  
  def save
    if id.nil?  
      query = Contact.connection.exec_params("INSERT INTO contacts (name,email) VALUES($1, $2) RETURNING id;", [name,email])
      @id = query[0]['id']
    else
      Contact.connection.exec_params("UPDATE contacts SET name=$1, email=$2 WHERE id=$3;", [@name, @email, @id])
    end
  end  

  def set_phone(entry)
    # etnry format looks like: "label: 123-4567"
    entry = entry.split(' ')
    "#{entry_arr[0]}: #{entry_arr[1]}"
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
     CSV.foreach(@@filename) do |contact|
       return true if contact.include?(email)
     end
   end
  
   def check_duplicate_email!(email)
     if Contact.duplicate_email?(email)
       raise ArgumentError, "Email already exists!"
     end
   end 

   # Returns an Array of Contacts loaded from the database.
   def all 
      contacts = []
      results = connection.exec_params('SELECT * FROM contacts;') 
      results.each do |contact|
        contacts << Contact.new(contact['name'], contact['email'], contact['id'])
      end 
      contacts
    end
  
    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      # TODO: implement!
      #check_duplicate_email!(email)
      new_contact = self.new(name, email)         
      new_contact.save
      # TODO: implement this!
      # add each phone number to new_contact if exists
      #unless phone.empty? 
      #  person.phone = phone
      #  phone.flatten.each do |number|
      #    new_contact <<  number
      #  end
      #end 
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      #result = nil
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
