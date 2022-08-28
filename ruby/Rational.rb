class MyRational
    include Comparable
    attr_reader :numerator, :denominator
    
    #part 1
    def initialize(numerator, denominator)
        begin
            numerator / denominator  
        rescue => error 
            puts "raise 'MyRational: denominator cannot be 0'"
        else  
            @numerator = numerator
            @denominator = denominator
        end 
    end

    #part 2
    def num
        return @numerator
    end 

    #part 3
    def denom 
        return @denominator
    end 

    #part 4 
    def pair 

        return [@numerator, @denominator]

    end

    #part 5
    def to_s
        "(#{@numerator},#{@denominator})"
    end

    #part 6 
    def to_f 
        return @numerator.to_f/@denominator.to_f
    end 

    #part 7
    def == (other)
        other = other.to_lowest_terms
        return @numerator == other.num && @denominator == other.denom
    end 

    #part 8 
    def <=>(other)
        self.to_f <=> other.to_f
    end

    #part 9 
    def int?
        return num % denom == 0
    end 

    #part 10
    def +(other)
        self.class.new(@numerator * other.denominator + other.numerator * @denominator, @denominator * other.denominator).to_lowest_terms
    end 

    #part 11 
    def *(other)
        self.class.new(@numerator * other.numerator, @denominator * other.denominator).to_lowest_terms
    end 

    #part 12 
    def /(other)
        self * other.invert
    end 

    #part 13 
    def invert 
        begin
            denominator/numerator
        rescue => exception
            "raise 'MyRational: denominator cannot be 0'"
        else
            self.class.new(denominator, numerator)
        end
    end

    #part 14 
    def to_lowest_terms
        gcd = gcd(@numerator, @denominator)
        return self.class.new(@numerator/gcd, @denominator/gcd)
    end

    def gcd(num1,num2)
        while num1 % num2 !=0
            temp = num1 % num2
            num1 = num2 
            num2 = temp
        end
        return num2
    end

end


class Integer

    def to_mr()
        return MyRational.new(self, 1)
    end

end

#part15
def harmonicSum(n)

    rationalNum = MyRational.new(1,1)

    for i in(2..n) do
        rationalNum = rationalNum + MyRational.new(1,i)
    end

    return rationalNum
end 

def test(rationalNum)
    print rationalNum
    puts
    print rationalNum.num
    puts
    print rationalNum.denom
    puts
    puts "test pair"
    print rationalNum.pair
    puts
    print rationalNum.pair.class
    puts 
    print rationalNum.to_s
    puts 
    print rationalNum.to_s.class
    puts 
    print rationalNum.to_f
    puts 
    print rationalNum.to_f.class
end


def test2(rationalNum)
    r1 = MyRational.new(5,10)
    r2 = MyRational.new(6,7)
    r3 = MyRational.new(4,6)
    r4 = MyRational.new(7,1)
    r5 = MyRational.new(50,2)
    r6 = MyRational.new(-2,5)
    r7 = MyRational.new(0,3)
    r8 = MyRational.new(-1,-3)

    puts "---test ==---"
    puts rationalNum == r1
    puts rationalNum == r2
    puts rationalNum == r3
    puts "---test<=>---"
    puts rationalNum <=> r1
    puts rationalNum <=> r2
    puts rationalNum <=> r3
    puts "---int?---"
    puts rationalNum.int?
    puts r1.int?
    puts r4.int?
    puts r5.int?
    puts "---test +---"
    puts rationalNum + r1 # 2/3+ 5/10
    puts rationalNum.+ r2 # 2/3+ 6/7
    puts rationalNum.+ r3 # 2/3+ 4/6
    puts rationalNum.+ r4 # 2/3+ 7/1
    puts rationalNum.+ r5 # 2/3+ 25
    puts rationalNum.+ r6 # 2/3+ -2/5
    puts rationalNum.+ r7 # 2/3+  0/3
    puts rationalNum.+ r8 # 2/3+ -1/-3

    puts "test *"
    puts rationalNum * r1
    puts rationalNum * r2
    puts rationalNum * r3
    puts rationalNum * r4
    puts rationalNum * r5
    puts rationalNum * r6
    puts rationalNum * r7
    puts rationalNum * r8
    # 2/3* 5/10 = 1/3
    # 2/3* 6/7 =4/7
    # 2/3* 4/6 = 4/9
    # 2/3* 7/1 =14/3
    # 2/3* 25 = 50/3
    # 2/3* -2/5 = -4/15
    # 2/3*  0/3 = 0
    # 2/3* -1/-3 =2/9

    puts "---test /---"
    puts rationalNum / r1 
    puts rationalNum / r2
    puts rationalNum / r3
    puts rationalNum / r4
    puts rationalNum / r5
    puts rationalNum / r6
    # puts rationalNum / r7
    puts rationalNum / r8
    # 2/3 / 5/10 = 4/3
    # 2/3 / 6/7 = 7/9
    # 2/3 / 4/6 = 1
    # 2/3 / 7/1 = 2/21
    # 2/3 / 25 = 2/75
    # 2/3 / -2/5 = -5/3
    # 2/3 /  0/3 = error
    # 2/3 / -1/-3 = 2
end

def testHarmonicSum
    for i in 1..10 do
        puts harmonicSum(i)
    end
end
     

# main code & testing 
r = MyRational.new(2,3)
r1 = MyRational.new(5,0)
r2 = MyRational.new(0,1)

test(r)
test2(r)
testHarmonicSum

r = 5.to_mr()
test(r)
test2(r)
