require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
# Sample query: ruby contact_list.rb show 1 => should display the contact with and ID of 1
class ContactList
  def initialize
  end

  def command_menu
    puts "new    - Create a new contact"
    puts "list   - List all contacts"
    puts "show   - Show a contact"
    puts "search - Search contacts"
  end

  def name_email
    puts "Enter your full name:"
    @name = gets.chomp
    puts "Enter your email:"
    @email = gets.chomp
  end

  def eval_command(response)
    case response
    when "new"
      name = ARGV[1]
      email = ARGV.last
      Contact.create(name, email)
      puts "#{name} has been added!"
    when "list"
      p Contact.all
    when "show"
      id = ARGV.last.to_i
      p Contact.find(id)
    when "search"
      term = ARGV.last
      p Contact.search(term)
    else
      puts "Choose one from the  list of available commands: "
      command_menu
    end
  end
  
  def run
    response = ARGV.first
    eval_command(response)
  end 

end

list = ContactList.new
list.run
