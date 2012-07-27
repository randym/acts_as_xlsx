Acts as xlsx: Office Open XML Spreadsheet Generation plugin for active record
====================================
[![Build Status](https://secure.travis-ci.org/randym/acts_as_xlsx.png)](http://travis-ci.org/randym/acts_as_xlsx/)

**IRC**:          [irc.freenode.net / #axlsx](irc://irc.freenode.net/axlsx)    
**Git**:          [http://github.com/randym/acts_as_xlsx](http://github.com/randym/acts_as_xlsx)   
**Author**:       Randy Morgan   
**Copyright**:    2011      
**License**:      MIT License      
**Latest Version**: 1.0.6	   
**Ruby Version**: 1.8.7 - 1.9.3  
**Release Date**: July 27th 2012     

Synopsis
--------

Acts_as_xlsx is an active record plugin for Axlsx. It makes generating excel spreadsheets from any subclass of ActiveRecord::Base as simple as a couple of lines of code.

Feature List
------------
                                                                              
**1. Mixes into active record base to provide to_xlsx

**2. Can work at the end of any series of finder methods.
                                                         
**3. Can accept any set of find options                     

**4. Automates localization of column heading with i18n support

**5. Lets you specify columns and methods chains you want to call to populate your table in one go.

**6. Gives you access to the axlsx package so you can add styles, charts and pictures to satisfy those flashy sales guys.

**7. Plays nicely with both ruby 1.8.7 + rails 2.3 as well as ruby 1.9.3 + rails 3

**8. Automatically registers xlsx Mime type for use in respond_to web-service support.

**9. Allows you to specify the Axlsx package to add your data to so you can create a single workbook with a sheet for each to_xlsx call.

Installing
----------

To install, use the following command:

    $ gem install acts_as_xlsx
    
Usage
-----

###Examples

See the Guides here: 

[http://axlsx.blogspot.com/] (http://axlsx.blogspot.com/)

For examples on how to use axlsx for custom styles, charts, images and more see:

[http://github.com/randym/axlsx](http://github.com/randym/axlsx)   

###Documentation

This gem is 100% documented with YARD, an exceptional documentation library. To see documentation for this, and all the gems installed on your system use:

      gem install yard
      yard server -g


###Specs

This gem has 100% coverage using Test::Unit
 
Changelog
---------
- **July.27.12**: 1.0.6 release
  - conditionaly register XLSX mime type

- **February.14.12**: 1.0.5 release
  - acts_as_xlsx propery declares it's dependancy on i18n instead of relying on the parent gem.

- **December.7.11**: 1.0.4 release
  - acts_as_xlsx now supports specifying the Axlsx package the export will be added to
  - Support for custom named and I18n names for worksheets.


Please see the {file:CHANGELOG.md} document for past release information.


Copyright
---------

Acts_as_xlsx &copy; 2011 by [Randy Morgan](mailto:digial.ipseity@gmail.com). Acts_as_xlsx is 
licensed under the MIT license. Please see the {file:LICENSE} document for more information.
