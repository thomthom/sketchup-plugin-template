#-------------------------------------------------------------------------------
#
# Thomas Thomassen
# thomas[at]thomthom[dot]net
#
#-------------------------------------------------------------------------------

require 'sketchup.rb'
require 'TT_Lib2/core.rb'

TT::Lib.compatible?('2.6.0', 'Untitled Plugin')

#-------------------------------------------------------------------------------


module TT::Plugins::Template
  
  
  ### CONSTANTS ### ------------------------------------------------------------
  
  # Plugin information
  ID          = 'TT_Untitled'.freeze
  VERSION     = TT::Version.new(1,0,0).freeze
  PLUGIN_NAME = 'Untitled Plugin'.freeze
  
  # Resource paths
  PATH_ROOT   = File.dirname( __FILE__ ).freeze
  PATH        = File.join( PATH_ROOT, 'TT_Plugin' ).freeze
  
  
  ### VARIABLES ### ------------------------------------------------------------
  
  @module_variable = 'Hello World'
  
  
  ### MENU & TOOLBARS ### ------------------------------------------------------
  
  unless file_loaded?( File.basename(__FILE__) )
    # Menus
    #m = TT.menu( 'Plugin' )
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
  # @param [Boolean] tt_lib
  #
  # @return [Integer]
  # @since 1.0.0
  def self.reload( tt_lib = false )
    original_verbose = $VERBOSE
    $VERBOSE = nil
    TT::Lib.reload if tt_lib
    # Core file (this)
    load __FILE__
    # Supporting files
    x = Dir.glob( File.join(PATH, '*.{rb,rbs}') ).each { |file|
      load file
    }
    x.length
  ensure
    $VERBOSE = original_verbose
  end

end # module

#-------------------------------------------------------------------------------

file_loaded( File.basename(__FILE__) )

#-------------------------------------------------------------------------------