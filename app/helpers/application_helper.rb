module ApplicationHelper
    def draw_button(type,path,status="")
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
                class_type += "btn-success bi-search"
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
                class_type += " bi-pencil-square"
            when "create"
                title = "Create movement"
                class_type += "btn-info bi-plus-lg"
            when "destroy"
                class_type += "btn-danger bi-trash3-fill"
                return link_to "", path, method: :delete, data: { confirm: 'Are you sure?' }, :title =>"Destroy", :class=>class_type
            when "graph"
                title = "Show graph"
                class_type += "btn-default bi-bar-chart-line-fill"

        end
        return link_to text, path, :title =>title, :class=>class_type
    end

    # return money from amount
    def return_money(amount,currency)
      return Money.new(amount*100,currency)
    end

    # convert money to default currency
    def convert_amount(m)
      return  m.exchange_to(Money.default_currency)
    end

    def print_amount(total)
      humanized_money_with_symbol total
    end

    def convert_ma(ma)
      unless params[:controller] != 'movements' and params[:controller] != 'mtypes'
        convert_amount(get_amount(ma))
      else
        get_amount(ma)
      end
    end

    # print converted amount
    def print_cma(ma)
      humanized_money_with_symbol convert_amount(get_amount(ma))
    end

    def get_amount(ma,account_amount=0)
      if ma.class.name == 'Account'
        m = return_money(ma.amount,ma.currency)
      else
        if account_amount == 1
          m = return_money(ma.account_amount,ma.account.currency)
        else
          m = return_money(ma.amount,ma.account.currency)
        end
      end
      return m
    end

    # print movement.amount or account.amount
    def print_ma(ma,account_amount=0)
      humanized_money_with_symbol get_amount(ma,account_amount)
    end

end
