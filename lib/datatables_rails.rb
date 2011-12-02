module DatatablesRails
    module Out
        CUSTOM_MAPPINGS = {:process => "bProcessing", :jqueryui => "bJQueryUI", :paginate => "bPaginate",
                           :autowidth => "bAutoWidth", :defer_render => "bDeferRender",
                           :destroy => "bDestroy", :filter => "bFilter", :info => "bInfo", 
                           :length_change => "bLengthChange", :retrieve => "bRetrieve", 
                           :scroll_collapse => "bScrollCollapse", :scroll_infinite => "bScrollInfinite",
                           :searchable => "bSearchable", :server_side => "bServerSide", 
                           :sort => "bSort", :sortable => "bSortable", :sort_cells_top => "bSortCellsTop",
                           :sort_classes => "bSortClasses", :state_save => "bStateSave", 
                           :use_rendered => "bUseRendered", :visible => "bVisible"                           
        }
        class << self
         def javascript(id, opts, source, cols)
            dt_opts = []
            opts.each do |k,v|
              dt_opts << "'#{CUSTOM_MAPPINGS[k]}':true" if v
            end
            dt_opts << "'sAjaxSource': '#{source}'"
            columns = []
            cols.each do |col|
              columns << "{'mDataProp' : '#{col}'}"
            end
            dt_opts << "'aoColumns': [ #{columns.join(',')} ]"
           
            html = []
            html << "<script>"
            html << "$(document).ready(function()  { "
            html << "var #{id} = $('##{id}').dataTable( { #{dt_opts.join(',')} } );"
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

