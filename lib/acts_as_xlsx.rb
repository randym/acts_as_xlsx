require 'acts_as_xlsx/ar.rb'
begin
  Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx
rescue NameError
  puts "Mime module not defines. Skipping registration of xlsx"
end
