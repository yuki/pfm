#!/usr/bin/ruby

cur = Currency.new
cur.name = "EUR"
cur.symbol = "€"
cur.save!


l = ["party","bla","as","qaw","zxc","poi","987"]

l.each do |mt|
    mov = Mtype.new
    mov.name = mt
    mov.save!
    puts mov.inspect
end

accoun = ["cash","bbk","account"]

accoun.each { |ac|
    a = Account.new
    a.name = ac
    a.amount = 10000
    a.currency = cur
    a.save!

    (1..12).each { |i|
        [1,10,21,28].each {|m|
            d = "2011-#{i}-#{m}".to_datetime
            mt = Mtype.find(rand(7)+1)
            m = Movement.new
            m.mtype = mt
            m.account = a
            m.amount = rand(40) +1 
            if rand(2).zero?
                m.amount = 0 - m.amount
            end                                    
            m.mdate = d
            m.vdate = d
            m.save!
            puts m.inspect
        }
    }

}

