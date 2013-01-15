#!/usr/bin/env ruby

require 'ostruct'

    class ConfigFile
      attr_accessor :current_section
      attr_reader :inrecs
      attr_reader :outrecs
      
      class InrecError < SyntaxError; end
      class OutrecError < SyntaxError; end
      
      def initialize filename
        @current_section = nil
        
        begin
          file = File.read( filename ).split( /\n/ ).map(&:strip)
        rescue Exception => e
          raise "Failed to read '#{filename}': #{e.message}"
        end
        
        @sections = Hash.new
        @inrecs   = []
        @outrecs  = []
        @infiles  = { :trans => [],  :resync => nil }
        @outfiles = { :trans => nil, :resync => nil }
        
        section = 'UNDEFINED'
        
        #begin 
          file.each_with_index do |line, idx|
            next if line =~ /^[*#]/ || line.empty?
            @@line_number = idx + 1
            
            # New section header?
            if line =~ /^\[/
              section = line.gsub( /\[(.*?)\].*/, '\1' ).downcase
              
              case section
                when /^record /
                  @outrecs << PreprocOutrec.new( section.split(' ', 2).last )
                when /^inrec /
                  @inrecs << PreprocInrec.new( section.split(' ', 2).last )
                else
                  section = section.to_sym
              end
              
              next
            end
            
            # Parse key => value pair
            name, value = line.split( /=/, 2 ).map(&:strip)
            @sections[section] ||= Hash.new
            
            # Store section keys and values
            case section.to_s
              when /^general/
                case name.downcase
                  when /^file(\d\d)/
                    @infiles[:trans] << parse_file_config( name, value )
                    @infiles[:trans].last.number = $1.to_i
                  when /^outfile/ 
                    @outfiles[:trans] = parse_file_config( name, value )
                  when /^inifile_in/
                    @infiles[:resync] = parse_file_config( name, value )
                    @infiles[:resync].number = 'ini'
                  when /^inifile_out/
                    @outfiles[:resync] = parse_file_config( name, value )
                end
              when /^record /
                @outrecs.last.add_field name, value
              when /^inrec /
                @inrecs.last.add_field name, value, @outrecs.find { |outrec| outrec.name == @inrecs.last.map_to }
            end

            @sections[section][name.downcase.to_sym] = value
          end
        
          @outrecs.reverse!
          @inrecs.reverse!
          
          return self
        
        #rescue Exception => e
        #  raise "[#{e.class}] #{filename} line #{@@line_number}: #{e.message}"
        #end

      end
      
      
      # Return a hash of key => attrs pairs for the first INREC that matches the line
      def find_inrecs file_number, line
        preproc_basic = PreprocBasic.new
        
        @inrecs.select { |inrec| 
          if inrec.file_list.include? file_number.to_s
            this_str = line.slice( inrec.id.start, inrec.id.length )
            
            result = preproc_basic.run inrec.id.code, this_str
            
            if result
              log :debug 
              log :debug, inrec.name
              log :debug, "code = #{inrec.id.code}"
              log :debug, "this = #{this_str}"
              log :debug, "result = #{result}"
            end
            
            if result.kind_of? String
              ! result.empty?
            elsif result.kind_of? Numeric
              result.to_i > 0
            else
              result
            end
          end
        }
      end
      
      
      def with section, &block
        yield OpenStruct.new( @sections[section] )
      end
      
      def get section, key = nil
        if key.nil?
          @sections[section.to_sym]
        else
          @sections[section.to_sym][key.to_sym]
        end
      end
      
      def infiles mode
        puts @infiles.inspect
        [ @infiles[mode.to_sym] ].flatten
      end
      
      def outfile mode
        puts @outfiles.inspect
        @outfiles[mode.to_sym]
      end
        
      
      def yesno_to_bool val
        { 'y' => true, 'n' => false }[ val.strip.downcase ]
      end
      
      def parse_file_config key, value
        filename, *flags = value.split(/,/).map(&:strip)
        filename.gsub!( /"/, '' )
        flags.map!(&:downcase)
        OpenStruct.new( {
          :filename => filename,
          :sort     => { 'a' => :ascending, 'd' => :descending, 'n' => false }[ flags[0] ] || false,
          :uniq?    => yesno_to_bool( flags[1] ),
          :compare? => yesno_to_bool( flags[2] ),
        } )
      end
      
    end #class ConfigFile

    class PreprocInrec
      attr_reader :name
      
      class ParseError < SyntaxError; end
      
      def initialize name
        @name = name
        @fields = {}
      end
      
      def add_field name, reform_value, outrec = nil
        case name.to_s.downcase
          when 'id'
            start, length, code = reform_value.split(/,/, 3).map(&:strip)
            start = start.to_i - 1
            
            @fields[:id] = OpenStruct.new( {
              :start  => start.to_i,
              :length => length.to_i,
              :end    => start.to_i + length.to_i - 1,
              :code   => code
            } )
            
          when 'map_to'
            @fields[:map_to] = reform_value.downcase
            
          when 'file_list'
            @fields[:file_list] = reform_value.split(/,/).map(&:strip)
          
          else
            if @fields[:map_to].empty?
              raise ParseError.new "[INREC #{@name.upcase}]: MAP_TO outrec not specified before first field definition"
            end
            
            start, length, fieldname, code = reform_value.split(/,/, 4).map(&:strip)
            start = start.to_i - 1
            
            outfield = outrec.field( fieldname.downcase ) rescue nil
            
            unless outfield
              raise ParseError.new "[INREC #{@name.upcase}]: #{name} could not be mapped to [RECORD #{@fields[:map_to].upcase}]->#{fieldname}, destination not found"
            end
            
            @fields[name.downcase.to_sym] = OpenStruct.new( {
              :start    => start.to_i,
              :length   => length.to_i,
              :end      => start.to_i + length.to_i - 1,
              :outfield => outfield,
              :code     => code
            } )
        end
      end
      
      def id
        @fields[:id]
      end
      
      def map_to
        @fields[:map_to]
      end
      
      def file_list
        @fields[:file_list]
      end

      def field name
        @fields[name.to_sym]
      end
      
      def transform line
        preproc_basic = PreprocBasic.new
        
        outstr = ''
        
        # Weed out meta fields like ID, MAP_TO, and FILE_LIST
        data_fields = @fields.reject { |key, val| key.to_s !~ /^field/ }
        
        # Map all inrec fields from the input line to the output string
        data_fields.each do |infield_name, infield|
          outfield = infield.outfield
          last_col = outfield.start + outfield.length
          
          if last_col > outstr.length
            outstr = outstr.ljust( last_col )
          end
          
          # Can't read data past the end of the input line
          next if infield.start >= line.length
          
          this_str = line.slice( infield.start, infield.length ).strip
          
          # Run transform code
          result = preproc_basic.run infield.code, this_str
          
          #if outfield.name == :case_number
            #log outfield.inspect
            #log this_str, result
          #end
          
          
          
          # Write transformed field to output record
          outstr[ outfield.start .. outfield.end ] = result.to_s.ljust( outfield.length )
        end
        
        return outstr
      end
      
    end #class PreprocInrec


    class PreprocOutrec
      attr_reader :name, :length, :fields
      
      def initialize name
        @name = name
        @length = 0
        @fields = {}
      end
      
      def add_field name, reform_value
        start, length = reform_value.split(/,/).map(&:strip)
        start = start.to_i - 1
        length = length.to_i
        
        if @fields.empty? || start > @fields.values.map(&:start).max
          @length = start + length
        end
        
        @fields[name.downcase.to_sym] = OpenStruct.new( {
          :name   => name.downcase.to_sym,
          :start  => start,
          :length => length,
          :end    => start + length - 1
        } )
      end
      
      def field name
        @fields[name.to_sym]
      end
      
    end #class PreprocOutrec




config = ConfigFile.new 'reform.ini'

config.outrecs.each do |outrec|
  outrec_name = outrec.name.upcase
  outrec_name = 'AN' if outrec_name == 'ALIAS'
  
  puts "--RECORD #{outrec_name}"

  is_first = true

  puts "SELECT"

  # Sort outrec fields by starting position
  outrec_fields = outrec.fields.keys.sort_by { |key| outrec.fields[key].start }.map { |key| outrec.fields[key] }
  
  outrec_fields.each do |field|
    if is_first
      # First outrec field is always the record header
      puts "  '" + outrec_name + "'" + (" " * 49 ) + "AS header"
      is_first = false
    else
      puts "  " + (is_first ? ' ' : ',') + "'" + (is_first ? field.name.to_s.upcase : '') + "'" + (" " * 50 ) + "AS " + field.name.to_s.downcase
    end
  end

  puts "FROM"
  puts "--WHERE"
  puts
end
