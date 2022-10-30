section Logic
  -- Basics
  -- assumption(s) `|-` goal(s)

  -- `Prop` = a True/False statement
  variable (P Q R : Prop)

  /- Tactics:
    * `intro` = assume, introduce an hypothesis
    * `exact` = use exactly the assumption to solve the proof
    * `apply` = "argues backwards", works with implication (P → Q) 
                (and use it to REDUCE the "goal" closer to hypothesis)
            eg.: if `|- Q` doing `apply h` (h : P → Q) reduces the goals to to `|- P`
              like saying "because of `h` it is enough to prove this new simpler thing"
  -/
  /- 
    Writing `hp : P` means (one of the following):
    - `hp` is a proof of `P`
    - `hp` is the assumption that `P` is true
    - `P` is true and this fact is called `hp`
    *** `hp : P` and `P : Prop` are different! The latter means `P`is a true/false statement
  -/
  -- `P` `Q` and `R` are all true. Deduce `P` is true
  example (hP: P)(hQ: Q)(hR :R) : P := by
    exact hP -- I use the exact tactic when the assumption cover the goal

  -- Assume `Q` is true. Prove that `P → Q`. 
  example (hQ: Q) : P → Q := by
    intro p -- introducing the hypothesis `p` (we ASSUME `P` is true)
    exact hQ -- now the goal is the same as the hypothesis

  -- Assume `P → Q` and `P` is true. Deduce `Q`.
  example (h: P → Q)(h2: P) : Q := by
    apply h
    exact h2

  -- Every proposition implies itself
  example : P → P := by 
    intro p 
    exact p 

  -- variable (r : R)
  -- prove that `P → (Q → R)`
  example (r : R) : P → Q → R := by 
    intro p
    intro q 
    exact r

  -- lemma modus_pones
  -- we assume P (p = true) and then we imply (P → Q)
  example (pq: P → Q)(q : Q) : P → (P → Q) → Q := by
    intro p
    intro pq
    exact q



end Logic