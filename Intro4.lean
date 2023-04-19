-- using lean4 with Github Copilot

  -- formalising group in lean4
  def group := { G : Type u // group structure }

  -- what is a structure in lean4
  structure group := (G : Type u) (mul : G → G → G) (one : G)

  -- define a universe variable
  universe u

  -- example of a group
  def group_of_integers : group := { G := int, mul := int.mul, one := 1 }

  -- 4 axioms of a group
  def group_axioms (G : group) : Prop :=
    G.mul G.one G.one = G.one ∧
    ∀ x : G.G, G.mul x G.one = x ∧ G.mul G.one x = x ∧
    ∀ x y z : G.G, G.mul x (G.mul y z) = G.mul (G.mul x y) z


  -- example of a group with axioms
  def group_of_integers_with_axioms : group :=
  { G := int, mul := int.mul, one := 1,
    property := group_axioms group_of_integers }
