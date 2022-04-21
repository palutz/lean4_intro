
theorem and_commutative (p q : Prop) : p ∧ q → q ∧ p :=
  fun hpq : p ∧ q =>
  have hp : p := And.left hpq
  have hq : q := And.right hpq
  show q ∧ p from And.intro hq hp

/- Define -/
def m : Nat := 1
def n : Nat := 0
def f := m + n
def b1 := true
def b2 : Bool := false

/- Check -/
#check m
#check n 
#check f
#check f + 0
#check b1
#check b2

/- Eval -/
#eval b1 && b2