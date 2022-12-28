section myAlgebra

def lex (x: Ordering)(y: Ordering) : Ordering :=
  match x with 
  | Ordering.eq => y 
  | _ => x 

class Magma (α : Type) where
  op : α → α → α 

instance : Magma Ordering where 
  op := lex

class Semigroup (α : Type) extends Magma α where 
  -- isAssoc x y z : op (op x y) z = op x (op y z)
  -- isAssoc : ∀ x y z : α, op (op x y) z = op x (op y z)
  isAssoc (x y z: α) : op (op x y) z = op x (op y z)
structure Magma where
  carrier : Type
  op : carrier → carrier → carrier

structure Semigroup extends Magma where
  is_assoc : ∀ a b c, op (op a b) c = op a (op b c)

structure Monoid extends Semigroup where
  e : carrier -- alternative names: identity or unit or ε
  is_left_identity: ∀ x, op e x = x
  is_right_identity: ∀ x, op x e = x

def lex_is_assoc : ∀ a b c, lex (lex a b) c = lex a (lex b c) := by
  intros a b c
  cases a <;> simp [lex]

def eqIsLexLeftIdentity : ∀ x, lex Ordering.eq x = x := by
  intro x
  simp [lex]

def eqIsLexRightIdentity : ∀ x, lex x Ordering.eq = x := by
  intro x
  cases x <;> rfl

def eqIsLexRightIdentity' : ∀ x, lex x Ordering.eq = x := by
  intro x
  cases x
  · rfl
  · rfl
  · rfl

def eqIsLexRightIdentity'' : ∀ x, lex x Ordering.eq = x := by
  intro x
  cases x
  { rfl }
  { rfl }
  { rfl }


--def orderingLexMagma : Magma := { carrier := Ordering, op := lex }
def orderingMagma := Magma.mk Ordering lex
-- def orderingSemigroup := Semigroup.mk orderingLexMagma sorry 
def orderingSemigroup : Semigroup := { toMamgma := orderingLexMagma, is_assoc := lex_is_assoc }

def orderingLexMonoid : Monoid := {
  toSemigroup := orderingLexSemigroup,
  e := Ordering.eq,
  is_left_identity := eqIsLexLeftIdentity,
  is_right_identity := eqIsLexRightIdentity
}

end myAlgebra