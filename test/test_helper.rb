require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'tmpdir'
require 'tempfile'
require 'fileutils'
require 'maildir'

# Create a reusable maildir that's cleaned up when the tests are done
def temp_maildir
  return $maildir if $maildir
  
  dir_path = Dir.mktmpdir("maildir_test")
#  at_exit do
#    puts "Cleaning up temp maildir"
#    FileUtils.rm_r(dir_path)
#  end
  $maildir = Maildir.new(dir_path)
  setup_subdirs if defined?(Maildir::Subdirs)
  return $maildir
end

# create the subdir tree:
# | INBOX
# |-- a
# | |-- x
# | |-- y
# |-- b
def setup_subdirs
  %w(a b a.x a.y).each do |x|
    Maildir.new(File.join($maildir.path, ".#{x}"))
  end
end

# Useful for testing that strings defined & not empty
def assert_not_empty(obj, msg='')
  assert !obj.nil? && !obj.empty?, msg
end
