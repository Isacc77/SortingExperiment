package RationalType

import (
	"errors"
	"fmt"
)

type Floater64 interface {
	// Converts a value to an equivalent float64.
	toFloat64() float64
}

type Stringer interface {
	String() string
}

type Rationalizer interface {

	// 5. Rationalizers implement the standard Stringer interface.
	fmt.Stringer

	// 6. Rationalizers implement the Floater64 interface.
	Floater64

	// 2. Returns the numerator.
	Numerator() int

	// 3. Returns the denominator.
	Denominator() int

	// 4. Returns the numerator, denominator.
	Split() (int, int)

	// 7. Returns true iff this value equals other.
	Equal(other Rationalizer) bool

	// 8. Returns true iff this value is less than other.
	LessThan(other Rationalizer) bool

	// 9. Returns true iff the value equal an integer.
	IsInt() bool

	// 10. Returns the sum of this value with other.
	Add(other Rationalizer) Rationalizer

	// 11. Returns the product of this value with other.
	Multiply(other Rationalizer) Rationalizer

	// 12. Returns the quotient of this value with other. The error is nil
	// if its is successful, and a non-nil if it cannot be divided.
	Divide(other Rationalizer) (Rationalizer, error)

	// 13. Returns the reciprocal. The error is nil if it is successful,
	// and non-nil if it cannot be inverted.
	Invert() (Rationalizer, error)

	// 14. Returns an equal value in lowest terms.
	ToLowestTerms() Rationalizer
} // Rationalizer interface

////////////////////////////////////////////////////////////////////////////////////
type RationalNum struct {
	numeratorVar   int
	denominatorVar int
}

// 2. Returns the numerator.
func (n RationalNum) Numerator() int {
	return n.numeratorVar
}

// 3. Returns the denominator.
func (n RationalNum) Denominator() int {
	return n.denominatorVar
}

// 4. Returns the numerator, denominator.
func (n RationalNum) Split() (int, int) {
	return n.numeratorVar, n.denominatorVar
}

//5. Rationalizers implement the standard Stringer interface.
func (n RationalNum) String() string {
	return fmt.Sprintf("(%v,%v)", n.numeratorVar, n.denominatorVar)
}

// 6. Rationalizers implement the Floater64 interface.
func (n RationalNum) toFloat64() float64 {
	return float64(n.numeratorVar) / float64(n.denominatorVar)
}

// 7. Returns true iff this value equals other.
func (n RationalNum) Equal(other Rationalizer) bool {
	gcd_r := gcd(n.denominatorVar, n.numeratorVar)
	gcd_other := gcd(other.Denominator(), other.Numerator())
	return n.numeratorVar/gcd_r == other.Numerator()/gcd_other && n.denominatorVar/gcd_r == other.Denominator()/gcd_other
}

// 8. Returns true iff this value is less than other.
func (n RationalNum) LessThan(other Rationalizer) bool {
	return n.toFloat64() < other.toFloat64()
}

// 9. Returns true iff the value equal an integer.
func (n RationalNum) IsInt() bool {
	return n.numeratorVar%n.denominatorVar == 0
}

// 10. Returns the sum of this value with other.
func (n RationalNum) Add(other Rationalizer) Rationalizer {
	if n.denominatorVar == other.Denominator() {
		return RationalNum{numeratorVar: n.numeratorVar + other.Numerator(),
			denominatorVar: n.denominatorVar}
	} else {
		return RationalNum{numeratorVar: n.numeratorVar*other.Denominator() + other.Numerator()*n.denominatorVar,
			denominatorVar: n.denominatorVar * other.Denominator()}
	}
}

// 11. Returns the product of this value with other.
func (n RationalNum) Multiply(other Rationalizer) Rationalizer {
	if n.numeratorVar == 0 || other.Numerator() == 0 {
		return RationalNum{numeratorVar: 0,
			denominatorVar: n.denominatorVar * other.Denominator()}
	}
	return RationalNum{numeratorVar: n.numeratorVar * other.Numerator(),
		denominatorVar: n.denominatorVar * other.Denominator()}
}

// 12. Returns the quotient of this value with other. The error is nil
// if its is successful, and a non-nil if it cannot be divided.
// Divide(other Rationalizer) (Rationalizer, error)
func (n RationalNum) Divide(other Rationalizer) (Rationalizer, error) {
	err := errors.New("Cannot proceed, the Denominator is zero.")
	OtherInverted, err := other.Invert()
	if err != nil {
		return RationalNum{}, err
	}
	return n.Multiply(OtherInverted), nil
}

// 13. Returns the reciprocal. The error is nil if it is successful,
// and non-nil if it cannot be inverted.
func (n RationalNum) Invert() (Rationalizer, error) {
	if n.numeratorVar == 0 {
		return RationalNum{0, 0}, errors.New("Cannot proceed because after inverted the denominator is zero ")
	}
	return RationalNum{numeratorVar: n.denominatorVar, denominatorVar: n.numeratorVar}.ToLowestTerms(), nil
}

// 14. Returns an equal value in lowest terms.
func (n RationalNum) ToLowestTerms() Rationalizer {
	gcd := gcd(n.numeratorVar, n.denominatorVar)
	return RationalNum{numeratorVar: n.numeratorVar / gcd, denominatorVar: n.denominatorVar / gcd}
}

//function

//1. Make a rational
func MakeRational(n, d int) (RationalNum, error) {
	if d == 0 {
		errMsg :=
			("Cannot proceed, the Denominator is zero.")
		return RationalNum{0, 0}, errors.New(errMsg)
	} else {
		return RationalNum{numeratorVar: n,
			denominatorVar: d}, nil
	}
}

func gcd(num1, num2 int) int {
	for num1%num2 != 0 {
		temp := num1 % num2
		num1 = num2
		num2 = temp
	}
	return num2
}

//15.Harmonic sum Given an integer , return a rational equal to
func HarmonicSum(n int) Rationalizer {
	Rationals := []Rationalizer{RationalNum{1, 1}}
	for i := 2; i <= n; i++ {
		Rationals[0] = Rationals[0].Add(RationalNum{1, i})
	}
	return Rationals[0]
}

//test 2-4
func test2_4(n RationalNum) {
	fmt.Println(n.Numerator())
	fmt.Println(n.Denominator())
	fmt.Println(n.Split())
	fmt.Println(n.Numerator())
}

func TestRationalNum() {

	fmt.Println("test 1")
	r, err := MakeRational(1, 3)
	// a := RationalNum{3,4}
	// rationalInterfece = &a
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(r, err)
	fmt.Println("test 2-4")
	fmt.Println("Example 1")
	test2_4(r)
	fmt.Println("Example 2")
	test2_4(RationalNum{numeratorVar: 1, denominatorVar: 8})
	fmt.Println("test 5-6")
	fmt.Println(r.String())
	fmt.Println(r.toFloat64())
	fmt.Println("test 7-8")
	r2, err1 := MakeRational(5, 3)
	if err1 != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(r.Equal(r2))
	fmt.Println(r.LessThan(r2))
	fmt.Println(r.Equal(RationalNum{numeratorVar: 1, denominatorVar: 3}))
	fmt.Println(r.Equal(RationalNum{numeratorVar: 2, denominatorVar: 6}))
	fmt.Println(r.LessThan(RationalNum{numeratorVar: 1, denominatorVar: 8}))
	fmt.Println("test 9")
	fmt.Println(r.IsInt())
	fmt.Println(RationalNum{numeratorVar: 4, denominatorVar: 2})
	fmt.Println("test 10")
	fmt.Println(r.Split())
	fmt.Println(r.Add(r2))
	fmt.Println(r.Add(RationalNum{numeratorVar: 4, denominatorVar: 2}))
	fmt.Println("test 11")
	fmt.Println(r.Multiply(r2))
	fmt.Println(r.Multiply(RationalNum{numeratorVar: 4, denominatorVar: 2}))
	fmt.Println("test 12")
	fmt.Println(r.Divide(r2))
	fmt.Println(r.Divide(RationalNum{numeratorVar: 4, denominatorVar: 2}))
	fmt.Println("test 15")
	fmt.Println(HarmonicSum(1))
	fmt.Println(HarmonicSum(2))
	fmt.Println(HarmonicSum(3))
	fmt.Println(HarmonicSum(4))
	fmt.Println(HarmonicSum(5))
	temp := HarmonicSum(5)
	fmt.Println(temp.toFloat64())
}
