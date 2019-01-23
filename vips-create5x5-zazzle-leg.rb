#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'logger'
require 'vips'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

output_png = Vips::Image.black 3325, 6370

originals_from_flickr = []
ARGF.each_line do |file|
  image = Vips::Image.new_from_file file.chomp
  originals_from_flickr.push(image)
end
length = originals_from_flickr.length
logger.debug "number of flickr pics:" + length.to_s
#logger.debug files[0]
#logger.debug files[-1]
# 3325 / 5 px = 665 rows one way i.e. "horizontally"
# 6358 -> 6370 / 5 px = 1274 rows the other way "vertically"
# each original is 4608 x 3456 px
# round down to 4605 x 3455 px

#     which means there are 921 five pixel columns horizontally
#     and 691 five pixel rows vertically

# which means the script needs to pick 847210 (665 * 1274) random 5px x 5x patches
i = 0
x = 0
y = 0
loop do
  i += 5
  if i > 847210
    break
  end
  xoffset = rand(0..920) * 5
  yoffset = rand(0..690) * 5
  flickr_pic = rand(0..length - 1)
  (xoffset..xoffset + 4).each do |flickrx|
    r, g, b = originals_from_flickr[flickr_pic].getpoint flickrx, yoffset
    output_png = output_png.draw_point [r,g,b], x, y
    x += 1
    if x > 920
      x = 0
      y += 1
    end
  end
end

output_png.write_to_file "out.png"
# 		#logger.debug f
# 		#logger.debug xoffset
# 		#logger.debug yoffset
# 		filename = sprintf("ksc-leg-5by5pixel-%6.6d.png", i)
# 		if File.exist? filename
# 			logger.debug(filename + " EXISTS, skipping convert")
# 			next
# 		end
# 		cmd = sprintf("convert %s -crop 5x5+%d+%d  +repage %s", f, xoffset, yoffset, filename)
# 		rc = `#{cmd}`
# 		rc_cmd = sprintf("RC:%s CMD:%s", rc, cmd)
# 		logger.debug rc_cmd
# 	end
# 	break if exit_program
# end