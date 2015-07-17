#!/usr/bin/env ruby

require 'rmagick'

image = Magick::Image.read("icon.png").first
target = image.scale(0.5)
target.write("icon2.png")
