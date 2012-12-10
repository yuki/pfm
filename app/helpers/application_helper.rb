module ApplicationHelper

    def get_accounts_total
        number_with_precision(Account.find(:all).collect{|a| a.amount.to_money(a.currency.name).exchange_to("EUR") || 0}.sum, :precision => 2)
    end

    def draw_button(classes,letter,path,title)
      return "<span class='#{classes}'>#{link_to letter, path, :title => title}</span>".html_safe
    end

    def array_to_table(columns,array)
      table = "<table><tbody>"
      i = 0
      array.each do |type|
        table += "\n<tr>" if (i.modulo(columns) == 0)
        cheked = false
        if params.has_key?("mtype") and params["mtype"]["#{type.id}"] == "1"
            checked = true
        end
        table += "\n<td>#{check_box("mtype", type.id, {:checked => checked })} #{label_tag "mtype_#{type.id}", type.name} </td>"
        if i.modulo(columns) == columns-1
          table += "\n</tr>"
        elsif array.last == type
          while i.modulo(columns) < columns-1 do
            i += 1
            table += "\n<td></td>"
          end
          table += "\n</tr>"
        end
        i += 1
      end

      table +="\n</tbody></table>"
      return table.html_safe
    end

    def get_from_date_select(is_month)
      discard_month = false
      discard_month = true if is_month
      text = params[:action] == 'show_year' ? "Year: " : "From: "
      return (text + date_select("get_movements", "from",
                {:end_year => Time.now.year, :discard_day => true, :discard_month => discard_month, :default => @from_month},
                {:onchange => "this.form.submit();" }) ).html_safe
    end

    def get_to_date_select(is_month)
      discard_month = false
      if is_month
        discard_month = true
      end
      return ("To: " + date_select("get_movements", "to",
                {:end_year => Time.now.year, :discard_day => true, :discard_month => discard_month, :default => @to_month},
                {:onchange => "this.form.submit();" }) ).html_safe
    end

    def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render("new_group_movement", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")".html_safe)
    end

    def link_to_show_graphic(name, container)
      link_to_function(name,"show_graphic(\"#{container}\")")
    end

end
