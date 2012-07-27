require 'acts_as_xlsx/ar.rb'
begin
  # The mime type to be used in respond_to |format| style web-services in rails
  unless defined? Mime::XLSX
    Mime::Type.register "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", :xlsx
  end
rescue NameError
  puts "Mime module not defined. Skipping registration of xlsx"
end
