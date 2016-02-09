
require 'csv'

# Represents a person in an address book.
class Contact
  attr_reader :id
  attr_accessor :name, :email
  @@total = 0
  def initialize(name, email)
    @@total += 1
    @id = @@total
    @name = name
    @email = email
  end

  # Provides functionality for managing a list of Contacts in a database.

  # Returns an Array of Contacts loaded from the database.
  def self.all  
    contacts = CSV.read('contacts.csv')
  end

  # Creates a new contact, adding it to the database, returning the new contact.
  def self.create(name, email)
   # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
   new = Contact.new(name,email)
   new_contact = [new.id, new.name, new.email]
   CSV.open('contacts.csv', 'a') do |contact|
    contact << new_contact
   end
  end

  # Returns the contact with the specified id. If no contact has the id, returns nil.
  def self.find(id)
    CSV.foreach('contacts.csv') do |contact|
      if contact[0].to_i == id
        return contact
      else
        return "Entry with ID #{id} not found"
      end
    end
  end

  # Returns an array of contacts who match the given term.
  def self.search(term)
    CSV.foreach('contacts.csv') do |contact|
      contact.each do |c|
        return contact if c.include?(term)
      end
    end
  end
end
