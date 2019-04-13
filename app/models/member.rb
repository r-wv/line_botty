class Member < ApplicationRecord

    def find_name(num)
        member = Member.find(num)
        if member
          member.name
        else
          nil
        end
    end

    def find_number()
    end

end
