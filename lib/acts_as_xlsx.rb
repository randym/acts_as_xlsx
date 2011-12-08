require 'acts_as_xlsx/ar.rb'
begin
  # The mime type to be used in respond_to |format| style web-services in rails
  Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx
rescue NameError
  puts "Mime module not defines. Skipping registration of xlsx"
end
