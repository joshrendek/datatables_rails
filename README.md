# Datatables Rails

# Example use in the controller
    json = DatatablesRails::Structify.new(User.all)
    render :json => json.struct

# Example use in the view
    DatatablesRails::Out.javascript "datatables", {:process => true, :jqueryui => true, :paginate => true}, "foobar.json", ["edit", "full_name"]

# Formatting the result and adding extra things (like links, or formatting currency)
    json = DatatablesRails::Structify.new(User.all)
    json.formatter do |u|
        u['edit'] = "<a href='#{edit_user_path(u['id'])}'>Edit</a>"
        u['balance'] = number_to_currency(u['balance'])
    end

# Using server side processing
The best way to do this is just build contiously ontop of an AR relation/object. There might be a more effecient way to do this, but this works. The only assumption is that you're using will_paginate but this could easily be adapated to something else (Like Kaminari).

    Fields = ["fields", "you", "want", "to", "display"]
    page = 1
    page = params[:iDisplayStart].to_i/10+1 if params[:iDisplayStart]
    e = ModelName
    total_record_size = 0
    display_length = 10
    if params[:iDisplayLength].to_i > 10
      display_length = params[:iDisplayLength].to_i
    end

    if params[:iSortCol_0].to_i != 0
      sort_column = DatatableFields[params[:iSortCol_0].to_i]
      sort_direction = params[:sSortDir_0]
      e = e.order("#{sort_column} #{sort_direction}")
    end

    if params[:sSearch] != "" && !params[:sSearch].nil?
      search = Fields.collect{|d| "#{d} LIKE '%#{params[:sSearch]}%'" }.compact.join(' OR ')
      e = e.where(search)
      total_record_size = e.count
      e = e.paginate(:page => page, :per_page => display_length)
    else
      total_record_size = e.count
      e = e.paginate(:page => page, :per_page => display_length)
    end

    json = DatatablesRails::Structify.new(e)
    json_struct = json.struct
    json_struct["iTotalRecords"] = total_record_size
    json_struct["iTotalDisplayRecords"] = total_record_size
    json_struct["sEcho"] = params[:sEcho]
    render :json => json_struct

# Building it
    gem build datatables_rails.gemspec

# Forking it
Feel free to fork this and make any additions, just make sure to run the tests.

You can run all the tests by just calling rake:

    rake
