#!/usr/bin/env ruby

# Create static HTML from the source files for the directory

# May need to: brew install imagemagick

Dir.chdir(__dir__)

Dir["ss/*"].each do |image|
  ext = File.extname(image)
  thumb_path = image.gsub(ext, ".png").gsub(/^ss/, "thumbs")

  next if File.exist?(thumb_path) && File.mtime(thumb_path) > File.mtime(image)

  begin
    info = `identify -format "%[fx:w] x %[fx:h]" #{image}`
    w, h = *(info.split(" x ", 2).map(&:to_i))
  rescue
    STDERR.puts "Could not process image: #{image.inspect}"
    raise
  end

  system("convert #{image} -auto-orient -unsharp 0x.5 -thumbnail 300x300 #{thumb_path}") || raise("Could not convert image: #{image.inspect}!")
end
