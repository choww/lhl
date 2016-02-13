require 'csv'

# Represents a person in an address book.
class Contact
  # diff class dealing w just csv and contact class will call it [if want to use diff kind of file]
  @@filename = 'contacts.csv'
  attr_reader :id
  attr_accessor :name, :email, :phone
  def initialize(id, name, email)
    @id = id
    @name = name
    @email = email   
    @phone = []
  end
  
  def set_phone(entry)
    # etnry format looks like: "label: 123-4567"
    entry = entry.split(' ')
    "#{entry_arr[0]}: #{entry_arr[1]}"
  end
  
  # Provides functionality for managing a list of Contacts in a database.
  class << self
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
      CSV.read(@@filename)
    end
  
    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email, *phone)
      check_duplicate_email!(email)

      file =  CSV.read(@@filename)
      # id based on number of lines in the file  
      id = file.length + 1
      person = Contact.new(id, name, email)         

      new_contact = [person.id, person.name, person.email] 

      # add each phone number to new_contact if exists
      unless phone.empty? 
        person.phone = phone
        phone.flatten.each do |number|
          new_contact <<  number
        end
      end 
   
      CSV.open(@@filename, 'a') do |contact|
        contact << new_contact 
      end
      person
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO; return the obj instead of a string
      result = nil
     
      CSV.foreach(@@filename) do |contact|
        if contact[0].to_i == id
          result = contact
        end
      end
      result
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      CSV.foreach(@@filename) do |contact|
        contact.each do |row|
           return contact if row.include?(term)
        end
      end
      #all_contacts = CSV.read(@@filename)
      #matched_rows = all_contacts.select do |row|
       #               row.any? do |column|
       #                column.include?(term)
       #              end
       #           end
      # converts every value in the old array into a Contact object
      #matched_rows.map do |row|
        # TODO: account for phone #s
       # Contact.new(row[0], row[1], row[2])
      #end
    end
  end

end
