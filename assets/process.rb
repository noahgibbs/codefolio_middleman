#!/usr/bin/env ruby

# Create static HTML from the source files for the directory

# May need to: brew install imagemagick

require "json"
require "pathname"

Dir.chdir(__dir__)

ASSET_KEYS = %w(file alt credit_url credit_text)

def image_w_h(filename)
  begin
    info = `identify -format "%[fx:w] x %[fx:h]" #{filename}`
    w, h = *(info.split(" x ", 2).map(&:to_i))
  rescue
    STDERR.puts "Could not get dimensions for image file: #{filename.inspect}"
    raise
  end

  unless(w)
    raise "Couldn't get dimensions for file #{filename.inspect}!"
  end

  return w, h
end

Dir["*.json"].each do |asset_file|
  asset = JSON.load(File.read asset_file)

  keys = asset.keys.select { |k| k != "" && k[0] != "\#" }
  illegal_keys = keys - ASSET_KEYS
  if illegal_keys.size > 0
    raise "Illegal keys in asset manifest (#{asset_file.inspect}): #{illegal_keys.inspect}"
  end

  orig_filename = "orig/#{asset["file"]}"
  unless File.exists?(orig_filename)
    raise "No such image as #{orig_filename.inspect} while reading #{asset_file.inspect}!"
  end

  ext = File.extname(asset["file"])
  output_ext = ext.downcase.sub("jpeg", "jpg")
  dir = File.dirname(asset["file"])
  basename = File.basename(asset["file"], ext)

  STDERR.puts "AFILE: #{asset["file"].inspect}"
  STDERR.puts "EXT: #{ext.inspect}"
  STDERR.puts "OUT EXT: #{output_ext.inspect}"
  STDERR.puts "DIR: #{dir.inspect}"
  STDERR.puts "BASE: #{basename.inspect}"

  # Link the full-size image and add a symlink with dimensions in the filename

  full_path = Pathname.new("img/#{dir}/#{basename}_full#{output_ext}").cleanpath.to_s
  unless File.symlink?(full_path)
    sym_path = Pathname.new("../orig/#{asset["file"]}").cleanpath.to_s
    File.symlink(sym_path, full_path)
  end
  full_w, full_h = image_w_h(full_path)
  full_dims_path = full_path.sub("_full#{output_ext}", "_#{full_w}_#{full_h}#{output_ext}")
  unless File.symlink?(full_dims_path)
    File.symlink("#{basename}_full#{output_ext}", full_dims_path)
  end

  # Create an aside-sized small-scale image called FILENAME_aside.EXT and a symlink with dimensions in the filename

  aside_path = Pathname.new("img/#{dir}/#{basename}_aside#{output_ext}").cleanpath.to_s
  unless File.exist?(aside_path) && File.mtime(aside_path) > File.mtime(orig_filename)
    system("convert #{orig_filename} -auto-orient -unsharp 0x.5 -background black -alpha remove -thumbnail 216x216 #{aside_path}") || raise("Could not convert image: #{image.inspect}!")
  end
  aside_w, aside_h = image_w_h(aside_path)
  aside_dims_path = aside_path.sub("_aside#{output_ext}", "_#{aside_w}_#{aside_h}#{output_ext}")
  unless File.symlink?(aside_dims_path)
    File.symlink("#{basename}_aside#{output_ext}", aside_dims_path)
  end

  # Create a thumbnail called FILENAME_thumb.png and a symlink to it with dimensions in the filename

  thumb_path = Pathname.new("img/#{dir}/#{basename}_thumb.png").cleanpath.to_s
  unless File.exist?(thumb_path) && File.mtime(thumb_path) > File.mtime(orig_filename)
    system("convert #{orig_filename} -auto-orient -unsharp 0x.5 -background black -alpha remove -thumbnail 100x100 #{thumb_path}") || raise("Could not convert image: #{image.inspect}!")
  end
  thumb_w, thumb_h = image_w_h(thumb_path)
  thumb_dims_path = thumb_path.sub("_thumb.png", "_#{thumb_w}_#{thumb_h}.png")
  unless File.symlink?(thumb_dims_path)
    File.symlink("#{basename}_thumb#{output_ext}", thumb_dims_path)
  end

  generated_info = {
    orig_path: orig_filename,

    full_path: full_path,
    full_w: full_w,
    full_h: full_h,
    full_dims_path: full_dims_path,

    aside_path: aside_path,
    aside_w: aside_w,
    aside_h: aside_h,
    aside_dims_path: aside_dims_path,

    thumb_path: thumb_path,
    thumb_w: thumb_w,
    thumb_h: thumb_h,
    thumb_dims_path: thumb_dims_path,
  }
  ASSET_KEYS.each { |key| generated_info[key] = asset[key] if asset[key] }
  generated_text = JSON.pretty_generate(generated_info)

  out_asset_path = asset_file.sub(".json", ".gen_json")
  if !File.exist?(out_asset_path) || generated_text != File.read(out_asset_path)
    STDERR.puts "Writing generated asset file: #{out_asset_path.inspect}"
    File.open(out_asset_path, "w") { |f| f.write(generated_text) }
  end
end
