module SpecUtils

  def self.banner_if_multiple_spec_helper
    # figure out where we are being loaded from
    if $LOADED_FEATURES.include?("spec/spec_helper.rb")
      begin
        raise "foo"
      rescue => e
        puts %{
  ===================================================
  It looks like spec_helper.rb has been loaded
  multiple times. Normalize the require to:

      require "spec/spec_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n\t")}
  ===================================================
    }
      end
    end
  end

  def self.maybe_spork
    begin
      require 'rubygems'
      require 'spork'
    rescue LoadError => e
      unless $spork_message_shown
        puts %{
  ===================================================
  You can skip the Rails startup time during a spec
  run by using Spork. It will be faster if you are
  running a few tests (but slower if you are running
  all of them, due to DRB overhead).
    
      sudo gem install spork
      spork
      spec --drb spec/foo_spec.rb
      
  Just install the gem to make this message go away.
  If you are on Snow Leopard, you will also need to
  upgrade rspec to (1.2.9) to avoid a SocketError.
  The --drb has been added to spec.opts, so you don't
  even need that.
  ===================================================
    }
      end
      $spork_message_shown = true
      
      class Spork
        def self.prefork ; yield ; end
        def self.each_run ; yield ; end
      end
    end
  end

end
