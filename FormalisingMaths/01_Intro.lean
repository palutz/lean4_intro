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
  -- Examples from the online workbook
  section examples
    -- `P` `Q` and `R` are all true. Deduce `P` is true
    example (hP: P)(hQ: Q)(hR :R) : P := by
      exact hP -- I use the exact tactic when the assumption cover the goal

    -- Assume `Q` is true. Prove that `P → Q`. 
    example (hQ : Q) : P → Q := by
      -- The goal is of the form `X → Y` so we can use `intro`
      intro h -- now `h` is the hypothesis that `P` is true.
      -- Our goal is now the same as a hypothesis so we can use `exact`
      exact hQ

    -- Assume `P → Q` and `P` is true. Deduce `Q`.
    example (h : P → Q) (hP : P) : Q := by
      apply h  -- goal is `⊢ Q` which matches with the conclusion of `h`
      exact hP -- now the goal is changed to `P` that is one of the assumptions

  end examples 

  section exercises  -- my turn ...
    -- Every proposition implies itself
    example : P → P := by 
      intro p 
      apply p 

    /-- If we know `P`, and we also know `P → Q`, we can deduce `Q`. 
    This is called "Modus Ponens" by logicians. -/
    example : P → (P → Q) → Q := by
      intro hP
      intro hPQ
      apply hPQ
      exact hP 

    /-- `→` is transitive. That is, if `P → Q` and `Q → R` are true, then
      so is `P → R`. -/
    example : (P → Q) → (Q → R) → (P → R) := by
      intro hPQ
      intro hQR
      intro hP
      apply hQR
      apply hPQ
      exact hP


    -- If `h : P → Q → R` with goal `⊢ R` and you `apply h`, you'll get
    -- two goals! Note that tactics operate on only the first goal.
    example : (P → Q → R) → (P → Q) → (P → R) := by
      sorry

  end exercises
end Logic