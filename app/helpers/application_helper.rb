module ApplicationHelper

    def get_accounts_total
        Account.find(:all).collect{|a| a.amount.to_money(a.currency.name).exchange_to("EUR") || 0}.sum
    end
end
