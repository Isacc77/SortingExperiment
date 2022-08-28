package main

import (
	"bytes"
	"fmt"
	"go_code/A1/RationalType"
	"math"
	"math/rand"
	"time"
)

// This var is for AVG testing. it controls the AVG time spending accuracy
const AVGTESTINGTIMES = 10
const CHAR = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

// Insertion Sort part 1
func InsertionSortInt(items []int) []int {
	var n = len(items)
	for i := 1; i < n; i++ {
		j := i
		for j > 0 {
			if items[j-1] > items[j] {
				items[j-1], items[j] = items[j], items[j-1]
			}
			j = j - 1
		}
	}
	return items
}

func InsertionSortString(items []string) []string {
	var n = len(items)
	for i := 1; i < n; i++ {
		j := i
		for j > 0 {
			if items[j-1] > items[j] {
				items[j-1], items[j] = items[j], items[j-1]
			}
			j = j - 1
		}
	}
	return items
}

func InsertionSortRationalNum(items []RationalType.Rationalizer) []RationalType.Rationalizer {
	var n = len(items)
	for i := 1; i < n; i++ {
		j := i
		for j > 0 {
			if items[j].LessThan(items[j-1]) {
				items[j-1], items[j] = items[j], items[j-1]
			}
			j = j - 1
		}
	}
	return items
}

// GenerateSlice part 2
// random seed range:  	-2^15 to 2^15 -1
func IntGenerateSlice(size int) []int {
	slice := make([]int, size, size)
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < size; i++ {
		slice[i] = (rand.Intn(int(math.Pow(2, 15))) - rand.Intn(int(math.Pow(2, 15))))
	}
	return slice
}

func StringGenerateSlice(size int) []string {
	slice := make([]string, size, size)
	rand.NewSource(time.Now().UnixNano())
	for k := 0; k < size; k++ {
		var s bytes.Buffer
		for i := 0; i < 5; i++ {
			s.WriteByte(CHAR[rand.Int63()%int64(len(CHAR))])
		}
		slice[k] = s.String()
	}
	return slice
}

//range from -256 to 255
func RationalNumGenerateSlice(size int) []RationalType.Rationalizer {
	slice := []RationalType.Rationalizer{}
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < size; i++ {
		Num := (rand.Intn(int(math.Pow(2, 15))) - rand.Intn(int(math.Pow(2, 15))))
		Denom := (rand.Intn(int(math.Pow(2, 15))) - rand.Intn(int(math.Pow(2, 15))))
		r, err := RationalType.MakeRational(Num, Denom)
		if err == nil {
			slice = append(slice, r)
		} else {
			i--
		}
	}
	return slice
}

// CalCost part 3
func IntCalCost(N int) {
	list := IntGenerateSlice(N)
	start := time.Now()
	InsertionSortInt(list)
	cost := time.Since(start)
	fmt.Printf("N = %v, cost = %v ", N, cost.Microseconds())
}

func StringCalCost(N int) {
	list := StringGenerateSlice(N)
	start := time.Now()
	InsertionSortString(list)
	cost := time.Since(start)
	fmt.Printf("N = %v, cost = %v ", N, cost.Microseconds())
}

func RationalNumCalCost(N int) {
	list := RationalNumGenerateSlice(N)
	start := time.Now()
	InsertionSortRationalNum(list)
	cost := time.Since(start)
	fmt.Printf("N = %v, cost = %v ", N, cost.Microseconds())
}

// calulate avg part 4
func IntAvgCost(N int) {
	var sum time.Duration
	for i := 0; i < AVGTESTINGTIMES; i++ {
		list := IntGenerateSlice(N)
		start := time.Now()
		InsertionSortInt(list)
		cost := time.Since(start)
		// fmt.Printf(" Sum: %v, cost: %v \n", sum, cost)
		sum += cost
	}
	avg := sum / AVGTESTINGTIMES
	fmt.Printf(" Sum: %v, Avg: %v \n", sum.Microseconds(), avg.Microseconds())
}

func StringAvgCost(N int) {
	var sum time.Duration
	for i := 0; i < AVGTESTINGTIMES; i++ {
		list := StringGenerateSlice(N)
		start := time.Now()
		InsertionSortString(list)
		cost := time.Since(start)
		// fmt.Printf(" Sum: %v, cost: %v \n", sum, cost)
		sum += cost
	}
	avg := sum / AVGTESTINGTIMES
	fmt.Printf(" Sum: %v, Avg: %v \n", sum, avg.Microseconds())
}

func RationalNumAvgCost(N int) {
	var sum time.Duration
	for i := 0; i < AVGTESTINGTIMES; i++ {
		list := RationalNumGenerateSlice(N)
		start := time.Now()
		InsertionSortRationalNum(list)
		cost := time.Since(start)
		// fmt.Printf(" Sum: %v, cost: %v \n", sum, cost)
		sum += cost
	}
	avg := sum / AVGTESTINGTIMES
	fmt.Printf(" Sum: %v, Avg: %v \n", sum, avg.Microseconds())
}

// Testing part 5
func IntTest() {
	fmt.Println("Int test")
	for i := 1000; i <= 10000; i += 1000 {
		IntCalCost(i)
		IntAvgCost(i)
	}
}

func StringTest() {
	fmt.Println("String test")
	for i := 1000; i <= 10000; i += 1000 {
		StringCalCost(i)
		StringAvgCost(i)
	}
}

func RationalNumTest() {
	fmt.Println("RationalNum test")
	for i := 1000; i <= 10000; i += 1000 {
		RationalNumCalCost(i)
		RationalNumAvgCost(i)
	}
}

func main() {
	//testing rational number
	RationalType.TestRationalNum()

	// 10 list and avg time test
	IntTest()
	StringTest()
	RationalNumTest()

	///////////////////////////////////////////////////////////////////
	// start := time.Now()
	// time.Sleep(time.Second * 1)
	// cost := time.Since(start)
	// fmt.Println(cost)
	// fmt.Println(cost.Microseconds())
}

// go run LinearInsertionSort.go
