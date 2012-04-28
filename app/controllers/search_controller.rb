class SearchController < ApplicationController
  def index
  end
  def search_numbers
    account_sid = 'AC214562c1f198467e9f6a6d5e7372e405'
    auth_token = '5509e2a802001f71727560cde233da48'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    search_params = {}
    %w[in_postal_code near_number contains].each do |p|
      search_params[p] = params[p] unless params[p].nil? || params[p].empty?
    end
    begin
      puts "-------------------------sandy"
      puts "-------------------------sandy1"
      local_numbers = client.account.available_phone_numbers.get('US').local
      puts "-------------------------Kaushal"+local_numbers
      numbers = local_numbers.list(search_params)
      uts "-------------------------mohit"+numbers
      unless numbers.empty?
        out = '<html><head><title>Choose a number</title></head><body><h3>Choose a number</h3>'
        numbers.each do |number|
        out << "<form method='POST' action='/buy-number'>"
        out << "<label>#{number.friendly_name}</label>"
        out << "<input type='hidden' name='PhoneNumber' value='#{number.phone_number}' />"
        out << "<input type='submit' value='BUY' /></form>"
        end
        out << '</body></html>'
      else
        '<b>Sorry!</b> Twilio doesn\'t have any numbers available that match those constraints.'
      end
    rescue StandardError => e
      '<b>Sorry!</b> ' + e.message + '.'
    end
  end
end
