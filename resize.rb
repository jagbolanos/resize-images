#!/usr/bin/env ruby

require 'rmagick'

#image = Magick::Image.read("icon.png").first
#target = image.scale(0.5)
#target.write("icon2.png")

target_directories = []

dpi = { "name" => ARGV.empty? ? "3x" : ARGV[0] + "/3x", "scale" => 1.0, "suffix" => "@3x" }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "2x" : ARGV[0] + "/2x", "scale" => 0.6666, "suffix" => "@2x" }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "1x" : ARGV[0] + "/1x", "scale" => 0.3333, "suffix" => "" }
target_directories.push(dpi)

target_directories.each do |target|
    puts target["name"]
    dirName = target["name"]
    Dir.mkdir(dirName) unless File.exists?(dirName)
end


source_directory = ARGV.empty? ? "transition" : ARGV[0] + "/transition"
puts source_directory

Dir.foreach(source_directory) do |item|
    next if File.directory? item
    next if item == ".DS_Store"
    
    puts item
    
    target_directories.each do |target|
        image = Magick::Image.read(source_directory + "/" + item).first
        puts target
        puts target["name"]
        target_file = target["name"] + "/" + item.gsub(".", target["suffix"] + ".")
        target = image.scale(target["scale"])
        
        
        puts target_file
        target.write(target_file)
    end
end