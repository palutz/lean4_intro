section addition

/--/  
  inductive nat 
  | zero : nat 
  | S(n : nat) : nat
-/

def associativity : ∀ {a b c : Nat}, a + (b + c) = (a + b) + c
  | a, b, zero =>  { }
  | a, b, n   => (a + b + succ n )
