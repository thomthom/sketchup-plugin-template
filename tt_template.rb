#-------------------------------------------------------------------------------
#
# Thomas Thomassen
# thomas[at]thomthom[dot]net
#
#-------------------------------------------------------------------------------

require 'sketchup.rb'
begin
  require 'TT_Lib2/core.rb'
rescue LoadError => e
  timer = UI.start_timer( 0, false ) {
    UI.stop_timer( timer )
    filename = File.basename( __FILE__ )
    message = "#{filename} require TT_Lib� to be installed.\n"
    message << "\n"
    message << "Would you like to open a webpage where you can download TT_Lib�?"
    result = UI.messagebox( message, MB_YESNO )
    if result == 6 # YES
      UI.openURL( 'http://www.thomthom.net/software/tt_lib2/' )
    end
  }
end


#-------------------------------------------------------------------------------

if defined?( TT::Lib ) && TT::Lib.compatible?( '2.7.0', 'Untitled Plugin' )

module TT::Plugins::Template
  
  
  ### CONSTANTS ### ------------------------------------------------------------
  
  # Plugin information
  PLUGIN_ID       = 'TT_Untitled'.freeze
  PLUGIN_NAME     = 'Untitled Plugin'.freeze
  PLUGIN_VERSION  = TT::Version.new(1,0,0).freeze
  
  # Version information
  RELEASE_DATE    = '21 Oct 12'.freeze
  
  # Resource paths
  PATH_ROOT   = File.dirname( __FILE__ ).freeze
  PATH        = File.join( PATH_ROOT, 'TT_Plugin' ).freeze
  
  
  ### VARIABLES ### ------------------------------------------------------------
  
  @module_variable = 'Hello World'
  
  
  ### MENU & TOOLBARS ### ------------------------------------------------------
  
  unless file_loaded?( __FILE__ )
    # Menus
    #m = TT.menu( 'Plugins' )
    #m.add_item( 'Hello World' ) { puts 'Hello World' }
    
    # Context menu
    #UI.add_context_menu_handler { |context_menu|
    #  model = Sketchup.active_model
    #  selection = model.selection
    #  # ...
    #}
    
    # Toolbar
    #toolbar = UI::Toolbar.new( PLUGIN_NAME )
    #toolbar.add_item( ... )
    #if toolbar.get_last_state == TB_VISIBLE
    #  toolbar.restore
    #  UI.start_timer( 0.1, false ) { toolbar.restore } # SU bug 2902434
    #end
  end 
  
  
  ### LIB FREDO UPDATER ### ----------------------------------------------------
  
  def self.register_plugin_for_LibFredo6
    {   
      :name => PLUGIN_NAME,
      :author => 'thomthom',
      :version => PLUGIN_VERSION.to_s,
      :date => RELEASE_DATE,   
      :description => 'Lorem Ipsum',
      :link_info => 'http://forums.sketchucation.com/viewtopic.php?f=0&t=0'
    }
  end
  
  
  ### MAIN SCRIPT ### ----------------------------------------------------------
  
  # @param [Object] bar
  #
  # @return [String]
  # @since 1.0.0
  def self.foo( bar )
    bar.to_s
  end

  
  ### DEBUG ### ----------------------------------------------------------------
  
  # @note Debug method to reload the plugin.
  #
  # @example
  #   TT::Plugins::Template.reload
  #
  # @param [Boolean] tt_lib Reloads TT_Lib2 if +true+.
  #
  # @return [Integer] Number of files reloaded.
  # @since 1.0.0
  def self.reload( tt_lib = false )
    original_verbose = $VERBOSE
    $VERBOSE = nil
    TT::Lib.reload if tt_lib
    # Core file (this)
    load __FILE__
    # Supporting files
    if defined?( PATH ) && File.exist?( PATH )
      x = Dir.glob( File.join(PATH, '*.{rb,rbs}') ).each { |file|
        load file
      }
      x.length + 1
    else
      1
    end
  ensure
    $VERBOSE = original_verbose
  end

end # module

end # if TT_Lib

#-------------------------------------------------------------------------------

file_loaded( __FILE__ )

#-------------------------------------------------------------------------------