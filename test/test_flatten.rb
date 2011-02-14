require 'tmpdir'
require 'helper'
require 'fileutils'

#copy Fixtures

Dir.mktmpdir do |tmp_dir|
  FileUtils.cp_r(File.join(File.dirname(__FILE__), 'Fixtures'), tmp_dir,verbose: true)
  puts Dir.new(tmp_dir).entries
end

#make sure the directory looks as expected
#Dir.new(tmp_dir)