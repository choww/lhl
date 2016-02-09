
require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email 
  end

  # Provides functionality for managing a list of Contacts in a database.

  # Returns an Array of Contacts loaded from the database.
  def self.all
    # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
  end

  # Creates a new contact, adding it to the database, returning the new contact.
  def self.create(name, email)
   # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
  end

  # Returns the contact with the specified id. If no contact has the id, returns nil.
  def self.find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
  end

    # Returns an array of contacts who match the given term.
  def self.search(term)
    # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
  end

end
