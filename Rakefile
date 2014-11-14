require "json"

task :validate do
  jsons = Dir.glob "*.json"

  begin
    puts "Validating JSON files:"

    jsons.each do |file|
      puts "- #{file}"
      JSON.load( File.open file )
    end

    puts
    puts "All good!"

  rescue Exception => e
    puts "ERROR:"
    puts "------"
    puts e

    exit 1
  end

  exit 0
end

task :default => :validate
