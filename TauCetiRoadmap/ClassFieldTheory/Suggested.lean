import Mathlib
import TauCeti.FieldTheory.Galois.AbsoluteGaloisGroup.FiniteExtension
import TauCeti.FieldTheory.Galois.Restriction
import TauCeti.FieldTheory.GaloisCohomology.Kummer
import TauCeti.NumberTheory.ClassFieldTheory.ClassField
import TauCeti.NumberTheory.ClassFieldTheory.Brauer.Invariant
import TauCeti.NumberTheory.ClassFieldTheory.Brauer.LocalH2Bound
import TauCeti.NumberTheory.ClassFieldTheory.Brauer.Restriction
import TauCeti.NumberTheory.ClassFieldTheory.Brauer.RootsOfUnity
import TauCeti.NumberTheory.ClassFieldTheory.ClassFields.RayClassField
import TauCeti.NumberTheory.ClassFieldTheory.ClassFields.RingClass.Field
import TauCeti.NumberTheory.ClassFieldTheory.FiniteCohomology.DegreeTwo
import TauCeti.NumberTheory.ClassFieldTheory.Formation.ArtinMap
import TauCeti.NumberTheory.ClassFieldTheory.Formation.Character
import TauCeti.NumberTheory.ClassFieldTheory.Formation.GaloisMaps
import TauCeti.NumberTheory.ClassFieldTheory.Formation.GroundNorm
import TauCeti.NumberTheory.ClassFieldTheory.Formation.NormLimitation
import TauCeti.NumberTheory.ClassFieldTheory.Formation.PrincipalIdeal
import TauCeti.NumberTheory.ClassFieldTheory.Formation.Tate.Corestriction
import TauCeti.NumberTheory.ClassFieldTheory.Formation.Tate.Cup
import TauCeti.NumberTheory.ClassFieldTheory.Formation.Tate.Naturality
import TauCeti.NumberTheory.ClassFieldTheory.Formation.Tate.Restriction
import TauCeti.NumberTheory.ClassFieldTheory.Global.AdmissibleModulus.Basic
import TauCeti.NumberTheory.ClassFieldTheory.Global.Formation
import TauCeti.NumberTheory.ClassFieldTheory.Global.HasseNorm.Basic
import TauCeti.NumberTheory.ClassFieldTheory.Global.Hilbert.Invariant
import TauCeti.NumberTheory.ClassFieldTheory.Global.Hilbert.Reciprocity
import TauCeti.NumberTheory.ClassFieldTheory.Global.Reciprocity
import TauCeti.NumberTheory.ClassFieldTheory.GlobalExistence.Correspondence
import TauCeti.NumberTheory.ClassFieldTheory.GlobalExistence.NormSubgroup
import TauCeti.NumberTheory.ClassFieldTheory.Local.ArtinMap
import TauCeti.NumberTheory.ClassFieldTheory.Local.ClassFormation
import TauCeti.NumberTheory.ClassFieldTheory.Local.CohomologicalDimension.Strict
import TauCeti.NumberTheory.ClassFieldTheory.Local.Conductor.Basic
import TauCeti.NumberTheory.ClassFieldTheory.Local.Conductor.UpperNumbering
import TauCeti.NumberTheory.ClassFieldTheory.Local.Cyclotomic
import TauCeti.NumberTheory.ClassFieldTheory.Local.Duality.Perfect
import TauCeti.NumberTheory.ClassFieldTheory.Local.EulerCharacteristic.Theorem
import TauCeti.NumberTheory.ClassFieldTheory.Local.ExplicitCyclotomicSymbol.ArtinMap
import TauCeti.NumberTheory.ClassFieldTheory.Local.Reciprocity
import TauCeti.NumberTheory.ClassFieldTheory.Local.Symbol
import TauCeti.NumberTheory.ClassFieldTheory.Local.Unramified
import TauCeti.NumberTheory.ClassFieldTheory.MuNRep
import TauCeti.NumberTheory.LocalField.FiniteExtension.IntermediateField
import TauCeti.NumberTheory.LocalField.Herbrand.Basic
import TauCeti.NumberTheory.LocalField.Unramified.Coordinate
import TauCeti.NumberTheory.NumberField.Global.Ideles.Norm.Relative
import TauCeti.NumberTheory.NumberField.Global.Orders.Picard
import TauCeti.NumberTheory.NumberField.LocalGlobal.Semilocal.Norm.LocalNorm
import TauCeti.RepresentationTheory.Homological.ContCohomology.TrivialFp
import TauCeti.RepresentationTheory.Homological.TateCohomology.NakayamaRim
import TauCeti.RepresentationTheory.Homological.TateCohomology.PrimaryComponent
import TauCeti.RingTheory.DedekindDomain.Discriminant.Basic
import TauCeti.Topology.Algebra.Group.Profinite.ZHat.Basic

/-!
# Class field theory: target signatures

The roadmap is `README.md`; this file is not the roadmap. It is the roadmap's acceptance test: it
states against the pinned Mathlib and Tau Ceti, on their own carriers, the headline theorems whose
Lean form the roadmap fixes and that are open at the Tau Ceti pin, with the one definition they
need, `localAbsoluteUpperRamificationGroup`. A headline that Tau Ceti proves at the pin is consumed
under Tau Ceti's name and not restated. Besides the open targets, the file keeps under this
roadmap's names the Tau Ceti declarations that the Lean files of `LocalGaloisGroups`,
`GlobalQuadraticForms` and `IntegralLattices` use through this module. Every headline item of the
README's *Scope and ownership* is statable at the pins; the inventory below says where each is
stated. `sorry` marks an open target, never a definition: every definition, abbreviation and
instance below has a body. Every alias of a Tau Ceti theorem is a closed proof except two:
`eulerCharacteristic_finrank_fp` and `cyclotomicCharacter_artinMap` build Tau Ceti's hypothesis
`ValuativeExtension ℚ_[p] F` from the open Layer 5 target
`algebraMap_vle_algebraMap_iff_of_finite_padic`, and are closed once it is.

## Carriers

Everything is in universe `0`, because Mathlib's `tateCohomology` needs the group and the
coefficient ring `ℤ` in one universe. Continuous cohomology is Mathlib's `continuousCohomology` on
`TopRep (ZMod n) (Field.absoluteGaloisGroup F)`; coefficient pairings and the cup product are Tau
Ceti's `TopPairing` and `TopPairing.cup`. Valuations, unit filtrations, norm groups, ramification
groups and the upper numbering are Tau Ceti's (`TauCeti.unitFiltration`, `TauCeti.normGroup`,
`TauCeti.LocalFieldsRamification.upperRamificationGroup`); ideles and idele classes are Mathlib's
`NumberField.IdeleGroup` and `NumberField.IdeleClassGroup`; orders and Picard groups are Tau
Ceti's `TauCeti.GlobalNumberFields.NumberFieldOrder` and `TauCeti.GlobalNumberFields.Pic`.

## Headline inventory

The fourteen numbered items of `README.md`, *Scope and ownership*, are realized as follows; a
name not declared below is Tau Ceti's, in `TauCeti.ClassFieldTheory` unless qualified.

1. Tate's theorem: Tau Ceti's `tateTheorem` and its class-formation form `ClassFormation.tateIso`,
   with the compatibilities `ClassFormation.tateIso_res`, `ClassFormation.tateIso_cor`,
   `ClassFormation.tateIso_res_trans`, `ClassFormation.tateIso_conj` and
   `ClassFormation.tateIso_infl`; the Tate–Nakayama theorem is
   `TauCeti.TateCohomology.cup_bijective_of_forall_isPGroup_of_lTensor_injective`.
2. Finite Artin reciprocity: Tau Ceti's `ClassFormation.artinMap`, through
   `ClassFormation.nakayamaNegTwo` and `ClassFormation.artinEquiv`, definitionally the inverse of
   cup product with the fundamental class; its norm kernel and surjectivity are `ker_artinMap` and
   `surjective_artinMap`.
3. Functoriality: Tau Ceti's `ClassFormation.artinMap_groundInclusion`, `artinMap_groundNorm`,
   `artinMap_conj` and `artinMap_quotient`; the character formula
   `ClassFormation.character_artinMap`.
4. The local Brauer group and the Hilbert symbol: Tau Ceti's `Br`, `invMap`, `invMap_brRes` and
   `invMap_brCor`; the symbol `localSymbol` at a supplied coordinate, read at the arithmetic
   coordinate `h2MuEquivZMod` for the local Hilbert symbol; its laws `localSymbol_kummerClass_mul`,
   `localSymbol_antisymm`, `localSymbol_eq_zero_iff_mem_normGroup`,
   `forall_localSymbol_kummerClass_eq_zero_iff` and the Steinberg relation
   `localSymbol_kummerClass_eq_zero_of_add_eq_one`.
5. Local duality: Tau Ceti's `finite_H`, `tateDualityPairing_perfect_mixed` and
   `eulerCharacteristic_mixed`, and here `eulerCharacteristic_finrank_fp`.
6. Local reciprocity and its normalizations: Tau Ceti's `localClassFormation`, `localArtinEquiv`,
   `localArtinMap`, `localArtinMap_uniformizer` and
   `cohomologicalDimensionAt_absoluteGaloisGroup_eq_two`; here `normResidue`,
   `scd_p_absoluteGaloisGroup_eq_two` and the absolute `artinMap`, pinned by Tau Ceti's
   `artinMap_restrict` and `unramifiedCoordinate_artinMap` and here by `artinMap_norm`, with the
   cyclotomic normalization `cyclotomicCharacter_artinMap`; the open targets
   `map_unitFiltration_normResidue` and `closure_map_artinMap_unitFiltration`, the second on the
   absolute upper ramification groups
   `localAbsoluteUpperRamificationGroup`, and the corollary
   `conductorExponent_eq_sInf_upperRamificationGroup` of Tau Ceti's
   `conductorExponent_le_iff_upperRamificationGroup_eq_bot`, with the character form
   `conductorExponent_fixedField_ker`.
7. Norm limitation: Tau Ceti's `ClassFormation.normSubgroup_maximalAbelianLayer`.
8. Local existence and the local correspondence: Tau Ceti's `localAbelianExistence`,
   `localAbelianExistence_primeToResidueCharacteristic`, `localClassField_unique`,
   `localClassFieldCorrespondence`, `localClassFieldCorrespondencePrimeToResidueCharacteristic`,
   `localAbelianGaloisEquiv`, `index_localNormSubgroup`, `ker_artinMap_eq_iInf` and
   `injective_artinMap`.
9. The local Weil group: Tau Ceti's `localWeilGroup`, `WeilGroup` with its Weil topology
   (`isOpenEmbedding_inertiaToWeil`, `weilTopology_unique`), `weilDegree`, `weilTransfer`,
   `weilRestrict`, `localWeilArtinEquiv` and `localWeilArtinEquiv_compat`.
10. The Brauer sequence and the global invariant: Tau Ceti's `infiniteInvMap`, `finiteInvAt`,
    `infiniteInvAt`, `sumLocalInv`, `brLocalization_injective_of_subsingleton_h1_globalFormation`,
    `sumLocalInv_brLocalization_eq_zero`, `exists_br_of_sum_eq_zero`, `ideleToClassH2`,
    `surjective_ideleToClassH2_of_isCyclic`, `exists_refinement_mem_range_ideleToClassH2` and
    `globalInv`.
11. Global reciprocity: Tau Ceti's `globalClassFormation`, `globalClassFormation_inv`,
    `globalArtinEquiv`, `globalArtinMap`, `globalArtinMap_principal`, `globalArtinMap_ideal` and
    `globalArtinMap_local`.
12. Global existence: Tau Ceti's `globalAbelianExistence`, `globalClassField_unique`,
    `globalClassFieldCorrespondence`, the three inputs
    `exists_abelianLayer_globalNormSubgroup_eq_of_le`,
    `exists_abelianLayer_globalNormSubgroup_eq_of_comap_ideleClassNorm` and
    `exists_abelianLayer_globalNormSubgroup_eq_of_pow_mem`, the source `GlobalNormSubgroups` and
    the class field `globalClassField`; here `card_ideleClassNormQuotient`.
13. Norm theorems and class fields: here `cyclicHasseNorm`,
    `isGlobalNorm_iff_isLocalNormEverywhere`, `ringClassField` for every order of every number
    field with `ringClassArtinMap` and `gal_ringClassField_equiv_pic`, and the open targets
    `isPrincipal_map_hilbertClassField` (the principal ideal theorem) and
    `relDiscr_eq_finprod_abelianConductor` (the conductor–discriminant formula); Tau Ceti's
    `unitEmbedding_mem_range_ideleNormMap_iff`, `ringClassNormSubgroup`,
    `rayClassField`, `hilbertClassField`, `narrowHilbertClassField`,
    `gal_rayClassField_equiv_rayClassGroup`, `IsAdmissibleModulus`, `abelianConductor`,
    `rayClassArtinMap` and `kroneckerWeber`.
14. Hilbert reciprocity: `finiteHilbertInvariantAt`, `infiniteHilbertInvariantAt`,
    `finiteHilbertSupport` (with Tau Ceti's `finiteHilbertInvariantAt_eq_zero_of_notMem`),
    `hilbertProductFormula`. Quadratic reciprocity is Mathlib's
    `legendreSym.quadratic_reciprocity`.
-/

namespace TauCetiRoadmap.ClassFieldTheory

open CategoryTheory NumberField IsDedekindDomain
open scoped MonoidalCategory nonZeroDivisors ValuativeRel TensorProduct
open TauCeti.ClassFieldTheory

/-! ## Layer 0: cohomological triviality and projective dimension

The theorem of Nakayama and Rim and the primary-component statement are Tau Ceti's, in namespace
`Rep` (`Rep.isZero_res_of_projective`, `Rep.projective_of_isZero_res`, `Rep.isZero_res_of_exact`,
`Rep.projective_ker_of_isZero_res`) and `TauCeti.TateCohomology`. The two statements other
roadmaps consume under this roadmap's names are restated below as closed proofs. -/

namespace TateCohomology

universe u

open Rep

variable {k G : Type u} [CommRing k] [Group G]

/-- **`p`-primary Tate cohomology sees only `p`.** If multiplication by `p` is bijective on `A`,
the `p`-primary component of `Ĥⁿ(S, A)` is trivial for every subgroup `S` and every `n`: Tau
Ceti's `TauCeti.TateCohomology.primaryComponent_tateCohomology_eq_bot`. -/
theorem primaryComponent_tateCohomology_eq_bot (p : ℕ) (A : Rep k G)
    (hA : Function.Bijective fun x : A.V => (p : k) • x) (S : Subgroup G) [Fintype S] (n : ℤ) :
    AddCommGroup.primaryComponent (tateCohomology (res S.subtype A) n) p = ⊥ :=
  TauCeti.TateCohomology.primaryComponent_tateCohomology_eq_bot p A hA S n

variable [Finite G] [IsDomain k] [IsPrincipalIdealRing k] [CharZero k]

/-- **Nakayama–Rim: cohomological triviality is projective dimension at most one.** If `A` is
cohomologically trivial, the kernel of every surjection onto it from a projective `k[G]`-module is
projective; no finiteness is assumed. Tau Ceti's `Rep.projective_ker_of_isZero_res`. -/
theorem projective_ker_of_isZero_res
    (hk : ∀ p : ℕ, p.Prime → IsUnit (p : k) ∨ (Ideal.span {(p : k)}).IsMaximal)
    (A : Rep k G)
    (hA : ∀ (S : Subgroup G) [Fintype S] (n : ℤ),
      Limits.IsZero (tateCohomology (res S.subtype A) n))
    {P : Type*} [AddCommGroup P] [Module (MonoidAlgebra k G) P]
    [Module.Projective (MonoidAlgebra k G) P]
    (f : P →ₗ[MonoidAlgebra k G] A.ρ.asModule) (hf : Function.Surjective f) :
    Module.Projective (MonoidAlgebra k G) (LinearMap.ker f) :=
  Rep.projective_ker_of_isZero_res hk A hA f hf

end TateCohomology

/-! ## Layers 1 to 4: formations, class formations, Tate's theorem and the abstract Artin map

Layers 1 to 4 are implemented in Tau Ceti, in `TauCeti/NumberTheory/ClassFieldTheory/Formation/`,
and are consumed under Tau Ceti's names; none of them is restated. Their contents (formations and
their levels, finite normal layers with their finite quotient system, restriction, refinement and
conjugation of layers, abelian layers, class formations with the invariant as data, and
fundamental classes) are described in `README.md`, Layers 1 and 2. Tate's theorem is Tau Ceti's
`tateTheorem`, stated generically with its three hypotheses as separate explicit arguments, and
for a class formation `ClassFormation.tateIso`; Tau Ceti's `ClassFormation` supplies the three
hypotheses through `ClassFormation.h1_subgroupLayer`, `ClassFormation.card_H2_subgroupLayer` and
`ClassFormation.fundamentalClass_restrict_generates`. The Nakayama map, the Artin equivalence and
the Artin map are Tau Ceti's `ClassFormation.nakayamaNegTwo`, `ClassFormation.artinEquiv` and
`ClassFormation.artinMap`, the equivalence being definitionally `nakayamaNegTwo.symm`
(`ClassFormation.artinEquiv_eq_tateIso`, proved by `rfl`), with the functoriality diagrams
`ClassFormation.artinMap_groundInclusion`, `ClassFormation.artinMap_groundNorm`,
`ClassFormation.artinMap_conj` and `ClassFormation.artinMap_quotient`, the character formula
`ClassFormation.character_artinMap` and norm limitation
`ClassFormation.normSubgroup_maximalAbelianLayer`. -/

/-! ## Layer 5: local coefficients, the Brauer group, the local invariant, and duality

⚠ The local Brauer group and its invariant map are built **before** the local class formation, not
after it. `localClassFormation` of Layer 6 consumes `invMap`; nothing in this layer consumes
`localArtinMap`, `normResidue`, local existence, or the local class formation itself. -/

/-- Coefficient objects for the absolute Galois group with `ZMod n` scalars: Tau Ceti's `GalRep`,
Mathlib's `TopRep (ZMod n) (Field.absoluteGaloisGroup F)`. -/
abbrev GalRep (n : ℕ) (F : Type) [Field F] : Type 1 :=
  TauCeti.ClassFieldTheory.GalRep n F

/-- `Hⁱ(G_F,A)` on Mathlib's continuous cohomology functor. -/
noncomputable abbrev H (n : ℕ) (F : Type) [Field F]
    (i : ℕ) (A : GalRep n F) : Type _ :=
  continuousCohomology i A

section Local

variable (K : Type) [Field K] [ValuativeRel K] [TopologicalSpace K]
  [IsNonarchimedeanLocalField K]
variable (L : Type) [Field L] [ValuativeRel L] [TopologicalSpace L]
  [IsNonarchimedeanLocalField L]

/-! ### Kummer coefficients, the local Brauer group, and the invariant map

Every coefficient object of this layer is a discrete module of Tau Ceti's Galois cohomology, read
as an object of `GalRep n F` (or of `TopRep ℤ G_F`) through Tau Ceti's coefficient dictionary
`TauCeti.ofDiscreteModule` and restriction along the comparison of absolute Galois groups. -/

/-- Restriction identifies the algebraic-closure and separable-closure absolute Galois groups as
topological groups: Tau Ceti's `absoluteGaloisGroupRestrictEquiv`, whose forward map is
`AlgEquiv.restrictNormalHom` (`absoluteGaloisGroupRestrictEquiv_apply`). -/
noncomputable abbrev absoluteGaloisGroupComparison (F : Type) [Field F] :
    Field.absoluteGaloisGroup F ≃ₜ* TauCeti.AbsoluteGaloisGroup F :=
  TauCeti.absoluteGaloisGroupRestrictEquiv F

/-- **The coefficient object `μ_n(Fˢ)`**: Tau Ceti's `muNRep`, the `n`-th roots of unity of the
separable closure written additively, on which `G_F` acts through
`absoluteGaloisGroupComparison`. -/
noncomputable abbrev muNRep (n : ℕ) (F : Type) [Field F] : GalRep n F :=
  TauCeti.ClassFieldTheory.muNRep n F

/-- `μ_n(Fˢ)` is smooth, as an instance argument (Tau Ceti's `isSmoothDiscrete_muNRep`). -/
instance instFactIsSmoothDiscreteMuNRep (n : ℕ) (F : Type) [Field F] :
    Fact (TauCeti.IsSmoothDiscrete (ZMod n) (muNRep n F)) :=
  ⟨TauCeti.ClassFieldTheory.isSmoothDiscrete_muNRep n F⟩

/-- **The coordinate of `μ_n(Fˢ)` selected by a primitive root** `ζ ∈ F`: `ζ^k ↦ k`. Tau Ceti's
`muNRepEquivZMod`. -/
noncomputable abbrev muNRepEquivZMod {n : ℕ} [NeZero n] {F : Type} [Field F] (ζ : F)
    (hζ : IsPrimitiveRoot ζ n) : (muNRep n F).V ≃+ ZMod n :=
  TauCeti.ClassFieldTheory.muNRepEquivZMod ζ hζ

/-- **`G_F` fixes `μ_n(Fˢ)` pointwise when `ζ ∈ F`**: Tau Ceti's `muNRep_ρ_apply_eq_self`. -/
theorem muNRep_ρ_eq_self {n : ℕ} [NeZero n] {F : Type} [Field F] (ζ : F)
    (hζ : IsPrimitiveRoot ζ n) (g : Field.absoluteGaloisGroup F) (x : (muNRep n F).V) :
    (muNRep n F).ρ g x = x :=
  TauCeti.ClassFieldTheory.muNRep_ρ_apply_eq_self hζ g x

/-! #### The Kummer class -/

section KummerClass

attribute [local instance] TopRep.distribMulAction

/-- **The Kummer class of `a ∈ Fˣ` in `H¹(G_F, μ_n)`**: Tau Ceti's `kummerClass` where `n` is
invertible in `F` (`kummerClass_eq`), the transport of the Kummer map `TauCeti.kummerMap`. Where
`n` is not invertible there is no Kummer sequence and the value is `0`. -/
noncomputable def kummerClass (n : ℕ) (F : Type) [Field F] (a : Fˣ) : H n F 1 (muNRep n F) := by
  classical
  exact if hn : IsUnit (n : F) then TauCeti.ClassFieldTheory.kummerClass F hn a else 0

/-- **The defining equation of `kummerClass`** for `n` invertible in `F`. -/
theorem kummerClass_eq {n : ℕ} {F : Type} [Field F] (hn : IsUnit (n : F)) (a : Fˣ) :
    kummerClass n F a = TauCeti.ClassFieldTheory.kummerClass F hn a := by
  unfold kummerClass
  exact dite_eq_left_of_eq_true (eq_true hn)

/-- **The Kummer class on cocycles**: for an `n`-th root `α ∈ Fˢ` of `a`, the class of `a` is the
transported class of the Kummer cocycle `g ↦ g α / α` (Tau Ceti's
`kummerClass_eq_muNRepH1Equiv_kummerCocycleClass`). -/
theorem kummerClass_eq_kummerCocycleClass {n : ℕ} {F : Type} [Field F] (hn : IsUnit (n : F))
    {a : Fˣ} {α : (SeparableClosure F)ˣ}
    (hα : α ^ n = Units.map (algebraMap F (SeparableClosure F)).toMonoidHom a) :
    kummerClass n F a =
      TauCeti.ClassFieldTheory.muNRepH1Equiv n F (TauCeti.kummerCocycleClass hα) := by
  rw [kummerClass_eq hn]
  exact TauCeti.ClassFieldTheory.kummerClass_eq_muNRepH1Equiv_kummerCocycleClass F hn hα

/-- Mixed-characteristic Kummer equivalence, for every `n ≠ 0` including `n = p`: Tau Ceti's
`kummerEquivOfCharZero`. -/
noncomputable def kummerEquiv_mixed (p : ℕ) [Fact p.Prime] (F : Type) [Field F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (n : ℕ) (hn : n ≠ 0) :
    Additive (Fˣ ⧸ (powMonoidHom n : Fˣ →* Fˣ).range) ≃+ H n F 1 (muNRep n F) :=
  haveI : CharZero F := charZero_of_injective_algebraMap (algebraMap ℚ_[p] F).injective
  TauCeti.ClassFieldTheory.kummerEquivOfCharZero F hn

end KummerClass

/-- **The invariant coordinate of `H²(F, μ_n)` in mixed characteristic**, for every `n ≠ 0`: Tau
Ceti's `h2MuEquivZMod`, `n` being invertible in the characteristic-zero field `F`. It is the
canonical equivalence read off `invMap`, not an arbitrary one. -/
noncomputable abbrev h2MuEquivZMod_mixed (p : ℕ) [Fact p.Prime] (F : Type) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (n : ℕ) (hn : n ≠ 0) :
    H n F 2 (muNRep n F) ≃+ ZMod n :=
  haveI : CharZero F := charZero_of_injective_algebraMap (algebraMap ℚ_[p] F).injective
  TauCeti.ClassFieldTheory.h2MuEquivZMod F (Nat.cast_ne_zero.mpr hn).isUnit

/-- **The invariant coordinate transported to a coefficient object identified with `μ_p`**: Tau
Ceti's `h2EquivZModOfMuNRepIso` along the supplied isomorphism `e`. A chosen primitive `p`-th root
of unity identifies the trivial module `𝔽_p` with `μ_p` and so supplies `e`; without a coefficient
identification the zero module is a counterexample. -/
noncomputable abbrev h2FpEquivZMod_of_mu (p : ℕ) [Fact p.Prime] (F : Type) [Field F]
    [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (T : GalRep p F) (e : muNRep p F ≅ T) :
    H p F 2 T ≃+ ZMod p :=
  haveI : CharZero F := charZero_of_injective_algebraMap (algebraMap ℚ_[p] F).injective
  TauCeti.ClassFieldTheory.h2EquivZModOfMuNRepIso F
    (Nat.cast_ne_zero.mpr (Fact.out : p.Prime).ne_zero).isUnit e

/-! ### The cohomological Hilbert symbol -/

/-- **The coefficient pairing `μ_n × μ_n → μ_n` selected by a primitive root** `ζ ∈ F`:
`(x, y) ↦ log_ζ(x) · y`, Tau Ceti's `kummerCupPairing` (`kummerCupPairing_bil`). At `n = 0` it is
`0`. -/
noncomputable def kummerCupPairing {n : ℕ} {F : Type} [Field F]
    (ζ : F) (hζ : IsPrimitiveRoot ζ n) :
    TauCeti.TopPairing (muNRep n F) (muNRep n F) (muNRep n F) :=
  if h : n = 0 then
    { bil := 0
      cont := by simpa using (continuous_const : Continuous fun _ : (muNRep n F).V ×
        (muNRep n F).V => (0 : (muNRep n F).V))
      equivariant := fun g x y => by simp }
  else
    haveI : NeZero n := ⟨h⟩
    TauCeti.ClassFieldTheory.kummerCupPairing ζ hζ

/-- **The Kummer cup pairing is `(x, y) ↦ log_ζ(x) · y`.** -/
theorem kummerCupPairing_bil {n : ℕ} [NeZero n] {F : Type} [Field F] (ζ : F)
    (hζ : IsPrimitiveRoot ζ n) (x y : (muNRep n F).V) :
    (kummerCupPairing ζ hζ).bil x y = muNRepEquivZMod ζ hζ x • y := by
  simp only [kummerCupPairing, NeZero.ne n, dite_false]
  exact TauCeti.ClassFieldTheory.kummerCupPairing_bil ζ hζ x y

/-! ### The Tate dual, local duality and the Euler characteristic

The Tate dual `A' = Hom(A, μ_n)` is Tau Ceti's internal hom with the conjugation action, read as an
object of `GalRep n F`; the evaluation pairing, contravariance, exactness and the chosen-root
comparison are Tau Ceti's (`tateDualEquiv`, `tateEvaluationPairing`, `tateDualMap`,
`tateDualMap_exact`, `muNRepToTateDual`, `bijective_muNRepToTateDual`,
`tateDualityPairing_muNRepToTateDual`).

Tau Ceti's `tateDual`, `tateDualityPairing`, `finite_H` and `tateDualityPairing_perfect_mixed`
are consumed under those names.

**Smoothness is a hypothesis.** `GalRep n F` is Mathlib's `TopRep`, whose operators are continuous
one group element at a time. Tau Ceti's `finite_H` takes `TauCeti.IsSmoothDiscrete (ZMod n) A` —
the carrier is discrete and every point stabilizer is open — as an explicit hypothesis, and its
`tateDualityPairing_perfect_mixed` and `eulerCharacteristic_finrank_fp` below take it as the
instance argument `[Fact (TauCeti.IsSmoothDiscrete (ZMod n) A)]`. That instance is found at
`muNRep n F` (`instFactIsSmoothDiscreteMuNRep`), at the Tate dual of a finite smooth discrete
module (Tau Ceti's `instFactIsSmoothDiscreteTateDual`) and at the trivial module `𝔽_p`
(`instFactIsSmoothDiscreteTrivialFp`). -/

/-- The trivial module `𝔽_p` of `G_F`, Tau Ceti's `trivialFp`, is smooth, as an instance argument
(Tau Ceti's `isSmoothDiscrete_trivialFp`). -/
instance instFactIsSmoothDiscreteTrivialFp (p : ℕ) (F : Type) [Field F] :
    Fact (TauCeti.IsSmoothDiscrete (ZMod p) (TauCeti.trivialFp p (Field.absoluteGaloisGroup F))) :=
  ⟨TauCeti.isSmoothDiscrete_trivialFp p _⟩

/-- **A finite extension of `ℚ_p` carries the `p`-adic valuation.** For a nonarchimedean local
field `F` with a `ℚ_p`-algebra structure of finite degree, no continuity being assumed, the
valuation of `F` restricts to the `p`-adic valuation of `ℚ_p`, as valuative relations. Route: by
Hensel's lemma every element of `1 + pℤ_p` is an `n`-th power for every `n` prime to `p`, so its
image has trivial value in the infinite cyclic value group of `F`; hence so has every unit of
`ℤ_p`, while `p = 1 + (p - 1)` gets value `≤ 1`, and value `1` would make the valuation trivial on
`ℚ_p`, hence on the algebraic extension `F`. This is the compatibility `ValuativeExtension ℚ_[p] F`
that Tau Ceti's Euler characteristic and cyclotomic normalization assume (its `finite_H` and local
duality need only `CharZero F`), and it is what lets `eulerCharacteristic_finrank_fp` and
`cyclotomicCharacter_artinMap` below omit it. -/
theorem algebraMap_vle_algebraMap_iff_of_finite_padic (p : ℕ) [Fact p.Prime] (F : Type)
    [Field F] [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (a b : ℚ_[p]) :
    algebraMap ℚ_[p] F a ≤ᵥ algebraMap ℚ_[p] F b ↔ a ≤ᵥ b :=
  sorry

/-- The `𝔽_p` Euler-characteristic formula consumed by `LocalGaloisGroups`, for a finite smooth
discrete module: `dim H¹ = dim H⁰ + dim H² + [F : ℚ_p] dim A`. Tau Ceti's
`eulerCharacteristic_finrank_fp`, whose `FinitePadicExtension` hypothesis is assembled from
`algebraMap_vle_algebraMap_iff_of_finite_padic`. The cardinality form is Tau Ceti's
`eulerCharacteristic_mixed`. -/
theorem eulerCharacteristic_finrank_fp (p : ℕ) [Fact p.Prime]
    (F : Type) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (A : GalRep p F) (hA : Finite A.V) [Fact (TauCeti.IsSmoothDiscrete (ZMod p) A)] :
    Module.finrank (ZMod p) (H p F 1 A)
      = Module.finrank (ZMod p) (H p F 0 A)
        + Module.finrank (ZMod p) (H p F 2 A)
        + Module.finrank ℚ_[p] F * Module.finrank (ZMod p) A.V := by
  have : ValuativeExtension ℚ_[p] F :=
    ⟨fun {a b} => algebraMap_vle_algebraMap_iff_of_finite_padic p F a b⟩
  exact TauCeti.ClassFieldTheory.eulerCharacteristic_finrank_fp p F A hA

/-! ## Layer 6: the local class formation and finite local reciprocity

The local class formation is Tau Ceti's; its invariant is `invMap` after inflation (Tau Ceti's
`localClassFormation_inv`), the finite reciprocity maps are Tau Ceti's `localArtinEquiv` and
`localArtinMap`, the unramified normalization is `localArtinMap_uniformizer` and
`localArtinMap_eq_frobenius_pow_valuation`, and `H³(G_K, (Kˢ)ˣ) = 0` is
`subsingleton_h3_unitsRep`. -/

/-- **Frozen public name.** `normResidue` is the multiplicative form of `localArtinEquiv` for the
canonical embedding of `L` into the separable closure; it is not a second construction. -/
noncomputable abbrev normResidue [Algebra K L] [Module.Finite K L] [IsGalois K L] :
    (Kˣ ⧸ TauCeti.normGroup K L) ≃* Abelianization (L ≃ₐ[K] L) :=
  TauCeti.ClassFieldTheory.normResidue K L

/-- **`scd_ℓ G_K = 2`** for every prime `ℓ` and every finite extension `K/ℚ_p` (NSW (7.2.5)): Tau
Ceti's `strictCohomologicalDimensionAt_absoluteGaloisGroup_eq_two`. The ordinary dimension
`cd_ℓ G_K = 2` is Tau Ceti's `cohomologicalDimensionAt_absoluteGaloisGroup_eq_two`. -/
theorem scd_p_absoluteGaloisGroup_eq_two (p : ℕ) [Fact p.Prime] [Algebra ℚ_[p] K]
    [Module.Finite ℚ_[p] K] (ℓ : ℕ) [Fact ℓ.Prime] :
    TauCeti.strictCohomologicalDimensionAt.{0} ℓ (Field.absoluteGaloisGroup K) = 2 :=
  haveI : CharZero K := charZero_of_injective_algebraMap (algebraMap ℚ_[p] K).injective
  TauCeti.ClassFieldTheory.strictCohomologicalDimensionAt_absoluteGaloisGroup_eq_two ℓ

/-! ## Layer 7: the absolute local Artin map, its normalizations, and conductors -/

/-- **Frozen public name.** The local Artin map into the topological abelianization of the absolute
Galois group, normalized by arithmetic Frobenius: Tau Ceti's `artinMap`. It is pinned by three
equations stated against named maps: Tau Ceti's `artinMap_restrict` (against the restriction
`restrictAbsolute`), Tau Ceti's `unramifiedCoordinate_artinMap` (against Tau Ceti's
`unramifiedCoordinate`) and `artinMap_norm` (against `absoluteGaloisGroupExtend`). It has dense
image and is not surjective. -/
noncomputable abbrev artinMap (K : Type) [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] : Kˣ →* Field.absoluteGaloisGroupAbelianization K :=
  TauCeti.ClassFieldTheory.artinMap K

/-- **Restriction** of the absolute Galois group to a finite Galois extension embedded by `iota`:
Tau Ceti's restriction along an embedding, `AlgHom.restrictNormalHom`, after
`absoluteGaloisGroupComparison`. It is characterized by
`iota (restrictAbsolute K L iota σ x) = absoluteGaloisGroupComparison K σ (iota x)`, Tau Ceti's
`AlgHom.restrictNormalHom_commutes`. -/
noncomputable abbrev restrictAbsolute [Algebra K L] [Module.Finite K L] [IsGalois K L]
    (iota : L →ₐ[K] SeparableClosure K) : Field.absoluteGaloisGroup K →* (L ≃ₐ[K] L) :=
  iota.restrictNormalHom.comp (absoluteGaloisGroupComparison K).toMulEquiv.toMonoidHom

/-- **The absolute Galois group of a finite extension inside that of `K`**, along a `K`-embedding
`iota` of `L` into `Kˢ`: Tau Ceti's `absoluteGaloisGroupExtend`. Different embeddings give
conjugate maps, which agree after passing to `G_K^ab`. -/
noncomputable abbrev absoluteGaloisGroupExtend [Algebra K L] [Module.Finite K L]
    (iota : L →ₐ[K] SeparableClosure K) :
    Field.absoluteGaloisGroup L →* Field.absoluteGaloisGroup K :=
  TauCeti.absoluteGaloisGroupExtend K L iota

/-- **Norm functoriality of the absolute Artin map**: the image in `G_K^ab` of `Art_L x` is
`Art_K (N_{L/K} x)`. Tau Ceti's `artinMap_norm`. -/
theorem artinMap_norm [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    (iota : L →ₐ[K] SeparableClosure K) (x : Lˣ) (τ : Field.absoluteGaloisGroup L)
    (hτ : (QuotientGroup.mk τ : Field.absoluteGaloisGroupAbelianization L) = artinMap L x) :
    (QuotientGroup.mk (absoluteGaloisGroupExtend K L iota τ) :
        Field.absoluteGaloisGroupAbelianization K) =
      artinMap K (Units.map (Algebra.norm K : L →* K) x) :=
  TauCeti.ClassFieldTheory.artinMap_norm L iota x τ hτ

/-! ### Conductors and unit-filtration reciprocity

The conductor exponent, the conductor ideal and the character conductor are Tau Ceti's
(`conductorExponent`, `conductorIdeal`, `characterConductorExp`), as is the conductor criterion
in the upper numbering, `unitFiltration_le_normGroup_iff_upperRamificationGroup_eq_bot`: for a
finite abelian `M/K` and `v : ℕ`, `U_K^(v) ⊆ N_{M/K}(Mˣ)` exactly when `Gal(M/K)^v = 1`. The two
statements below that name unit-filtration reciprocity are the open targets of this layer. -/

/-- **Unit-filtration reciprocity** (Serre, *Local Fields*, XV §2, Theorem 2). For a finite
abelian `L/K`, in either characteristic, and every depth `n ≥ 0`, the finite reciprocity map
carries the image of `U_K^(n)` onto the upper ramification group `Gal(L/K)^n`, read in the
abelianization. At `n = 0` the image is the inertia group. Route: for every subgroup `H` with
fixed field `M`, the image lies in `H` exactly when `U_K^(n)` consists of norms from `M` (Tau
Ceti's `artinMap_restrict` and the norm kernel), exactly when `Gal(M/K)^n = 1` (Tau Ceti's
`unitFiltration_le_normGroup_iff_upperRamificationGroup_eq_bot`), exactly when `Gal(L/K)^n ≤ H`
(Herbrand's theorem, Tau Ceti's
`LocalFieldsRamification.map_restrictNormalHom_upperRamificationGroup`). -/
theorem map_unitFiltration_normResidue [Algebra K L] [ValuativeExtension K L]
    [Module.Finite K L] [IsAbelianGalois K L] (n : ℕ) :
    (TauCeti.unitFiltration K n).map
        ((normResidue K L).toMonoidHom.comp
          (QuotientGroup.mk' (TauCeti.normGroup K L))) =
      (TauCeti.LocalFieldsRamification.upperRamificationGroup K L
        ⟨(n : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg n)⟩).map
          Abelianization.of :=
  sorry

/-- **The conductor exponent is read off the upper numbering**: for a finite abelian `L/K` it is
the least depth `n` with `Gal(L/K)^n = 1`. A corollary of Tau Ceti's
`conductorExponent_le_iff_upperRamificationGroup_eq_bot`. -/
theorem conductorExponent_eq_sInf_upperRamificationGroup [Algebra K L]
    [ValuativeExtension K L] [Module.Finite K L] [IsAbelianGalois K L] :
    TauCeti.ClassFieldTheory.conductorExponent K L =
      sInf {n : ℕ | TauCeti.LocalFieldsRamification.upperRamificationGroup K L
      ⟨(n : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg n)⟩ = ⊥} := by
  have h (n : ℕ) :=
    TauCeti.ClassFieldTheory.conductorExponent_le_iff_upperRamificationGroup_eq_bot K L (n := n)
  have hmem : TauCeti.ClassFieldTheory.conductorExponent K L ∈
      {n : ℕ | TauCeti.LocalFieldsRamification.upperRamificationGroup K L
        ⟨(n : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg n)⟩ = ⊥} :=
    (h _).1 le_rfl
  exact le_antisymm ((h _).2 (Nat.sInf_mem ⟨_, hmem⟩)) (Nat.sInf_le hmem)

section AbsoluteUpper

attribute [local instance] TauCeti.finiteIntermediateFieldValuativeRel
  TauCeti.finiteIntermediateFieldTopology TauCeti.finiteIntermediateField_isNonarchimedeanLocalField
  TauCeti.finiteIntermediateField_valuativeExtension

/-- **The absolute upper ramification group** `G_K^u` of a nonarchimedean local field, for real
`u ≥ −1`: the `σ ∈ G_K` whose restriction to every finite Galois `M/K` inside `AlgebraicClosure K`
lies in Tau Ceti's finite upper group `Gal(M/K)^u`, each `M` carrying Tau Ceti's local-field
structure on finite intermediate fields; the intersection over `M` of the preimages of the finite
upper groups (Milne, *Class Field Theory*, I §4, the definition after Proposition 4.4). -/
noncomputable def localAbsoluteUpperRamificationGroup
    (u : TauCeti.LocalFieldsRamification.RamificationIndexDomain) :
    Subgroup (Field.absoluteGaloisGroup K) :=
  ⨅ M : FiniteGaloisIntermediateField K (AlgebraicClosure K),
    (TauCeti.LocalFieldsRamification.upperRamificationGroup K M u).comap
      (AlgEquiv.restrictNormalHom (F := K) (K₁ := AlgebraicClosure K) M)

/-- **Unit-filtration reciprocity, absolute form**: for every `n ≥ 0` the closure of
`artinMap (U_K^(n))` in `G_K^ab` is the image of the absolute upper ramification group
`localAbsoluteUpperRamificationGroup K n` (Serre, *Local Fields*, XV §2, Theorem 2 and Corollary 3
to Theorem 1). Both sides are closed subgroups with the same image in every finite abelian quotient
(`map_unitFiltration_normResidue`, `artinMap_restrict` and the finite projections of `G_K^n`), the
image of `G_K^n` being compact. -/
theorem closure_map_artinMap_unitFiltration (n : ℕ) :
    ((TauCeti.unitFiltration K n).map (artinMap K)).topologicalClosure =
      (localAbsoluteUpperRamificationGroup K ⟨n, Nat.cast_mem_ramificationIndexDomain n⟩).map
        (QuotientGroup.mk' (commutator (Field.absoluteGaloisGroup K)).topologicalClosure) :=
  sorry

end AbsoluteUpper

/-! ### The cyclotomic normalization

Tau Ceti proves `χ_cyc(Art_F(u)) = N_{F/ℚ_p}(u)⁻¹` by comparison with the explicit local symbols of
the cyclotomic fields over `ℚ` (`localCyclotomicCharacter_artinMap_padic_uniformizer`,
`localCyclotomicCharacter_artinMap_padic`, `localCyclotomicCharacter_artinMap_unit`); the three
statements below are those theorems under this roadmap's names, read through Mathlib's
`cyclotomicCharacter` (`TauCeti.localCyclotomicCharacter_apply`). -/

section CyclotomicNormalization

/-- **The uniformizer of `ℚ_p`**: `χ_cyc(Art_{ℚ_p}(p)) = 1`. Tau Ceti's
`localCyclotomicCharacter_artinMap_padic_uniformizer`. -/
theorem cyclotomicCharacter_artinMap_padic_uniformizer (p : ℕ) [Fact p.Prime]
    [IsNonarchimedeanLocalField ℚ_[p]] (σ : Field.absoluteGaloisGroup ℚ_[p])
    (hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[p])
      = artinMap ℚ_[p]
          (Units.mk0 (p : ℚ_[p]) (Nat.cast_ne_zero.mpr (Fact.out : p.Prime).ne_zero))) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[p]) p σ.toRingEquiv = 1 :=
  TauCeti.ClassFieldTheory.localCyclotomicCharacter_artinMap_padic_uniformizer p σ hσ

/-- **The cyclotomic normalization at `ℚ_p`**: `χ_cyc(Art_{ℚ_p}(u)) = u⁻¹` for `u ∈ ℤ_pˣ`. Tau
Ceti's `localCyclotomicCharacter_artinMap_padic`. -/
theorem cyclotomicCharacter_artinMap_padic (p : ℕ) [Fact p.Prime]
    [IsNonarchimedeanLocalField ℚ_[p]] (u : ℤ_[p]ˣ)
    (σ : Field.absoluteGaloisGroup ℚ_[p])
    (hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization ℚ_[p])
      = artinMap ℚ_[p] (Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom u)) :
    cyclotomicCharacter (AlgebraicClosure ℚ_[p]) p σ.toRingEquiv = u⁻¹ :=
  TauCeti.ClassFieldTheory.localCyclotomicCharacter_artinMap_padic p u σ hσ

/-- **Cyclotomic orientation with the required field norm**: for `F/ℚ_p` finite and a unit `u`,
`χ_cyc(Art_F(u)) = N_{F/ℚ_p}(u)⁻¹`. Tau Ceti's `localCyclotomicCharacter_artinMap_unit`, whose
compatibility hypothesis `ValuativeExtension ℚ_[p] F` is supplied by
`algebraMap_vle_algebraMap_iff_of_finite_padic`. -/
theorem cyclotomicCharacter_artinMap (p : ℕ) [Fact p.Prime]
    (F : Type) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (u : Fˣ) (hu : ValuativeRel.valuation F (u : F) = 1)
    (σ : Field.absoluteGaloisGroup F)
    (hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization F) = artinMap F u) :
    Units.map (algebraMap ℤ_[p] ℚ_[p]).toMonoidHom
        (cyclotomicCharacter (AlgebraicClosure F) p σ.toRingEquiv)
      = (Units.map (Algebra.norm ℚ_[p] : F →* ℚ_[p]) u)⁻¹ := by
  have : ValuativeExtension ℚ_[p] F :=
    ⟨fun {a b} => algebraMap_vle_algebraMap_iff_of_finite_padic p F a b⟩
  exact TauCeti.ClassFieldTheory.localCyclotomicCharacter_artinMap_unit p F u hu σ hσ

end CyclotomicNormalization

end Local

section Global

variable (K : Type) [Field K] [NumberField K]
variable (L : Type) [Field L] [NumberField L] [Algebra K L]

/-! ## Layers 10 to 12: idele carriers, global reciprocity and global existence

The Brauer sequence, the global class formation, global reciprocity and global existence are Tau
Ceti's at the pin, including the source `GlobalNormSubgroups` of the global correspondence and the
class field `globalClassField` it defines. This file names the idele carriers on which the Hasse
norm theorem is stated, and the norm index `card_ideleClassNormQuotient`.

⚠ Everything here is for a **number field**: the carriers are Mathlib's number-field idele and
idele-class groups, and the section's `NumberField K` hypothesis is load-bearing. -/

/-- **Principal ideles**: `Fˣ` embedded diagonally in Mathlib's idele group
`NumberField.IdeleGroup (𝓞 F) F`, the units of the adele ring: Mathlib's
`NumberField.IdeleGroup.unitEmbedding`, the map on which Tau Ceti's `cyclicHasseNorm` is stated. -/
noncomputable abbrev principalIdele (F : Type) [Field F] [NumberField F] :
    Fˣ →* NumberField.IdeleGroup (𝓞 F) F :=
  NumberField.IdeleGroup.unitEmbedding (𝓞 F) F

/-- The norm on ideles of a finite extension: Tau Ceti's
`TauCeti.GlobalNumberFields.ideleNormMap`. -/
noncomputable def ideleNormMap [Module.Finite K L] :
    NumberField.IdeleGroup (𝓞 L) L →* NumberField.IdeleGroup (𝓞 K) K :=
  (TauCeti.GlobalNumberFields.ideleNormMap K L).toMonoidHom

/-- The induced norm on idele classes: Tau Ceti's
`TauCeti.GlobalNumberFields.ideleClassNormMap`. -/
noncomputable def ideleClassNorm [Module.Finite K L] :
    NumberField.IdeleClassGroup (𝓞 L) L →* NumberField.IdeleClassGroup (𝓞 K) K :=
  (TauCeti.GlobalNumberFields.ideleClassNormMap K L).toMonoidHom

/-- The norm-index theorem for finite abelian extensions: `[C_K : N C_L] = [L:K]`. Tau Ceti's
`card_ideleClassNormQuotient`. -/
theorem card_ideleClassNormQuotient [Module.Finite K L] [IsAbelianGalois K L] :
    Nat.card (NumberField.IdeleClassGroup (𝓞 K) K ⧸ (ideleClassNorm K L).range) =
      Module.finrank K L :=
  TauCeti.ClassFieldTheory.card_ideleClassNormQuotient K L

/-! ## Layer 13: norm theorems and class fields -/

/-- **Frozen public name.** For a cyclic extension, being a global norm is equivalent to the
principal idele being an idele norm, hence to being a norm at every place. Tau Ceti's
`cyclicHasseNorm`. -/
theorem cyclicHasseNorm [Module.Finite K L] [IsGalois K L]
    [IsCyclic (L ≃ₐ[K] L)] (x : Kˣ) :
    (∃ y : Lˣ, Units.map (Algebra.norm K : L →* K) y = x) ↔
      principalIdele K x ∈ MonoidHom.range (ideleNormMap K L) :=
  TauCeti.ClassFieldTheory.cyclicHasseNorm K L x

/-- A principal element is a norm at the finite place `v`, on the finite local étale algebra
`K_v ⊗_K L`: Tau Ceti's `TauCeti.GlobalNumberFields.IsFiniteLocalNorm`. -/
abbrev IsFiniteLocalNorm [Module.Finite K L]
    (v : HeightOneSpectrum (RingOfIntegers K)) (x : Kˣ) : Prop :=
  TauCeti.GlobalNumberFields.IsFiniteLocalNorm K L v x

/-- A principal element is a norm at the infinite place `w`, on Mathlib's completion and the
étale algebra `K_w ⊗_K L`: Tau Ceti's `TauCeti.GlobalNumberFields.IsInfiniteLocalNorm`. -/
abbrev IsInfiniteLocalNorm [Module.Finite K L]
    (w : NumberField.InfinitePlace K) (x : Kˣ) : Prop :=
  TauCeti.GlobalNumberFields.IsInfiniteLocalNorm K L w x

/-- Placewise spelling of “a norm everywhere”: every finite and every archimedean completion
occurs explicitly. Tau Ceti's `TauCeti.GlobalNumberFields.IsLocalNormEverywhere`. -/
abbrev IsLocalNormEverywhere [Module.Finite K L] (x : Kˣ) : Prop :=
  TauCeti.GlobalNumberFields.IsLocalNormEverywhere K L x

/-- The cyclic Hasse norm theorem in the local-norm spelling used by quadratic-form consumers: Tau
Ceti's `isGlobalNorm_iff_isLocalNormEverywhere`. -/
theorem isGlobalNorm_iff_isLocalNormEverywhere [Module.Finite K L] [IsGalois K L]
    [IsCyclic (L ≃ₐ[K] L)] (x : Kˣ) :
    (∃ y : Lˣ, Units.map (Algebra.norm K : L →* K) y = x) ↔
      IsLocalNormEverywhere K L x :=
  TauCeti.ClassFieldTheory.isGlobalNorm_iff_isLocalNormEverywhere K L x

/-! ### The named class fields

Every class field named below is a value of `classField` at a value of `globalClassField`: none of
them is an independent construction. What each one contributes is its own *norm subgroup*, after
which the field, its Galois group and its degree come from Layer 12. -/

/-- **The principal ideal theorem** (Furtwängler; Artin–Tate, *Class Field Theory*, XIII §4):
every ideal of `𝓞 K` becomes principal in the ring of integers of the Hilbert class field
`hilbertClassField K`. Through reciprocity for the Hilbert class field of the Hilbert class field,
extension of ideals is the transfer to the commutator subgroup, which is trivial; the abstract
form is Tau Ceti's `ClassFormation.groundInclusion_mem_normSubgroup_of_range_eq_commutator`. -/
theorem isPrincipal_map_hilbertClassField (I : Ideal (𝓞 K)) :
    (I.map (algebraMap (𝓞 K) (𝓞 (TauCeti.ClassFieldTheory.hilbertClassField K)))).IsPrincipal :=
  sorry

/-- **The conductor–discriminant formula**: for a finite abelian extension `L/K` of number fields,
the relative discriminant `relDiscr (𝓞 K) (𝓞 L)` is the product, over the characters `χ` of
`Gal(L/K)`, of the finite part of the conductor `abelianConductor` of the fixed field of `ker χ`,
the cyclic extension cut out by `χ`. Its local form, the sum of the Artin conductor exponents
being the discriminant exponent, is Tau Ceti's
`LocalFieldsRamification.finsum_artinConductorExponent_eq_discriminantExponent`. -/
theorem relDiscr_eq_finprod_abelianConductor [IsAbelianGalois K L] :
    TauCeti.relDiscr (𝓞 K) (𝓞 L) =
      ∏ᶠ χ : (L ≃ₐ[K] L) →* ℂˣ,
        (TauCeti.ClassFieldTheory.abelianConductor K
          (IntermediateField.fixedField χ.ker)).finitePart :=
  sorry

/-- **The ring class field of an order `O` of a number field `K`**: Tau Ceti's `ringClassField`,
the class field of Tau Ceti's `ringClassNormSubgroup`. It is defined for every order in every
number field; at the maximal order it is the Hilbert class field, because there the kernel of
`ringClassIdeleQuotient` is the ray subgroup of the trivial modulus (Tau Ceti's
`ker_ringClassIdeleQuotient_maximalNumberFieldOrder`). -/
noncomputable abbrev ringClassField (O : TauCeti.GlobalNumberFields.NumberFieldOrder K) :
    IntermediateField K (SeparableClosure K) :=
  TauCeti.ClassFieldTheory.ringClassField O

/-- **The ideal form of reciprocity for a ring class field**, on the invertible proper fractional
ideals of the order: Tau Ceti's `ringClassArtinMap`, `I ↦ ringClassArtinEquiv (O.mkPic I)`, with
principal-kernel criterion `ringClassArtinMap_eq_one_iff`. -/
noncomputable abbrev ringClassArtinMap (O : TauCeti.GlobalNumberFields.NumberFieldOrder K) :
    O.invertibleProperFractionalIdeals →* (ringClassField K O ≃ₐ[K] ringClassField K O) :=
  TauCeti.ClassFieldTheory.ringClassArtinMap O

/-- **Reciprocity identifies the Galois group of the ring class field with the Picard group of the
order**: the inverse of Tau Ceti's canonical equivalence `ringClassArtinEquiv`, the inverse of the
quotient-kernel equivalence followed by global reciprocity. -/
noncomputable abbrev gal_ringClassField_equiv_pic
    (O : TauCeti.GlobalNumberFields.NumberFieldOrder K) :
    (ringClassField K O ≃ₐ[K] ringClassField K O) ≃* TauCeti.GlobalNumberFields.Pic O :=
  (TauCeti.ClassFieldTheory.ringClassArtinEquiv O).symm

/-! ## Layer 14: Hilbert reciprocity

The Hilbert invariants are Tau Ceti's: at a finite place the local Hilbert symbol at `ζ = -1` of
the completion, at an infinite place the local Brauer invariant, and the finite support the places
where the finite invariant can be nonzero. -/

/-- **The Hilbert invariant at a finite place** `v`: Tau Ceti's `finiteHilbertInvariantAt`, the
local Hilbert symbol of the images of `a, b ∈ Kˣ` in the completion `K_v`, at the primitive square
root `-1`, read in the arithmetic coordinate of `H²(K_v, μ₂)`. -/
noncomputable abbrev finiteHilbertInvariantAt (v : HeightOneSpectrum (𝓞 K)) (a b : Kˣ) : ZMod 2 :=
  TauCeti.ClassFieldTheory.finiteHilbertInvariantAt K v a b

/-- **The Hilbert invariant at an infinite place** `w`: Tau Ceti's `infiniteHilbertInvariantAt`,
the Brauer invariant at `w` of the quaternion class of `(a, b)`, which is `1` exactly when `w` is
real and both `a` and `b` are negative there. -/
noncomputable abbrev infiniteHilbertInvariantAt (w : InfinitePlace K) (a b : Kˣ) : ZMod 2 :=
  TauCeti.ClassFieldTheory.infiniteHilbertInvariantAt K w a b

/-- **The support of the finite Hilbert invariants** of `a, b ∈ Kˣ`: Tau Ceti's
`finiteHilbertSupport`, a finite set of places outside which every finite invariant vanishes. -/
noncomputable abbrev finiteHilbertSupport (a b : Kˣ) : Finset (HeightOneSpectrum (𝓞 K)) :=
  TauCeti.ClassFieldTheory.finiteHilbertSupport K a b

/-- **Frozen public name.** Hilbert reciprocity in additive cohomological form: Tau Ceti's
`hilbertProductFormula`. The multiplicative translation is the product of all local signs being
`1`. -/
theorem hilbertProductFormula (a b : Kˣ) :
    (∑ v ∈ finiteHilbertSupport K a b, finiteHilbertInvariantAt K v a b) +
        ∑ w : InfinitePlace K, infiniteHilbertInvariantAt K w a b = 0 :=
  TauCeti.ClassFieldTheory.hilbertProductFormula a b

end Global

end TauCetiRoadmap.ClassFieldTheory
