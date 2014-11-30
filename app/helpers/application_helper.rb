module ApplicationHelper

    def draw_button(type,path)
        case type
            when "show"
                return link_to "", path, :title =>"Show", :class=>"btn btn-success btn-sm glyphicon glyphicon-search"
            when "edit"
                return link_to "", path, :title =>"Edit", :class=>"btn btn-warning btn-sm glyphicon glyphicon-edit"
            when "destroy"
                return link_to "", path, method: :delete, data: { confirm: 'Are you sure?' }, :title =>"Destroy", :class=>"btn btn-danger btn-sm glyphicon glyphicon-remove"

        end
    end
end
