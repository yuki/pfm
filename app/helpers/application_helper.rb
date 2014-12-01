module ApplicationHelper
    def draw_button(type,path)
        title = ""
        class_type = "btn btn-sm "
        case type
            when "show"
                title = "Show"
                class_type += "btn-success glyphicon glyphicon-search"
            when "edit"
                title = "Edit"
                class_type += "btn-warning glyphicon glyphicon-edit"
            when "create"
                title = "Create movement"
                class_type += "btn-info glyphicon glyphicon-plus"
            when "destroy"
                class_type += "btn-danger glyphicon glyphicon-remove"
                return link_to "", path, method: :delete, data: { confirm: 'Are you sure?' }, :title =>"Destroy", :class=>class_type
        end
        return link_to "", path, :title =>title, :class=>class_type
    end

    def print_amount(amount,currency)
        Money::Currency.find(currency)
        return "#{amount} #{currency}"
    end
end
