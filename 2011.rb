#!/usr/bin/ruby

#a = Account.new
#a.name = "iii"
#a.amount = 1000
#a.currency = Currency.find(1)
#a.save!
a = Account.find(11)

File.open("2011.csv").each { |line|
    unless line =~ /^$/
        t = line.split(',')
        if t[4] != ".00" and t[4] != ""
            #puts line
            dt = t[2].split('/')
            #puts "#{dt[2]}-#{dt[1]}-#{dt[0]}"
            d = "20#{dt[2]}-#{dt[1]}-#{dt[0]}".to_datetime
            puts "#{d.to_default_s} - #{t[3]} - #{t[4]}"
            unless Mtype.find_by_name(t[3])
              Mtype.new(:name => "#{t[3].to_s}").save!
            end
            mt = Mtype.find_by_name(t[3]) 
            puts mt.inspect
            m = Movement.new
            m.mtype = mt
            m.account = a
            #m.name = t[3]
            m.amount = t[4].to_f
            m.mdate = d
            m.vdate = d
            m.save!
            puts m.inspect
        end
    end
}
