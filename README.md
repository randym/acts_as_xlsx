Acts as xlsx: Office Open XML Spreadsheet Generation plugin for active record
====================================
[![Build Status](https://secure.travis-ci.org/randym/acts_as_xlsx.png)](http://travis-ci.org/randym/acts_as_xlsx/)

**IRC**:          [irc.freenode.net / #axlsx](irc://irc.freenode.net/axlsx)    
**Git**:          [http://github.com/randym/acts_as_xlsx](http://github.com/randym/acts_as_xlsx)   
**Author**:       Randy Morgan   
**Copyright**:    2011      
**License**:      MIT License      
**Latest Version**: 1.0.1 	   
**Ruby Version**: 1.8.7 - 1.9.3  
**Release Date**: December 1st 2011     

Synopsis
--------

Acts_as_xlsx is an active record plugin for Axlsx. It makes generating excel spreadsheets from any subclass of ActiveRecord::Base as simple as a couple of lines of code.

Feature List
------------
                                                                              
**1. Mixes into active record base to provide to_xlsx methods on both class and instance active record inheritors.

**2. Can work at the end of any series of finder methods.
                                                         
**3. Can accept any set of find options                     

**4. Automates localization of column heading with i18n support

**5. Lets you specify columns the precise columns and/or methods you want to call to populate your table in one go.

**6. Gives you access to the axlsx package so you can add styles, charts and pictures to satisfy those flashy sales guys.

**7. Plays nicely with both ruby 1.8.7 + rails 2.3 as well as ruby 1.9.3 + rails 3

Installing
----------

To install, use the following command:

    $ gem install acts_as_xlsx
    
Usage
-----

###Examples

A trivial rails example

     #Add the gem to your Gemfile and bundle install
       gem 'acts_as_xlsx'
      
     # app/models/post.rb
       class Post < ActiveRecord::Base
         acts_as_xlsx
       end

     # app/controllers/posts_controller.rb
       class PostsController < ApplicationController
         # GET posts/xlsx     
         def xlsx
           p = Post.to_xlsx
           p.serialize('public/downloads/posts.xlsx')
           send_file 'public/downloads/posts.xlsx', :type=>"application/xlsx"
         end
       end

Specify columns and methods and i18n chain
	p = Post.to_xlsx :columns => [:name, :title, :ranking], :i18n => 'activerecord.attributes'

For examples on how to use axlsx for custom styles, charts, images and more see:
        [http://rubygems.org/gems/axlsx] (https://rubygems.org/gems/axlsx)

###Documentation

This gem is 100% documented with YARD, an exceptional documentation library. To see documentation for this, and all the gems installed on your system use:

      gem install yard
      yard server -g


###Specs

This gem has 100% coverage using Test::Unit
 
Changelog
---------
- **October.30.11**: 1.0.1 release
  - Patch for inclusion error

- **October.30.11**: 1.0.0 release
  - First release

- **October.30.11**: 1.0.0a release
  - First pre release
 
Please see the {file:CHANGELOG.md} document for past release information.


Copyright
---------

Acts_as_xlsx &copy; 2011 by [Randy Morgan](mailto:digial.ipseity@gmail.com). Acts_as_xlsx is 
licensed under the MIT license. Please see the {file:LICENSE} document for more information.
