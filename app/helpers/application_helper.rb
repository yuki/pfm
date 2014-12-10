module ApplicationHelper
    def draw_button(type,path,status="")
        title = ""
        class_type = "btn btn-xs "
        text = ""
        case type
            when "back"
                title = "Back"
                text = "Back"
                class_type += "btn-danger"
            when "show"
                title = "Show"
                class_type += "btn-success glyphicon glyphicon-search"
            when "showt"
                title = "Show"
                text = "Show"
                class_type += "btn-success"
            when "edit"
                title = "Edit"
                if status != ""
                  status = "btn-"+status
                else
                  status = "btn-warning"
                end
                class_type += status
                class_type += " glyphicon glyphicon-edit"
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

    def convert_amount(amount,currency)
        m = Money.new(amount*100,currency)
        m = m.exchange_to(Money.default_currency)
        return  m
    end

end
