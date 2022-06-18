section Logic

  -- Prop = a True/False statement
  variable (P Q R : Prop)

  -- assumption(s) |- goal(s)

  -- `hp` is a proof that `P is true` then I write `hp : P`
  -- `P` `Q` and `R` are all true. Deduce `P` is true
  example (hP: P)(hQ: Q)(hR :R) : P := by
    exact hP -- I use the exact tactic when the assumption cover the goal

  -- Assume `Q` is true. Prove that `P → Q`. 
  example(hQ: Q) : P → Q := by
    intro h -- introducing the hypothesis `h` (`P` is true)
    exact hQ -- now the goal is the same as the hypothesis

  -- Assume `P → Q` and `P` is true. Deduce `Q`.
  example (h: P → Q)(h2: P) : Q := by
    apply h
    exact h2


end Logic