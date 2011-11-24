# Datatables Rails

# Example use
    json = DatatablesRails::Structify.new(User.all)
    render :json => json.struct

## Formatting the result and adding extra things (like links)
    json = DatatablesRails::Structify.new(User.all)
    json.formatter do |u|
        u['edit'] = "<a href='#{edit_user_path(u['id'])}'>Edit</a>"
    end
