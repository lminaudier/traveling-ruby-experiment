#!/usr/bin/env ruby

require "liquid"

@template = Liquid::Template.parse("hi {{name}}") # Parses and compiles the template
puts @template.render('name' => ARGV.join(","))
