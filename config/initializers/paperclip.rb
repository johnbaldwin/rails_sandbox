


# Paperclip uses the following ImageMagick binaries
# convert
# identify
#
# Paperclip
#


which_cmd = Cocaine::CommandLine.new('which', ':file', expected_outcodes: [0, 1])
convert_path = which_cmd.run(file: 'convert').strip
identify_path = which_cmd.run(file: 'identify').strip

if File.executable?(convert_path) && File.executable?(identify_path)
  # TODO: check convert and identify are in the same
  convert_dir = Pathname(convert_path).dirname.to_s
  identify_dir = Pathname(identify_path).dirname.to_s
  if convert_dir == identify_dir
    Paperclip.options[:command_path] = convert_dir
  else
    logger = Logger.new(STDOUT)
    # not raising an exception, put outputting warning
    logger.warn('WARNING! ImageMagick commands convert and identify are in different directories')
    logger.warn("         convert is in #{convert_dir}, identify is in #{identify_dir}")
  end
end