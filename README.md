# Datatables Rails

# Example use in the controller
    json = DatatablesRails::Structify.new(User.all)
    render :json => json.struct

# Example use in the view
    DatatablesRails::Out.javascript "datatables", {:process => true, :jqueryui => true, :paginate => true}, "foobar.json", ["edit", "full_name"]

# Formatting the result and adding extra things (like links)
    json = DatatablesRails::Structify.new(User.all)
    json.formatter do |u|
        u['edit'] = "<a href='#{edit_user_path(u['id'])}'>Edit</a>"
    end

# Forking it
Feel free to fork this and make any additions, just make sure to run the tests.

You can run all the tests by just calling rake:

    rake
