module ApplicationHelper

    def get_accounts_total
        Account.find(:all).collect{|a| a.value_last.to_money(a.currency.name).exchange_to("EUR") || 0}.sum
    end
end
