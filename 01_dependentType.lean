/- Define section -/
def m : Nat := 1
def n : Nat := 0
def f := m + n
def b1 := true
def b2 : Bool := false
/- Check section -/
/- 
#check m
#check f
#check f + 0
#check b1
#check Nat → Nat -- \to or \r or \-> notation for the arrow 
#check Nat -> Nat -- same as before but with ASCII char

#check Nat × Nat -- \times or \x for the cartesian product symbol (x) 
#check Prod Nat Nat -- ASCII notation

#check Nat → Nat → Nat
#check (Nat → Nat) → Nat  -- same as before
#check Nat × Nat → Nat

#check Nat.succ -- Nat → Nat
#check (0, 1)   -- Nat × Nat
#check Nat.add  -- Nat → Nat → Nat
-/
/- Check get the type.. then the eval get the result (see after) -/
/--/
#check Nat.succ 2 -- Nat
#check (5, 8).1 -- Nat
#check (5, 8).2 -- Nat
#check Nat.add 5 8 -- Nat
/- Partial application -/
#check Nat.add 5 -- Nat → Nat

/- Eval section -/
#eval b1 && b2
#eval Nat.succ 2  -- 3
#eval (5, 8).1
#eval (5, 8).2
#eval Nat.add 5 8 -- 13
#eval Nat.add (Nat.succ 1) (Nat.pred 3) -- 2 + 2 = 4
/- Types as object -/
#check Nat -- Type
#check Nat → Nat → Bool -- Type
-/
def α : Type := Nat
def β : Type := Bool
def F : Type → Type := List 
def G : Type → Type → Type := Prod
/-
#check α     -- Type
#check F α   -- Type, the same of: check F Nat
#check G α β -- Type, the same of: check G Nat Bool
#check G α   -- Type → Type (partial application)

/- "universe" of small/ordinary types = Type n with Type n > Type (n-1) -/
#check Type    -- Type 1 (Type == Type 0)
#check Type 1  -- Type 2  ---- Type 2 > Type 1 > Type (0)
#check Type 32 -- Type 33 --- MAX level
/- polymorphic over type universe: eg. List -/
#check List    /-  Type u_1 → Type u_1  List make sense for every type (u_1), no matter which "universe" is in.
    IMPORTANT: With List a, if a has Type n (universe of types n, also List n has the same universe Type n -/
-/
/- *** define Polymorphic *** -/
def F1.{u} (α: Type u) : Type u := Prod α α
-- #check F1   -- Type u -> Type u
-- or explicitly define the universe
universe u 
def F1b(α : Type u) : Type u  := Prod α α
-- #check F1b  -- Type u -> Type u
/- *** FUNCTIONS *** -/
/- 
#check fun x : Nat => x + 10
#check λ (x : Nat) => x + 1  -- fun and \fun (λ) are the same
-- all the same function: Nat → Book → Nat 
#check λ (x: Nat) => λ (y: Bool) => if not y then x else x + 3
#check fun (x: Nat) (y: Bool) => if not y then x else x + 2
#check λ x y => if not y then x else x + 1
-/
-- lambda abstraction and composability 
def myId (x: Nat) : Nat := x  -- identity function: Nat → Nat
def atrue (x: Nat) := true    -- always true      : Nat → Bool
-- #check λ x => atrue (myId x)  -- infered: Nat → Bool 
-- pass functions as parameters
#check λ (g: String → Bool)(f: Nat → String)(x : Nat) => g (f x)  -- fun g f x => g (f x) : (String → Bool) → (Nat → String) → Nat → Bool
/- *** Types as parameters *** -/
#check λ (α β γ : Type)(g: β → γ)(f: α → β)(x: α) => g (f x) -- fun α β γ g f x => g (f x) : (α β γ : Type) → (β → γ) → (α → β) → α → γ
#eval (λ (α β γ : Type)(g: β → γ)(f: α → β)(x: α) => g (f x)) Nat String Bool 
          (λ (s: String) => s.length > 0) (λ (n: Nat) => toString n) 1   -- Bool = true
/- *** local definition *** -/ 
-- #eval let y := 2; y * y    -- 16
-- * let a := t1; t2 *  vs   * (fun a => t2) t1 *
def df (x: Nat) : Nat := let y := x + x; y * y
/- In this case every instance of the first bind in the 2nd function is just an abbreviation
Like when we have a f(x) and we do y = f(x). y is an abbreviation for f(x)  -/
def foo :=  let a := Nat; fun (x : a) => x + 2   -- #eval foo 2   -- = 4
/- in this case the first fun is an expression and has to make sense regardless the value of a 
And also this 2nd case doesn't work...
def bar := (fun a => fun (x: a) => x + 2)
-/
/- ***  Variables and sections  *** -/
section xyz
  variable (α : Type)
  variable (α β γ : Type)
  variable (g: β → γ) (f: α → β)
  variable (x : α)

  def doTwice(f: α → α)(x : α) := f (f x)
  def compose'(g: β → γ)(f: α → β)(x : α) := g (f x)
  def compose := g (f x)
/-
#print compose   -- can't reference it outside of the section
def compose : (α β γ : Type) → (β → γ) → (α → β) → α → γ :=
fun α β γ g f x => g (f x)
-/
end xyz
/- *** Namespae *** -/
namespace abc 
  def a : Nat := 5
  def f' (x: Nat) : Nat := x + 7
  def f'a : Nat := f' a 
  def f'f'a : Nat := f' (f' a)  
  -- #check f' -- : Nat → Nat
end abc 
-- #check f'  -- error
-- #check abc.f' -- : Nat → Nat
namespace abc -- namespace can be "reopened" but variables scope is only inside the namespace
  def f2 (x: Nat) : Nat := f' (f' x)
  end abc 
/- Use open with namespace to include all the namespace and use short names
open abc 
#check f'
#check f2
open List
#check map
#check nil
-/
/- *** Dependent types *** -/
def cons (α : Type)(a : α)(as : List α): List α := List.cons a as
/- so "cons α" has type α → List α → List α but cons has type (Type α) → α → List α → List α 
This is an instance of *** dependent function type  or  dependent arrow type *** 
with (α : Type) and (β : α → Type) β is a family of types over α (of type  β a  ∀  a : α).
In this case ((a: α) → β) is a type of functions where (f a) is an element of (β a) ∀ (a : α) and only if (β : Type)
If β doesn't depend on a then (a: α) → β is like (α → β) or ((a : α) → β)
The explicit notation for dependent types is ((a: α) → β a) 
-/
#check @List.cons  -- @List.cons : {α : Type u_1} → α → List α → List α 
/-
Just as dependent function types (a : α) → β a generalize the notion of a function type α → β by allowing β to depend on α, 
*** dependent Cartesian product types *** (a : α) × β a generalize the Cartesian product α × β in the same way
-/
namespace cartesian
universe v w
def f0 (α : Type v)(β : α → Type w)(a : α)(b : β a):(a : α)×(β a):= ⟨a,b⟩ 
variable (α : Type v)
variable (β : α → Type w)  -- depending on α 
def f (a : α) (b : β a) : (a : α) × (β a) := ⟨a, b⟩  -- ⟨a, b⟩ is a dependent pair NOT a tuple (a, b)  
-- same as 
def f' (a: α) (b: β a) : (a : α) × (β a) := Sigma.mk a b
-- or  
def f'' (a: α) (b: β a) : Σ a : α, β a := ⟨a, b⟩ 

#check (fun α => α)
def h1 (x: Nat) : Nat := (f0 Type (fun α => α) Nat x).2
end cartesian