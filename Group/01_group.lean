-- import Lean
-- #eval Lean.versionString

-- function as a mapping 
-- (X Y : Type)(f : X → Y) := ∀ x ∈ X, ∃ y ∈ Y, f(x) = y 

-- first we need to define injective, surjective and bijective function
-- a function f : X → Y is *injective* if f(a) = f(b) → a = b for all a,b in X.
variable (X Y : Type)

-- ∀ a b : X, f(a) = f(b) ↔ a = b
def injective (f : X → Y)(a b : X) : Prop :=
  (f a) = (f b) ↔ (a = b)

-- ∀ y ∈ Y, ∃ x ∈ X s.t. f(x) = y
def surjective (f: X → Y)(a : X)(b : Y): Prop :=
sorry

#check And
#check Or 
#check implies

variable (α β γ)
#check And α β 
#check And α β = α ∧ β 
#check implies (And α β) (β ∧ α)

#check Prop

variable (α : Type)
def Proof (p: Prop) : Type :=
  type_of% p

#check Proof 
