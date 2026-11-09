import Mathlib
import TauCeti.Algebra.Quaternion.BrauerClass
import TauCeti.Algebra.Quaternion.SplittingCriterion
import TauCeti.FieldTheory.GaloisCohomology.MuTwo.CupNorm
import TauCeti.FieldTheory.QuadraticForm.StiefelWhitney.Evens.Kummer.Value
import TauCeti.FieldTheory.QuadraticForm.StiefelWhitney.QuadraticExtension
import TauCeti.LinearAlgebra.QuadraticForm.RegularFormClass.Discriminant
import TauCeti.LinearAlgebra.QuadraticForm.RegularFormClass.Hasse.Basic
import TauCeti.NumberTheory.HilbertSymbol.Basic
import TauCeti.NumberTheory.LocalField.QuadraticForm.Bimultiplicativity
import TauCeti.NumberTheory.LocalField.QuadraticForm.Brauer
import TauCeti.NumberTheory.LocalField.QuadraticForm.Classification
import TauCeti.NumberTheory.QuadraticForm.Global.ProductFormula

/-!
# Quadratic forms and cohomological invariants: target signatures

**This file is not the roadmap.** The roadmap is `README.md`. This file states the roadmap's
headline theorems against the pinned Mathlib and Tau Ceti, so that the finished roadmap has an
acceptance test, together with the few names that other roadmaps use in their Lean files.

Every object of this roadmap is Tau Ceti's at the pinned commit, and the README's supplier
contracts name the native declaration and file for each layer. The headline theorems are therefore
stated as examples discharged by the pinned declarations, and nothing in the file is admitted.

* **The headline theorems**, each stated as an `example` and discharged by the pinned Tau Ceti
  declaration named here:
  - Layer 2, the four-fold splitting criterion,
    `TauCeti.QuaternionAlgebra.nonempty_algEquiv_matrix_tfae`;
  - Layer 6C, Hilbert's product formula for the norm-equation symbol,
    `TauCeti.hilbertSymbol_productFormula`;
  - Layer 6D, the classification of forms over a nonarchimedean local field by `(dim, d, s)`,
    `QuadraticForm.equivalent_iff_finrank_eq_and_discr_eq_and_localHasse_eq`;
  - Layer 7C, the cup-norm theorem, `TauCeti.cup_kummerClass_eq_zero_iff`;
  - Layer 9, the value of the Evens norm on a Kummer class, `TauCeti.galoisEvens2_kummerClass`;
  - Layer 9, the relative Stiefel–Whitney formula in degree two,
    `TauCeti.sw2Class_formClass_traceTransfer_smul_sq`.

  Every headline theorem of the README is statable at the pins; none is omitted for a missing
  carrier.
* **The names other roadmaps use in Lean.** `GlobalQuadraticForms` and `OrthogonalSpinGroups`
  import this module, and their Lean files use `formClass`, `discr`, `hilbertSymbol`,
  `localHasse`, `hilbertSymbol_neg_self`, `hilbertSymbol_mul`, `exists_hilbertSymbol_eq_neg_one`
  and `hasseInvariant_eq_localHasse`; these eight are kept for that reason. Each is an alias of a
  Tau Ceti declaration or is proved from one, and `localHasse` and `hilbertSymbol` keep the bodies
  that their consumers unfold. Every other name a roadmap cites from this namespace is a Tau Ceti
  declaration, and the README's Downstream consumers gives its Tau Ceti name.
-/

namespace TauCetiRoadmap.QuadraticFormInvariants

open QuadraticMap
open scoped Quaternion

universe u v

/-! `formClass` is Tau Ceti's class of a regular form in `TauCeti.RegularFormClass K` (Layer 0,
`TauCeti/LinearAlgebra/QuadraticForm/RegularFormClass/Basic.lean`), under the name consumers use; the
`export` makes the name of this namespace denote the same constant. -/

export TauCeti (formClass)

/-! ## Layer 2: quaternion algebras and the four-fold splitting criterion -/

/-- **Layer 2, the four-fold splitting criterion** (Lam III.2.7, Serre *CiA* III.1.1–1.2),
Tau Ceti's `TauCeti.QuaternionAlgebra.nonempty_algEquiv_matrix_tfae`: `ℍ[K,a,b]` splits, `b` is a
norm from `K[√a]`, `b = x² − a y²` is solvable, `⟨1, −a, −b⟩` is isotropic, and the norm form
`⟨⟨a,b⟩⟩` is isotropic, are equivalent. -/
example {K : Type u} [Field K] [Invertible (2 : K)] (a b : Kˣ) :
    [Nonempty (ℍ[K, (a : K), (b : K)] ≃ₐ[K] Matrix (Fin 2) (Fin 2) K),
      ∃ z : QuadraticAlgebra K (a : K) 0, z.norm = b,
      ∃ x y : K, (b : K) = x ^ 2 - a * y ^ 2,
      ¬ (weightedSumSquares K ![1, -(a : K), -(b : K)]).Anisotropic,
      ¬ (QuaternionAlgebra.normForm (a : K) 0 (b : K)).Anisotropic].TFAE :=
  TauCeti.QuaternionAlgebra.nonempty_algEquiv_matrix_tfae a b

/-! ## Layer 3: the discriminant, under the name consumers use -/

/-- **The discriminant in `Kˣ ⧸ (Kˣ)²`**: Tau Ceti's additive `TauCeti.RegularFormClass.discr`, read
through Tau Ceti's `TauCeti.multiplicativeSquareClassEquiv`. -/
noncomputable def discr {K : Type u} [Field K] [Invertible (2 : K)]
    (x : TauCeti.RegularFormClass K) :
    Kˣ ⧸ Subgroup.square Kˣ :=
  TauCeti.multiplicativeSquareClassEquiv.symm
    (Multiplicative.ofAdd (TauCeti.RegularFormClass.discr x))

/-! ## Layer 6C: the Hilbert symbol, the local Hasse invariant and Hilbert reciprocity -/

section HilbertSymbol

variable {K : Type u} [Field K]

/-- **The Hilbert symbol**, Tau Ceti's `TauCeti.hilbertSymbol`: `+1` when `b = x² − a y²` has a
solution in `K` and `−1` otherwise. It is defined over every field. -/
noncomputable abbrev hilbertSymbol (a b : Kˣ) : ℤˣ :=
  TauCeti.hilbertSymbol a b

/-- **The local Hasse invariant of a diagonal tuple**, `∏_{i<j} (aᵢ, aⱼ)`, with the empty product
in ranks `0` and `1`. On the class of the tuple it is Tau Ceti's
`TauCeti.RegularFormClass.localHasse`. -/
noncomputable def localHasse {n : ℕ} (w : Fin n → Kˣ) : ℤˣ :=
  ∏ ij ∈ Finset.univ.filter fun ij : Fin n × Fin n => ij.1 < ij.2,
    hilbertSymbol (w ij.1) (w ij.2)

/-- `(a, −a) = +1` over every field, Tau Ceti's `TauCeti.hilbertSymbol_neg_self`. -/
theorem hilbertSymbol_neg_self (a : Kˣ) : hilbertSymbol a (-a) = 1 :=
  TauCeti.hilbertSymbol_neg_self a

/-- The pairwise product over the pairs `i < j` is the iterated product over `j ∈ Ioi i`, which is
how Tau Ceti's `TauCeti.RegularFormClass.localHasse_mk` writes it. -/
private theorem localHasse_eq_prod_prod_Ioi {n : ℕ} (w : Fin n → Kˣ) :
    localHasse w = ∏ i, ∏ j ∈ Finset.Ioi i, TauCeti.hilbertSymbol (w i) (w j) := by
  rw [localHasse, Finset.prod_filter, Fintype.prod_prod_type]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [← Finset.prod_filter]
  congr 1
  ext j
  simp

/-- **Bimultiplicativity** over a nonarchimedean local field, Tau Ceti's
`TauCeti.hilbertSymbol_mul_right`. -/
theorem hilbertSymbol_mul [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K]
    [Invertible (2 : K)] (a b c : Kˣ) :
    hilbertSymbol a (b * c) = hilbertSymbol a b * hilbertSymbol a c :=
  TauCeti.hilbertSymbol_mul_right (Invertible.ne_zero (2 : K)) a b c

/-- **Nondegeneracy** over a nonarchimedean local field, Tau Ceti's
`TauCeti.exists_hilbertSymbol_eq_neg_one`. -/
theorem exists_hilbertSymbol_eq_neg_one [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] [Invertible (2 : K)] (a : Kˣ) (ha : ¬ IsSquare a) :
    ∃ b : Kˣ, hilbertSymbol a b = -1 :=
  TauCeti.exists_hilbertSymbol_eq_neg_one (Invertible.ne_zero (2 : K)) ha

end HilbertSymbol

open IsDedekindDomain NumberField in
open scoped Classical in
/-- **Layer 6C, Hilbert's product formula for the norm-equation symbol** (Serre *CiA* III.2.2
Theorem 3, O'Meara 71:18), Tau Ceti's `TauCeti.hilbertSymbol_productFormula`: over a number field
the symbols `(a, b)_v` at the finite places, read in the completions, and at the real places
multiply to `1`. -/
example (F : Type) [Field F] [NumberField F] (a b : Fˣ) :
    (∏ᶠ v : HeightOneSpectrum (𝓞 F),
        hilbertSymbol (v.unitAtFinitePlace a) (v.unitAtFinitePlace b)) *
      ∏ w : {w : InfinitePlace F // w.IsReal},
        hilbertSymbol (TauCeti.unitAtRealPlace w a) (TauCeti.unitAtRealPlace w b) = 1 :=
  TauCeti.hilbertSymbol_productFormula a b

/-! ## Layer 6D: the classification and its corollaries -/

/-- **Layer 6D, the local classification** (O'Meara 63:20, Serre *CiA* IV.2.3), Tau Ceti's
`QuadraticForm.equivalent_iff_finrank_eq_and_discr_eq_and_localHasse_eq`: over a nonarchimedean
local field two regular forms are isometric exactly when their dimensions, discriminants and local
Hasse invariants agree. The class-level form is
`TauCeti.RegularFormClass.eq_iff_rank_eq_and_discr_eq_and_localHasse_eq`. -/
example {K : Type u} [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] [Invertible (2 : K)] {V W : Type v} [AddCommGroup V]
    [Module K V] [FiniteDimensional K V] [AddCommGroup W] [Module K W] [FiniteDimensional K W]
    (Q : QuadraticForm K V) (hQ : Q.Nondegenerate) (R : QuadraticForm K W)
    (hR : R.Nondegenerate) :
    Q.Equivalent R ↔ Module.finrank K V = Module.finrank K W ∧
      TauCeti.RegularFormClass.discr (formClass Q hQ) =
        TauCeti.RegularFormClass.discr (formClass R hR) ∧
      TauCeti.RegularFormClass.localHasse (formClass Q hQ) =
        TauCeti.RegularFormClass.localHasse (formClass R hR) :=
  QuadraticForm.equivalent_iff_finrank_eq_and_discr_eq_and_localHasse_eq Q hQ hR

/-! ## Layer 6E: the two Hasse invariants agree -/

section HasseComparison

/-- The tensor-product group law on the Brauer group, `TauCeti.BrauerGroup.instCommGroup`, at the
universe of the field. -/
noncomputable local instance qfiNativeBrauerCommGroup (F : Type*) [Field F] :
    CommGroup (BrauerGroup F) := TauCeti.BrauerGroup.instCommGroup

/-- **The two Hasse invariants agree** (Layer 6E, Milestone 1): over a nonarchimedean local field,
Tau Ceti's sign isomorphism `TauCeti.BrauerGroup.quaternionSubgroupSignEquiv` on the subgroup
generated by quaternion classes carries the Brauer-valued Hasse invariant to the local Hasse
invariant (`TauCeti.RegularFormClass.quaternionSubgroupSignEquiv_apply_hasseInvariant`). -/
theorem hasseInvariant_eq_localHasse {K : Type u} [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] [Invertible (2 : K)] :
    ∃ ε : Subgroup.closure
        (Set.range fun ab : Kˣ × Kˣ => TauCeti.BrauerGroup.quaternionClass ab.1 ab.2) →* ℤˣ,
      Function.Injective ε ∧
      ∀ {n : ℕ} (w : Fin n → Kˣ) (h : TauCeti.RegularFormClass.hasseInvariant
          (Quotient.mk (TauCeti.regularFormSetoid K) ⟨n, w⟩) ∈
        Subgroup.closure
          (Set.range fun ab : Kˣ × Kˣ => TauCeti.BrauerGroup.quaternionClass ab.1 ab.2)),
        ε ⟨_, h⟩ = localHasse w := by
  refine ⟨(TauCeti.BrauerGroup.quaternionSubgroupSignEquiv (K := K)).toMonoidHom,
    (TauCeti.BrauerGroup.quaternionSubgroupSignEquiv (K := K)).injective, fun w h => ?_⟩
  have := TauCeti.RegularFormClass.quaternionSubgroupSignEquiv_apply_hasseInvariant
    (Quotient.mk (TauCeti.regularFormSetoid K) ⟨_, w⟩)
  rw [TauCeti.RegularFormClass.localHasse_mk] at this
  rw [localHasse_eq_prod_prod_Ioi]
  exact this

end HasseComparison

/-! ## Layer 7C: the cup-norm theorem -/

/-- **Layer 7C, the cup-norm theorem** (Serre, *L'invariant de Witt de la forme Tr(x²)*, §1.1;
Serre, *Local Fields* XIV §2; Gille–Szamuely 4.7), Tau Ceti's `TauCeti.cup_kummerClass_eq_zero_iff`:
over every field in which `2` is invertible,
`(a) ∪ (b) = 0` in `H²(G_K, 𝔽₂)` exactly when `b = x² − a y²` is solvable. -/
example {K : Type u} [Field K] [Invertible (2 : K)] (a b : Kˣ) :
    (TauCeti.trivialF2TopPairing (TauCeti.AbsoluteGaloisGroup K)).cup 1 1
        (TauCeti.kummerClass a) (TauCeti.kummerClass b) = 0 ↔
      ∃ x y : K, (b : K) = x ^ 2 - a * y ^ 2 :=
  TauCeti.cup_kummerClass_eq_zero_iff a b

/-! ## Layer 9: transfer and the relative Stiefel–Whitney formula -/

section Transfer

variable {K : Type u} [Field K] {L : Type u} [Field L] [Algebra K L]

/-- **Layer 9, the value of the Evens norm on a Kummer class** (Kahn, Lemme II.2.1), Tau Ceti's
`TauCeti.galoisEvens2_kummerClass`: for `L = K(x)` with `x² = d` and `a ∈ Lˣ` of trace `t ≠ 0`,
`N^Ev((a)) = (t) ∪ (−d · N a) + (2) ∪ (d)`. -/
example [Invertible (2 : K)] [FiniteDimensional K L] [Algebra.IsSeparable K L]
    [Invertible (2 : L)] (σ : L →ₐ[K] SeparableClosure K) (hdeg : Module.finrank K L = 2)
    (d : Kˣ) {x : L} (hx : x ∉ Set.range (algebraMap K L))
    (hx2 : x ^ 2 = algebraMap K L (d : K)) (a : Lˣ) (t : Kˣ)
    (ht : (t : K) = Algebra.trace K L (a : L)) :
    TauCeti.galoisEvens K L σ hdeg (TauCeti.kummerClass a) =
      (TauCeti.trivialF2TopPairing (TauCeti.AbsoluteGaloisGroup K)).cup 1 1
          (TauCeti.kummerClass t)
          (TauCeti.kummerClass (-(d * Units.map (Algebra.norm K : L →* K) a))) +
        (TauCeti.trivialF2TopPairing (TauCeti.AbsoluteGaloisGroup K)).cup 1 1
          (TauCeti.kummerClass (unitOfInvertible (2 : K))) (TauCeti.kummerClass d) :=
  TauCeti.galoisEvens2_kummerClass σ hdeg d hx hx2 a t ht

/-- **Layer 9, the relative Stiefel–Whitney formula in degree two** (Kahn, Théorème 2 in degree
two), Tau Ceti's `TauCeti.sw2Class_formClass_traceTransfer_smul_sq`: for a quadratic extension
`L/K` and `a ∈ Lˣ`,
`w₂(Tr_*⟨a⟩) = w₂(Tr_*⟨1⟩) + N^Ev((a)) + w₁(Tr_*⟨1⟩) ∪ cor (a)`. -/
example [Invertible (2 : K)] [FiniteDimensional K L] [Invertible (2 : L)]
    (σ : L →ₐ[K] SeparableClosure K) (hfin : Module.finrank K L = 2) (a : Lˣ)
    (ha : (((a : L) • QuadraticMap.sq (R := L) (A := L)).traceTransfer K).Nondegenerate)
    (h1 : ((QuadraticMap.sq (R := L) (A := L)).traceTransfer K).Nondegenerate) :
    TauCeti.sw2Class (formClass _ ha) =
      TauCeti.sw2Class (formClass _ h1) +
          TauCeti.galoisEvens K L σ hfin (TauCeti.kummerClass a) +
        (TauCeti.trivialF2TopPairing (TauCeti.AbsoluteGaloisGroup K)).cup 1 1
          (TauCeti.sw1Class (formClass _ h1)) (TauCeti.galoisCor K L σ 1 (TauCeti.kummerClass a)) :=
  TauCeti.sw2Class_formClass_traceTransfer_smul_sq σ hfin a ha h1

end Transfer

end TauCetiRoadmap.QuadraticFormInvariants
