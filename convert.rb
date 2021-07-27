# converts the dates of the webflow exported file to wordpress dates.
# it assumes that the date attributes are on columns 4, 5 and 6
require 'csv'

file_name = ARGV[0]

def parse_file(file_name)
  csv = CSV.parse(File.read(file_name), headers: true)

  def parse_date(date)
    DateTime.parse(date).strftime('%Y-%m-%d %H:%M:%S')
  end

  CSV.open("parsed - #{file_name}", "wb") do |new_csv|
    new_csv << csv.headers.to_a
    csv.each do |row|
      row[4] = parse_date(row[4])
      row[5] = parse_date(row[5])
      row[6] = parse_date(row[6])
      new_csv << row.to_h.values
    end
  end

  puts "File completed: 'parsed - #{file_name}'"
end

if !file_name.nil? && !file_name.empty?
  begin
    parse_file(file_name)
  rescue Errno::ENOENT => e
    puts "#{file_name} does not exist."
  end
else
  puts 'pass the csv file name as argument.'
end
