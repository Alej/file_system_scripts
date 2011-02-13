require File.dirname(__FILE__) + '/file_system_scripts'
require 'pathname'
class Crawler
  attr_reader :path
  attr_accessor :recursive
  
  def initialize(root, recursive = true)
    @path = Pathname.new(root)
    @recursive = recursive
    super
  end
  
  def each_directory(&block)
    each_entry(@path,false,&block)
  end
  
  def directories
    dirs = []
    each_directory {|d| dirs << d}
    dirs
  end
  
  def each_file(&block)
    each_entry(@path,true,&block)
  end
  
  def files
    files = []
    each_file {|f| files << f}
    files
  end
  
  private
  
  def each_entry(path,just_files,&block)
    path.children.each do |e|
      yield(e) if (e.file? and just_files)
      if (e.directory?)
        yield(e) unless just_files
        each_entry(e,just_files,&block) if @recursive
      end
    end
  end
end
