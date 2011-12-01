module DatatablesRails
    module Out
        class << self
         def javascript(id, opts, source, cols)
            dt_opts = []
            dt_opts << "'bProcessing': true" if opts.has_key?('processing')
            dt_opts << "'bJQueryUI': true" if opts.has_key?('jqueryui')
            dt_opts << "'bPaginate': true" if opts.has_key?('paginate')
            dt_opts << "'sAjaxSource': '#{source}'"
            columns = []
            cols.each do |col|
              columns << "{'mDataProp' : '#{col}'}"
            end
            dt_opts << "'aoColumns': [ #{columns.join(',')} ]"
           
            html = []
            html << "<script>"
            html << "$(document).ready(function()  { "
            html << "$('##{id}').dataTable( { #{dt_opts.join(',')} } );"
            html << "});"
            html << "</script>"
            return html.join
          end
        end
    end
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

