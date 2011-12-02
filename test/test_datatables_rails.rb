require 'test/unit'
require 'datatables_rails'

class DatatablesRailsTest < Test::Unit::TestCase
  
  def test_javascript_with_jquery_paginate_process
    assert_equal DatatablesRails::Out.javascript("datatables", {:process => true, :jqueryui => true, :paginate => true}, "foobar.json", ["edit", "full_name"]), 
        "<script>$(document).ready(function()  { $('#datatables').dataTable( { 'bProcessing':true,'bJQueryUI':true,'bPaginate':true,'sAjaxSource': 'foobar.json','aoColumns': [ {'mDataProp' : 'edit'},{'mDataProp' : 'full_name'} ] } );});</script>"
  end

  def test_javascript_with_autowidth_defer_render_info_paginate
     assert_equal DatatablesRails::Out.javascript("datatables", {:autowidth => true, :defer_render => true, :info => true, :paginate => true}, "foobar.json", ["edit", "full_name"]), 
        "<script>$(document).ready(function()  { $('#datatables').dataTable( { 'bAutoWidth':true,'bDeferRender':true,'bInfo':true,'bPaginate':true,'sAjaxSource': 'foobar.json','aoColumns': [ {'mDataProp' : 'edit'},{'mDataProp' : 'full_name'} ] } );});</script>"
  end

end
