require 'byebug'
require 'io/console'
require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
# Sample query: ruby contact_list.rb show 1 => should display the contact with and ID of 1
class ContactList
  def initialize
    # keep track of how many lines are left to read in contacts.csv
    @readable_contacts = 0
    # keep track of where you are in pagination [which idx you should start reading from]
    @curr_row = 0
    #TODO: move elsewhere
    @contacts = Contact.all
  end

  def command_menu
    puts "new    - Create a new contact"
    puts "list   - List all contacts"
    puts "show   - Show a contact"
    puts "search - Search contacts"
  end
  
  # track number of lines remaining to read in an open CSV file
  def track_paginate
    @readable_contacts = @contacts.length
  end

  def paginate_contacts
    # while array not empty, keep on .shift(5)
    last_row = @curr_row + 5
    puts @contacts[@curr_row, last_row]
    
    @curr_row = last_row
    @readable_contacts -= 5
  end

  def get_phone_numbers(contact)
    len = contact.length
    phone_arr = contact[3, len]
    phone_arr.join(' ')
  end

  def total_records
    #contacts.each do |contact|
    #  numbers = get_phone_numbers(contact)
    #  puts "#{contact[0]}: #{contact[1]} (#{contact[2]}) #{numbers}"
    #end
    puts "---"
    puts "#{@contacts.length} records total"
  end

  def add_contact(info)
    # use hash to store args & pass it to Contact.create & test for presence of phone key
    name = info.first
    if info.length == 3 
      email = info.last
      Contact.create(name, email)
    else
      email = info[1]
      len = info.length 
      phone = info[2, len]
      Contact.create(name, email, phone)
   end 
  end

  def eval_command(response)
    case response.shift
    when "new"
      add_contact(response)
    when "list"
      track_paginate
      begin
        paginate_contacts 
        puts "Hit any key to show more"
        STDIN.getch
      end while @readable_contacts > 0
      total_records
    when "show"
      id = response.shift.to_i
      puts Contact.find(id)
    when "search"
      term = response.shift
      puts Contact.search(term)
    else
      puts "Choose one from the  list of available commands: "
      command_menu
    end
  end
  
  def run
    eval_command(ARGV)
  end 

end

list = ContactList.new
puts list.run

