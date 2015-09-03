#!/usr/bin/env ruby

require 'rmagick'

#image = Magick::Image.read("icon.png").first
#target = image.scale(0.5)
#target.write("icon2.png")

target_directories = []

dpi = { "name" => ARGV.empty? ? "drawable-xxxhdpi" : ARGV[0] + "/drawable-xxxhdpi", "scale" => 1.0 }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "drawable-xxhdpi" : ARGV[0] + "/drawable-xxhdpi", "scale" => 0.75 }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "drawable-xhdpi" : ARGV[0] + "/drawable-xhdpi", "scale" => 0.5 }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "drawable-hdpi" : ARGV[0] + "/drawable-hdpi", "scale" => 0.375 }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "drawable-mdpi" : ARGV[0] + "/drawable-mdpi", "scale" => 0.25 }
target_directories.push(dpi)

dpi = { "name" => ARGV.empty? ? "drawable-ldpi" : ARGV[0] + "/drawable-ldpi", "scale" => 0.1875 }
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
        target_file = target["name"] + "/" + item
        target = image.scale(target["scale"])
        
        
        puts target_file
        target.write(target_file)
    end
end