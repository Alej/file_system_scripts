require 'helper'
require 'crawler'

class TestCrawler < Test::Unit::TestCase
  
  context 'crawler' do
    setup do
      @crawler = Crawler::new(File.dirname(__FILE__) + '/Fixtures')
    end
    
    def assert_equal_basenames(arr1,arr2)
      assert_equal(arr1,arr2.map {|pn| pn.basename.to_s})
    end
    
    should 'have path reader accessor' do
      assert_respond_to(@crawler,:path)
    end
    
    should 'expand root path to current path' do
      assert @crawler.path.expand_path.absolute?
    end
    
    context 'non recursive' do
      setup do
        @crawler.recursive = false
        @dirs = %w{dir1 dir2 dir3}
        @files = %w{file1.f1 file2.f2 file3.f3}
      end
      
      should 'have expected directories' do
        assert_equal_basenames(@dirs,@crawler.directories)
      end
      
      should 'have expected files' do
        assert_equal_basenames(@files,@crawler.files)
      end
      
      should 'find empty dirs' do
        empty_dirs = []
        @crawler.each_directory {|d| empty_dirs << d if d.children.empty?}
        assert_equal_basenames(['dir3'],empty_dirs)
      end
    end
    
    context 'recursive' do
      setup do
        @crawler.recursive = true
        @dirs = %w{dir1 dir1_1 dir1_1_1 dir1_2 dir1_3 dir2 dir3}
        @files = %w{file1_1_1_1.f1 file1_1_1_2.f2 file1_1_1_3.f3 file1_1_1.f1 file1_1_2.f2 file1_1_3.f3 file1_2_1.f1 file1_2_2.f2 file1_2_3.f3 file1_1.f1 file1_2.f2 file1_3.f3 file2_1.f1 file2_2.f2 file2_3.f3 file1.f1 file2.f2 file3.f3}
      end
      
      should 'have expected directories' do
        assert_equal_basenames(@dirs,@crawler.directories)
      end
      
      should 'have expected files' do
        assert_equal_basenames(@files,@crawler.files)
      end
      
      should 'find empty dirs' do
        empty_dirs = []
        @crawler.each_directory {|d| empty_dirs << d if d.children.empty?}
        assert_equal_basenames(%w{dir1_3 dir3},empty_dirs)
      end
    end
    
  end
  
end