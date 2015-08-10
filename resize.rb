#!/usr/bin/env ruby

require 'rmagick'

#image = Magick::Image.read("icon.png").first
#target = image.scale(0.5)
#target.write("icon2.png")

target_directories = []

dpi = { "name" => "xxhdpi", "scale" => 1.0 }
target_directories.push(dpi)

dpi = { "name" => "xhdpi", "scale" => 0.66 }
target_directories.push(dpi)

dpi = { "name" => "hdpi", "scale" => 0.5 }
target_directories.push(dpi)

dpi = { "name" => "mdpi", "scale" => 0.33 }
target_directories.push(dpi)

dpi = { "name" => "ldpi", "scale" => 0.25 }
target_directories.push(dpi)

target_directories.each do |target|
    puts target["name"]
    Dir.mkdir(target["name"]) unless File.exists?(target["name"])
end

source_directory = "transition"
Dir.foreach(source_directory) do |item|
    next if File.directory? item
    next if item == ".DS_Store"
    
    puts item
    
    target_directories.each do |target|
        image = Magick::Image.read(source_directory + "/" + item).first
        puts target
        puts target["name"]
        target_file = target["name"] + "/" + item
        target = image.scale(target["scale"])
        
        
        puts target_file
        target.write(target_file)
    end
    
end