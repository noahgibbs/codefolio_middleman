#!/usr/bin/env ruby

# Create static HTML from the source files for the directory

# May need to: brew install imagemagick

require "json"
require "pathname"
require "fileutils"

Dir.chdir(__dir__ + "/..")

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

def ensure_symlink(to, from)
  unless File.symlink?(from) && File.readlink(from) == to
    FileUtils.rm_f(from)
    File.symlink(to, from)
  end
end

def handle_output_size(size_name, asset_file, max_width, force_ext: nil)
  ext = File.extname(asset_file)
  output_ext = force_ext ? force_ext : ext.downcase.sub("jpeg", "jpg")
  dir = File.dirname(asset_file)
  basename = File.basename(asset_file, ext)

  orig_filename = "assets/orig/#{asset_file}"
  output_path = Pathname.new("source/img/#{dir}/#{basename}_#{size_name}#{output_ext}").cleanpath.to_s
  output_url = Pathname.new("/img/#{dir}/#{basename}_#{size_name}#{output_ext}").cleanpath.to_s
  unless File.exist?(output_path) && File.mtime(output_path) > File.mtime(orig_filename)
    system("convert #{orig_filename} -auto-orient -unsharp 0x.5 -background black -alpha remove -thumbnail #{max_width}x#{max_width} #{output_path}") || raise("Could not convert image to #{size_name}: #{orig_filename.inspect}!")
  end
  output_w, output_h = image_w_h(output_path)
  output_dims_path = output_path.sub("_#{size_name}#{output_ext}", "_#{size_name}_#{output_w}_#{output_h}#{output_ext}")
  output_dims_url = output_url.sub("_#{size_name}#{output_ext}", "_#{size_name}_#{output_w}_#{output_h}#{output_ext}")

  ensure_symlink("#{basename}_#{size_name}#{output_ext}", output_dims_path)

  {
    "#{size_name}_path" => output_path,
    "#{size_name}_url" => output_url,
    "#{size_name}_w" => output_w,
    "#{size_name}_h" => output_h,
    "#{size_name}_dims_path" => output_dims_path,
    "#{size_name}_dims_url" => output_dims_url,
  }
end

Dir["assets/*.json"].each do |asset_file|
  asset = JSON.load(File.read asset_file)

  keys = asset.keys.select { |k| k != "" && k[0] != "\#" }
  illegal_keys = keys - ASSET_KEYS
  if illegal_keys.size > 0
    raise "Illegal keys in asset manifest (#{asset_file.inspect}): #{illegal_keys.inspect}"
  end

  orig_filename = "assets/orig/#{asset["file"]}"
  unless File.exists?(orig_filename)
    raise "No such image as #{orig_filename.inspect} while reading #{asset_file.inspect}!"
  end

  ext = File.extname(asset["file"])
  output_ext = ext.downcase.sub("jpeg", "jpg")
  dir = File.dirname(asset["file"])
  basename = File.basename(asset["file"], ext)

  # Link the full-size image and add a symlink with dimensions in the filename

  full_path = Pathname.new("source/img/#{dir}/#{basename}_full#{output_ext}").cleanpath.to_s
  full_url = Pathname.new("/img/#{dir}/#{basename}_full#{output_ext}").cleanpath.to_s
  sym_path = Pathname.new(orig_filename).relative_path_from("source/img/#{dir}").to_s
  ensure_symlink(sym_path, full_path)

  full_w, full_h = image_w_h(full_path)
  full_dims_path = full_path.sub("_full#{output_ext}", "_#{full_w}_#{full_h}#{output_ext}")
  full_dims_url = full_url.sub("_full#{output_ext}", "_#{full_w}_#{full_h}#{output_ext}")
  ensure_symlink("#{basename}_full#{output_ext}", full_dims_path)

  # Create an aside-sized small-scale image called FILENAME_aside.EXT and a symlink with dimensions in the filename
  aside_props = handle_output_size("aside", asset["file"], 216)

  # Create a thumbnail called FILENAME_thumb.png and a symlink to it with dimensions in the filename
  thumb_props = handle_output_size("thumbnail", asset["file"], 100, force_ext: ".png")

  generated_info = {
    orig_path: orig_filename,

    full_path: full_path,
    full_url: full_url,
    full_w: full_w,
    full_h: full_h,
    full_dims_path: full_dims_path,
    full_dims_url: full_dims_url,
  }.merge(aside_props).merge(thumb_props)
  ASSET_KEYS.each { |key| generated_info[key] = asset[key] if asset[key] }
  generated_text = JSON.pretty_generate(generated_info)

  out_asset_path = asset_file.sub(".json", ".gen_json")
  if !File.exist?(out_asset_path) || generated_text != File.read(out_asset_path)
    File.open(out_asset_path, "w") { |f| f.write(generated_text) }
  end
end
