module DatatablesRails
    class Structify 
      attr_accessor :struct
      def initialize(data)
        @struct = {}
        @struct["aaData"] = data.collect{|d| d.attributes }        
      end
      
      def formatter(&block)
        @struct["aaData"].each do |s|
          block.call(s)
        end
      end
  end
end

