module ApplicationHelper
    def draw_button(type,path)
        title = ""
        class_type = "btn btn-sm "
        text = ""
        case type
            when "back"
                title = "Back"
                text = "Back"
                class_type += "btn-danger"
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
        return link_to text, path, :title =>title, :class=>class_type
    end

    def print_amount(amount,currency)
        m = Money.new(amount*100,currency)
        return humanized_money_with_symbol m
    end
end
