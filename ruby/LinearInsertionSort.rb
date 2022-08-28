
# file_name = Rational.rb
require 'F:\ruby\383\A2\Rational.rb'

AVGTESTINGTIMES = 10

def insertion_sort(array)
    for i in 1...(array.length) 
        j = i 
        while j > 0 
            if array[j-1] > array[j]
                temp = array[j]
                array[j] = array[j-1]
                array[j-1] = temp
            else
                break
            end
            j = j - 1 
        end
    end
    return array
end

def insertion_sort_rationalNum(array)
    for i in 1...(array.length) 
        j = i 
        while j > 0 
            if (array[j-1] <=> array[j]) == 1
                temp = array[j]
                array[j] = array[j-1]
                array[j-1] = temp
            else
                break
            end
            j = j - 1 
        end
    end
    return array
end


### Generating data ######
def GeneratingInt(size)
    arr =[]
    size.times do |i|
        arr.push(rand(-2**15..2**15))
    end
    return arr
end

def GeneratingString(size)
    arr =[]
    size.times do |i|
        arr.push(randomString(5))
    end
    return arr
end

def GeneratingRationalNum(size)
    arr = []
    size.times do |i|
        numerator = 0
        denominator = 0
        while denominator == 0 do
            numerator = rand(-2**15..2**15)
            denominator = rand(-2**15..2**15)
        end 
        arr.push(MyRational.new(numerator,denominator))
    end
    return arr
end

def randomString( len )
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    randomString = ""
    1.upto(len) { |i| randomString << chars[rand(chars.size-1)] }
    return randomString
end


### calculate cost 
def IntCalCost (n)
    arr = GeneratingInt(n)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    insertion_sort(arr)
    t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    delta = t2 - t1
    delta_in_microseconds = delta * 1000000
    print "size = #{n}, cost = #{delta_in_microseconds} microseconds, "
end

def StringCalCost (n)
    arr = GeneratingString(n)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    insertion_sort(arr)
    t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    delta = t2 - t1
    delta_in_microseconds = delta * 1000000
    print "size = #{n}, cost = #{delta_in_microseconds} microseconds, "
end

def RationalNumCalCost (n)
    arr = GeneratingRationalNum(n)
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    insertion_sort_rationalNum(arr)
    t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    delta = t2 - t1
    delta_in_microseconds = delta * 1000000
    print "size = #{n}, cost = #{delta_in_microseconds} microseconds, "
end


## calulate avg 
def IntAvgCost(n)
    sum = 0
    AVGTESTINGTIMES.times do |i|
        arr = GeneratingInt(n)
        t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        insertion_sort(arr)
        t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        sum += t2-t1
    end
    avg = sum/AVGTESTINGTIMES
    avg_microseconds = avg * 1000000
    puts "Sum:#{sum} seconds, Avg:#{avg_microseconds} microseconds"
end

def StringAvgCost(n)
    sum = 0
    AVGTESTINGTIMES.times do |i|
        arr = GeneratingString(n)
        t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        insertion_sort(arr)
        t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        sum += t2-t1
    end
    avg = sum/AVGTESTINGTIMES
    avg_microseconds = avg * 1000000
    puts "Sum:#{sum} seconds, Avg:#{avg_microseconds} microseconds"
end  

def RationalNumAvgCost(n)
    sum = 0
    AVGTESTINGTIMES.times do |i|
        arr = GeneratingRationalNum(n)
        t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        insertion_sort_rationalNum(arr)
        t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        sum += t2-t1
    end
    avg = sum/AVGTESTINGTIMES
    avg_microseconds = avg * 1000000
    puts "Sum:#{sum} seconds, Avg:#{avg_microseconds} microseconds"
end  

## Testing part 
def IntTest()
    puts "--- Int testing ---"
    1000.step(10000,1000) do |i|
        IntCalCost(i)
		IntAvgCost(i)
    end
end

def StringTest()
    puts "--- String testing ---"
    1000.step(10000,1000) do |i|
        StringCalCost(i)
		StringAvgCost(i)
    end
end

def RationalNumTest()
    puts "--- RationalNum testing ---"
    1000.step(10000,1000) do |i|
        RationalNumCalCost(i)
        RationalNumAvgCost(i)
    end
end

### main code ###
# list_int = [7,8,5,1,99,2221,33,0,1]
# list_strings = ["abcgr", "kaeee", "hefpp", "asdgr", "abdgr"]
# list_rationalNum = [MyRational.new(1,2), 
#                     MyRational.new(5,3),  
#                     MyRational.new(5,7), 
#                     MyRational.new(15,7), 
#                     MyRational.new(55,7), 
#                     MyRational.new(5,77), 
#                     MyRational.new(1,99)]

## insertion sort test 
# print list_int
# puts 
# print list_strings
# puts 
# print insertion_sort(list_int)
# puts
# print insertion_sort(list_strings)
# puts
# print list_rationalNum
# puts
# print insertion_sort(list_rationalNum)

# test 
IntTest()
StringTest()
RationalNumTest()