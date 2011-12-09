module ApplicationHelper

    def get_accounts_total
        Account.find(:all).collect{|a| a.amount.to_money(a.currency.name).exchange_to("EUR") || 0}.sum
    end

    def draw_button(classes,letter,path,title)
      return "<span class='#{classes}'>#{link_to letter, path, :title => title}</span>".html_safe
    end
end
