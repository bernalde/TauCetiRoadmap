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
# Class field theory: class formations, Tate's theorem, Artin reciprocity, and their consequences

The normative roadmap is `README.md`. This file is an acceptance test of suggested forms, not an
exhaustive checklist: it names under this roadmap's names the Tau Ceti declarations that other
roadmaps consume from it, and it states, on Mathlib's and Tau Ceti's own carriers, the targets
whose Lean form the roadmap fixes and that are open at the Tau Ceti pin. `sorry` marks an open target, never a
definition: every definition, abbreviation and instance below has a body, and every alias of a
Tau Ceti theorem is a closed proof.

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

The fourteen numbered items of `README.md`, *Scope and ownership*, are realized as follows.

1. Tate's theorem: `tateTheorem` and its class-formation form `ClassFormation.tateIso`; the
   restriction, corestriction, tower, conjugation and inflation compatibilities are Tau Ceti's
   `ClassFormation.tateIso_res`, `ClassFormation.tateIso_cor`, `ClassFormation.tateIso_res_trans`,
   `ClassFormation.tateIso_conj` and `ClassFormation.tateIso_infl`; the Tate–Nakayama theorem is
   `TauCeti.TateCohomology.cup_bijective_of_forall_isPGroup_of_lTensor_injective`.
2. Finite Artin reciprocity: `ClassFormation.nakayamaNegTwo`, `artinEquiv` and `artinMap`,
   definitionally the inverse of cup product with the fundamental class; its norm kernel and
   surjectivity are Tau Ceti's `ker_artinMap` and `surjective_artinMap`.
3. Functoriality: Tau Ceti's `ClassFormation.artinMap_groundInclusion`, `artinMap_groundNorm`,
   `artinMap_quotient` and, here, `artinMap_conj`; the character formula `character_artinMap`.
4. The local Brauer group and the Hilbert symbol: `Br`, `invMap`, `invMap_brRes`, `invMap_brCor`;
   the symbol `localSymbol` at a supplied coordinate and the arithmetic symbol
   `localHilbertSymbol` at the coordinate `invCoordinate`; its laws are Tau Ceti's
   `localSymbol_kummerClass_mul`, `localSymbol_antisymm`, `localSymbol_eq_zero_iff_mem_normGroup`,
   `forall_localSymbol_kummerClass_eq_zero_iff` and the Steinberg relation
   `localSymbol_kummerClass_eq_zero_of_add_eq_one`.
5. Local duality: `finite_H`, `tateDualityPairing_perfect_mixed`, Tau Ceti's
   `eulerCharacteristic_mixed`, and `eulerCharacteristic_finrank_fp`.
6. Local reciprocity and its normalizations: `localClassFormation`, `localArtinEquiv`,
   `normResidue`, Tau Ceti's `localArtinMap_uniformizer`,
   `cohomologicalDimensionAt_absoluteGaloisGroup_eq_two` and here
   `scd_p_absoluteGaloisGroup_eq_two`; the absolute `artinMap` with `artinMap_restrict`,
   `unramifiedCoordinate_artinMap`, `artinMap_norm` and `cyclotomicCharacter_artinMap`; the open
   targets `map_unitFiltration_normResidue`, `sup_norm_unitFiltration_eq_of_upper_eq_top` and
   `closure_map_artinMap_unitFiltration`, and the corollary
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
    `exists_abelianLayer_globalNormSubgroup_eq_of_pow_mem`; here `GlobalNormSubgroups`,
    `globalClassField` and `card_ideleClassNormQuotient`.
13. Norm theorems and class fields: here `cyclicHasseNorm`,
    `isGlobalNorm_iff_isLocalNormEverywhere`, `ringClassField` for every order of every number
    field with `ringClassArtinMap` and `gal_ringClassField_equiv_pic`, and the open targets
    `isPrincipal_map_hilbertClassField` (the principal ideal theorem),
    `relDiscr_eq_finprod_abelianConductor` (the conductor–discriminant formula) and
    `ringClassField_maximal`; Tau Ceti's `unitEmbedding_mem_range_ideleNormMap_iff`,
    `rayClassField`, `hilbertClassField`, `narrowHilbertClassField`,
    `gal_rayClassField_equiv_rayClassGroup`, `IsAdmissibleModulus`, `abelianConductor`,
    `rayClassArtinMap` and `kroneckerWeber`.
14. Hilbert reciprocity: `finiteHilbertInvariantAt`, `infiniteHilbertInvariantAt`,
    `finiteHilbertSupport`, `hilbertProductFormula`. Quadratic reciprocity is Mathlib's
    `legendreSym.quadratic_reciprocity`.

## Tau Ceti declarations named by `README.md`

Besides the names above, `README.md` names these Tau Ceti declarations, which this file consumes
or leaves to Tau Ceti and does not restate. The formation machinery of Layers 1 and 2
(`TauCeti.ClassFieldTheory.Formation`, `NormalLayer`, `LayerRestriction`, `LayerRefinement`,
`ClassFormation`, `cupClass`, `ClassFormation.cupFundamentalClass`); Layer 0's
`Rep.isZero_res_of_projective`, `Rep.projective_of_isZero_res`, `Rep.isZero_res_of_exact`,
`Rep.projective_ker_of_isZero_res`, `Submodule.free_of_isPrincipalIdealRing` and
`TauCeti.TateCohomology.primaryComponent_tateCohomology_eq_bot`; the comparison
`TauCeti.absoluteGaloisGroupRestrictEquiv`; `TauCeti.ClassFieldTheory.classField`; the coefficient
objects `muNRep`, `unitsRep`, `tateDual`, `tateDualEquiv`, `tateEvaluationPairing`,
`tateDualMap`, `tateDual_ρ_eq_self_iff`, `muNRepToTateDual`, `bijective_muNRepToTateDual` and
`tateDualityPairing_muNRepToTateDual`; the Kummer equivalence `kummerEquiv` with
`kummerEquiv_ofMul_mk`; the coordinates `h2MuEquivZMod` and `h2EquivZModOfMuNRepIso`;
`herbrandQuotient_units_eq_finrank`, `herbrandQuotient_unitFiltration_zero` and
`index_normGroup_of_isCyclic`; `localClassFormation_inv`, `localFormationRestrict`,
`localArtinMap_eq_frobenius_pow_valuation` and `subsingleton_h3_unitsRep`; the explicit
cyclotomic symbols `cyclotomicSymbol`, `realCyclotomicSymbol`, `prod_cyclotomicSymbol` and
`cyclotomicSymbol_norm_fixes`; `localCyclotomicCharacter_artinMap_padic`,
`localCyclotomicCharacter_artinMap_padic_uniformizer` and
`localCyclotomicCharacter_artinMap_unit`; the norm theorems
`map_normUnits_unitFiltration_psiNat_eq_of_upperRamificationGroup_eq_bot` and
`map_normUnits_unitFiltration_psiNat_le`; Herbrand's `upperRamificationGroup_quotient`,
`upperRamificationGroup_fixedField` and `psiNat`; `LocalFieldsRamification.hasseArf`;
`conductorExponent`, `conductorIdeal`, `characterConductorExp`; the idele norms
`TauCeti.GlobalNumberFields.ideleNormMap` and `ideleClassNormMap`; the local norm predicates
`TauCeti.GlobalNumberFields.IsFiniteLocalNorm`, `IsInfiniteLocalNorm` and `IsLocalNormEverywhere`;
the ring-class quotient `ringClassIdeleQuotient`, `ringClassArtinEquiv` and
`ringClassArtinMap_eq_one_iff`; the global norm subgroup `globalNormSubgroup`;
`ClassFormation.groundInclusion_mem_normSubgroup_of_range_eq_commutator`;
`TauCeti.relDiscr`; and `TauCeti.card_powerClasses`.

The frozen interface also contains these Tau Ceti declarations, consumed by name:
`ClassFormation.artinMap_trivialLayer`, `artinMap_congr`, `artinMap_eq_zero_iff`,
`globalClassField_index`, `globalClassField_le_iff`, `globalClassField_normSubgroup`,
`globalClassField_orderReversing`, `kummerCupPairing_bil_comm`, `localArtinEquiv_eq_of_iota`,
`localArtinMap_Q2_zeta5`, `localArtinMap_cyclotomic_uniformizer`,
`localArtinMap_quadratic_eq_hilbertSymbol`, `localArtinMap_quadratic_eq_nontrivial_iff_not_norm`,
`muNRepEquivZMod_generator`, `normResidue_uniformizer`, `tateDualityPairing_tateDualMap`,
`unramifiedCoordinate_mk_eq_gen_iff`, `unramifiedCoordinate_mk_eq_one_iff`,
`unramifiedCoordinate_weilDegree`, `herbrandQuotient_ideleClassRep_eq_finrank`,
`degree_le_natCard_normQuotient_of_isCyclic`, `natCard_H2_globalFormation_dvd_degree`,
`range_globalInv`, `kummerLayer`, `globalNormSubgroup_kummerLayer_sUnits`,
`inertiaSubgroup_le_localWeilGroup`, `isAdmissibleModulus_ringClassField`,
`ncard_primesOver_ringClassField_eq_finrank_iff` and `maximalNumberFieldOrder`.
-/

namespace TauCetiRoadmap.ClassFieldTheory

open CategoryTheory NumberField IsDedekindDomain
open scoped MonoidalCategory nonZeroDivisors ValuativeRel TensorProduct
open TauCeti.ClassFieldTheory hiding ClassFormation

/-! ## Preliminaries: the invariant target `ℚ/ℤ`

Tau Ceti's `ClassFormation` writes `ℚ/ℤ` as the rational circle `AddCircle (1 : ℚ)`, its subgroup
of order `n` as the `n`-torsion `AddSubgroup.torsionBy`, and the invariant of the fundamental class
of a layer of degree `n` as the class of `1/n`. The three abbreviations below name these for the
arithmetic columns; they are Tau Ceti's conventions, not a second normalization. -/

/-- The target `ℚ/ℤ` of the class-formation invariant: Tau Ceti's `AddCircle (1 : ℚ)`. -/
abbrev RatModInt : Type := AddCircle (1 : ℚ)

/-- The subgroup of elements of `ℚ/ℤ` killed by `n`: the image of the invariant of a layer of
degree `n` (Tau Ceti's `ClassFormation.range_inv`). -/
abbrev ratModIntTorsion (n : ℕ) : AddSubgroup RatModInt :=
  AddSubgroup.torsionBy RatModInt n

/-- The class of `1/n` in `ℚ/ℤ`: the invariant of the fundamental class of a layer of degree `n`
(Tau Ceti's `ClassFormation.inv_fundamentalClass`). -/
abbrev fundamentalInvariant (n : ℕ) : RatModInt :=
  ((1 / n : ℚ) : AddCircle (1 : ℚ))

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

/-! ## Layers 1 and 2: formations, finite normal layers, and class formations

Layers 1 and 2 are implemented in Tau Ceti, in `TauCeti/NumberTheory/ClassFieldTheory/Formation/`,
and are consumed here under Tau Ceti's names; none of them is restated.

* The formation `Formation G` is Tau Ceti's `SmoothDiscreteTopRep ℤ G` on a profinite `G`, with its
  levels `Formation.level` (submodules of the ambient module).
* A finite normal layer `NormalLayer G` has its Galois group `Gal`, `degree`, coefficient module
  `rep`, cohomology carriers `H`, `TateH` and `TrivialTateH`, norm `norm`, `normSubgroup`,
  `NormQuotient` and `normQuotientMk`; the layers `ofOpenNormal` of open normal subgroups; the
  finite quotient system `subgroupLayer`, `subgroupGalEquiv`, `subgroupRestriction`,
  `degree_subgroupLayer` and `relativeDegree_subgroupRestriction`; the low Tate degrees `tateHIsoH`,
  `tateHMinusTwoEquivAbelianization`, `tateHZeroEquivNormQuotient` and `zeroTateClass`; and
  conjugation `conjugate`, `conjugateCohomologyIso`, `conjugateTateIso`,
  `conjugateGroundLevelEquiv` and `conjugateGalEquiv`.
* A restriction `LayerRestriction` has its `relativeDegree`, `cohomologyRes`, `cohomologyCor`,
  `tateRes`, `tateCor`, `trivialTateRes`, `trivialTateCor`, `groundInclusion`, `groundNorm`,
  `transferHom` and `inclusionHom`, the normalization `cohomologyCor_cohomologyRes` and
  `tateCor_tateRes`, and the tower laws `trans`, `relativeDegree_trans`, `cohomologyRes_trans`,
  `cohomologyCor_trans`, `tateRes_trans` and `tateCor_trans`.
* A refinement `LayerRefinement` has its `relativeDegree`, `cohomologyInfl`, `tateInfl`,
  `groundEquiv` and `quotientHom`, the tower laws `trans`, `relativeDegree_trans` and
  `cohomologyInfl_trans`, and `exists_commonRefinement`.
* The abelian layers are `AbelianLayer`, with `isMulCommutative_gal_ofOpenNormal` and
  `abelianizationGalEquiv`.
* A class formation `ClassFormation F` carries its invariant map as data (`subsingleton_h1`, `inv`,
  `inv_injective`, `range_inv`, `inv_restrict`, `inv_infl`, `inv_conj`), and derives
  `fundamentalClass` with `inv_fundamentalClass`, `fundamentalClass_generates`,
  `fundamentalClass_restrict`, `fundamentalClass_infl`, `fundamentalClass_conj`, `inv_cor`,
  `fundamentalClass_cor`, `tateFundamentalClass`, the three hypotheses of Tate's theorem
  `h1_subgroupLayer`, `card_H2_subgroupLayer` and `fundamentalClass_restrict_generates`, and the
  cyclic norm index `natCard_normQuotient`.
* The cup product with a class of `H²` is `cupClass`, and with the fundamental class
  `ClassFormation.cupFundamentalClass`.

Tate's theorem and the Artin constructions of Layers 3 and 4 are also Tau Ceti's; the aliases
below retain their public roadmap names. -/

/-- **Tau Ceti's class formation**, `TauCeti.ClassFieldTheory.ClassFormation`, re-exported so that
the targets of Layers 3 and 4 (Tate's theorem for the class formation, the Nakayama map, the Artin
equivalence and the Artin map) are stated as its methods, `cf.tateIso` and `cf.artinMap`. It is an
abbreviation: every field and theorem of Tau Ceti's structure applies to it by name. -/
abbrev ClassFormation {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] (F : Formation G) :=
  TauCeti.ClassFieldTheory.ClassFormation F

/-! ### Abelian layers and the maximal abelian sublayer

An open normal subgroup with the right norm subgroup is not yet *the* class field attached to that
subgroup. A nonabelian layer and its maximal abelian sublayer have the **same** norm subgroup
(Tau Ceti's `ClassFormation.normSubgroup_maximalAbelianLayer`), so `∃ V, normSubgroup V = N` alone
determines nothing; the class-field correspondence is a bijection only after the Galois side is cut
down to the layers whose finite quotient is abelian.

⚠ The carrier of that condition is the closed commutator subgroup
`(commutator G).topologicalClosure`, the subgroup Mathlib's `TopologicalAbelianization` and
`Field.absoluteGaloisGroupAbelianization` already quotient by. The algebraic `commutator G` is the
wrong subgroup for a profinite `G`: it need not be closed.

The predicate, its carrier `AbelianLayer` and the maximal abelian sublayer are Tau Ceti's
(`OpenNormalSubgroup.IsAbelianClassFieldLayer`, `TauCeti.ClassFieldTheory.AbelianLayer`,
`OpenNormalSubgroup.maximalAbelianLayer`); they are consumed here under the names the rest of
this file uses, and the theorems below are Tau Ceti's proofs, applied. -/

/-- An open normal subgroup cuts out an **abelian layer** when it contains the closed commutator
subgroup — equivalently, when its finite quotient is commutative
(`isAbelianClassFieldLayer_iff_isMulCommutative`). Tau Ceti's
`OpenNormalSubgroup.IsAbelianClassFieldLayer`. -/
abbrev IsAbelianClassFieldLayer {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (V : OpenNormalSubgroup G) : Prop :=
  V.IsAbelianClassFieldLayer

section AbelianLayer

variable {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]

/-- The finite-quotient form of the condition. -/
theorem isAbelianClassFieldLayer_iff_isMulCommutative (V : OpenNormalSubgroup G) :
    IsAbelianClassFieldLayer V ↔ IsMulCommutative (G ⧸ V.toSubgroup) :=
  V.isAbelianClassFieldLayer_iff_isMulCommutative

/-- **The maximal abelian sublayer**, canonically: the join `V · [G,G]‾`. It is a join of two named
subgroups and never "some abelian layer with the same norm subgroup". Tau Ceti's
`OpenNormalSubgroup.maximalAbelianLayer`. -/
abbrev maximalAbelianLayer (V : OpenNormalSubgroup G) : OpenNormalSubgroup G :=
  V.maximalAbelianLayer

@[simp]
theorem toSubgroup_maximalAbelianLayer (V : OpenNormalSubgroup G) :
    (maximalAbelianLayer V).toSubgroup = V.toSubgroup ⊔ (commutator G).topologicalClosure :=
  V.toSubgroup_maximalAbelianLayer

theorem le_maximalAbelianLayer (V : OpenNormalSubgroup G) : V ≤ maximalAbelianLayer V :=
  V.le_maximalAbelianLayer

theorem isAbelianClassFieldLayer_maximalAbelianLayer (V : OpenNormalSubgroup G) :
    IsAbelianClassFieldLayer (maximalAbelianLayer V) :=
  V.isAbelianClassFieldLayer_maximalAbelianLayer

/-- Maximality, in subgroup form: `maximalAbelianLayer V` is the smallest abelian layer above `V`,
so in field language the largest abelian subextension of the extension cut out by `V`. -/
theorem maximalAbelianLayer_le {V W : OpenNormalSubgroup G} (hVW : V ≤ W)
    (hW : IsAbelianClassFieldLayer W) : maximalAbelianLayer V ≤ W :=
  OpenNormalSubgroup.maximalAbelianLayer_le hVW hW

theorem maximalAbelianLayer_eq_self_iff (V : OpenNormalSubgroup G) :
    maximalAbelianLayer V = V ↔ IsAbelianClassFieldLayer V :=
  V.maximalAbelianLayer_eq_self_iff

end AbelianLayer

/-! ## Layer 3: Tate's theorem (Artin–Tate's Main Theorem)

⚠ Tate's theorem is stated **generically**, with each of its hypotheses a separate explicit
argument about a formation, a finite normal layer, and a chosen two-dimensional class, never
against an opaque bundle of class-formation axioms. Tau Ceti's `ClassFormation` is one supplier of
the three hypotheses, through `ClassFormation.h1_subgroupLayer`,
`ClassFormation.card_H2_subgroupLayer` and `ClassFormation.fundamentalClass_restrict_generates`.
The cup-product map is Tau Ceti's `cupClass`. -/

section TateTheorem

variable {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [TotallyDisconnectedSpace G]

/-- **Tate's theorem** (J. Tate, Ann. of Math. 56 (1952); Artin–Tate, Chapter XIV §4), with its
hypotheses stated one by one over Tau Ceti's finite quotient system `H ↦ L.subgroupLayer H`:

* `_h1` — `H¹(H, A^V) = 0` for every subgroup `H ≤ U/V`;
* `_hcard` — `H²(H, A^V)` has exactly `#H` elements;
* `_hgen` — the restriction of `u` to the layer of `H` generates that layer's `H²`.

Then cup product with `u` (Tau Ceti's `cupClass`) is an isomorphism
`Ĥ^r(U/V,ℤ) ≃ Ĥ^{r+2}(U/V,A^V)` in every integer degree. -/
noncomputable abbrev tateTheorem (F : Formation G) (L : NormalLayer G) (u : L.H F 2)
    (_h1 : ∀ H : Subgroup L.Gal, Subsingleton ((L.subgroupLayer H).H F 1))
    (_hcard : ∀ H : Subgroup L.Gal, Nat.card ((L.subgroupLayer H).H F 2) = Nat.card H)
    (_hgen : ∀ (H : Subgroup L.Gal) (x : (L.subgroupLayer H).H F 2),
      ∃ m : ℤ, x = m • (L.subgroupRestriction H).cohomologyRes F 2 u)
    (r : ℤ) :
    L.TrivialTateH r ≃+ L.TateH F (r + 2) :=
  TauCeti.ClassFieldTheory.tateTheorem F L u _h1 _hcard _hgen r

/-- The isomorphism of Tate's theorem **is** cup product with `u`, Tau Ceti's `cupClass`, not an
unrelated equivalence between two groups. -/
theorem tateTheorem_toAddMonoidHom (F : Formation G) (L : NormalLayer G) (u : L.H F 2)
    (h1 : ∀ H : Subgroup L.Gal, Subsingleton ((L.subgroupLayer H).H F 1))
    (hcard : ∀ H : Subgroup L.Gal, Nat.card ((L.subgroupLayer H).H F 2) = Nat.card H)
    (hgen : ∀ (H : Subgroup L.Gal) (x : (L.subgroupLayer H).H F 2),
      ∃ m : ℤ, x = m • (L.subgroupRestriction H).cohomologyRes F 2 u)
    (r : ℤ) :
    (tateTheorem F L u h1 hcard hgen r).toAddMonoidHom = cupClass F L u r :=
  TauCeti.ClassFieldTheory.tateTheorem_toAddMonoidHom F L u h1 hcard hgen r

end TateTheorem

namespace ClassFormation

variable {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [TotallyDisconnectedSpace G]
  {F : Formation G}

/-- Tate's theorem for a class formation, in every integer degree: the generic theorem applied to
Tau Ceti's fundamental class, with the three hypotheses discharged by Tau Ceti's three individually
named consequences of the axioms. Its restriction, corestriction and tower compatibilities are Tau
Ceti's `ClassFormation.tateIso_res`, `ClassFormation.tateIso_cor` and
`ClassFormation.tateIso_res_trans`. -/
noncomputable abbrev tateIso (cf : ClassFormation F) (L : NormalLayer G) (r : ℤ) :
    L.TrivialTateH r ≃+ L.TateH F (r + 2) :=
  TauCeti.ClassFieldTheory.ClassFormation.tateIso cf L r

/-- The isomorphism is Tau Ceti's cup product with the fundamental class,
`ClassFormation.cupFundamentalClass`, not an unrelated equivalence between groups of the same
cardinality. -/
theorem tateIso_toAddMonoidHom (cf : ClassFormation F)
    (L : NormalLayer G) (r : ℤ) :
    (cf.tateIso L r).toAddMonoidHom = cf.cupFundamentalClass L r :=
  tateTheorem_toAddMonoidHom F L (cf.fundamentalClass L) (cf.h1_subgroupLayer L)
    (cf.card_H2_subgroupLayer L) (cf.fundamentalClass_restrict_generates L) r

/-! ## Layer 4: low Tate degrees and the abstract Artin map

The two low-degree identifications are Tau Ceti's `NormalLayer.tateHMinusTwoEquivAbelianization`
and `NormalLayer.tateHZeroEquivNormQuotient`, and the zero-dimensional class of an element of the
ground level is Tau Ceti's `NormalLayer.zeroTateClass`. -/

/-- The degree `-2 → 0` cup-product direction, the Nakayama map `Γ^ab ≃ A^U / N(A^V)`. -/
noncomputable abbrev nakayamaNegTwo (cf : ClassFormation F) (L : NormalLayer G) :
    Additive (Abelianization L.Gal) ≃+ L.NormQuotient F :=
  TauCeti.ClassFieldTheory.ClassFormation.nakayamaNegTwo cf L

/-- **The Artin reciprocity direction.** Definitionally the inverse of `nakayamaNegTwo`; not a
new opaque choice. -/
noncomputable abbrev artinEquiv (cf : ClassFormation F) (L : NormalLayer G) :
    L.NormQuotient F ≃+ Additive (Abelianization L.Gal) :=
  TauCeti.ClassFieldTheory.ClassFormation.artinEquiv cf L

/-- The Artin map on the ground level, with kernel the norm subgroup. -/
noncomputable abbrev artinMap (cf : ClassFormation F) (L : NormalLayer G) :
    F.level L.ground →+ Additive (Abelianization L.Gal) :=
  TauCeti.ClassFieldTheory.ClassFormation.artinMap cf L

/-- Elementwise form of the definition of `artinMap`. -/
theorem artinMap_apply (cf : ClassFormation F) (L : NormalLayer G)
    (a : F.level L.ground) :
    cf.artinMap L a = cf.artinEquiv L (L.normQuotientMk F a) :=
  rfl

/-- The defining equality, recorded explicitly for downstream users and regression tests. -/
theorem artinEquiv_eq_tateIso (cf : ClassFormation F) (L : NormalLayer G) :
    cf.artinEquiv L =
      (L.tateHMinusTwoEquivAbelianization.symm.trans
        ((cf.tateIso L (-2)).trans (L.tateHZeroEquivNormQuotient F))).symm :=
  rfl

end ClassFormation

section Character

variable {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [TotallyDisconnectedSpace G]

/-- The connecting class `δχ ∈ Ĥ²(Γ,ℤ)` attached to a character `χ : Γ^ab → ℚ/ℤ` through
`0 → ℤ → ℚ → ℚ/ℤ → 0`. -/
noncomputable abbrev characterConnectingClass (L : NormalLayer G)
    (χ : Additive (Abelianization L.Gal) →+ RatModInt) :
    L.TrivialTateH 2 :=
  L.characterConnectingClass χ

/-- The native Artin character cup `a₀ ∪ δχ ∈ H²(Γ, A^V)`, evaluated on a ground-level
class and a character. The underlying construction is Tau Ceti's bundled additive pairing. -/
noncomputable abbrev artinCharacterCup (F : Formation G) (L : NormalLayer G)
    (a : F.level L.ground) (χ : Additive (Abelianization L.Gal) →+ RatModInt) : L.H F 2 :=
  L.artinCharacterCup F a χ

end Character

namespace ClassFormation

variable {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [TotallyDisconnectedSpace G]
  {F : Formation G}

/-- Artin–Tate's character characterization `χ(artinMap a) = inv(a₀ ∪ δχ)`. Together with the
transparent definition of `artinEquiv`, this pins the direction and the sign of the Artin map. -/
theorem character_artinMap (cf : ClassFormation F) (L : NormalLayer G)
    (a : F.level L.ground)
    (χ : Additive (Abelianization L.Gal) →+ RatModInt) :
    χ (cf.artinMap L a) = cf.inv L (artinCharacterCup F L a χ) :=
  (TauCeti.ClassFieldTheory.ClassFormation.character_artinMap cf L a χ).symm

/-- Uniqueness: a homomorphism satisfying the character formula for every character is the Artin
map. -/
theorem eq_artinMap_of_character (cf : ClassFormation F) (L : NormalLayer G)
    (φ : F.level L.ground →+ Additive (Abelianization L.Gal))
    (hφ : ∀ (a : F.level L.ground) (χ : Additive (Abelianization L.Gal) →+ RatModInt),
      χ (φ a) = cf.inv L (artinCharacterCup F L a χ)) :
    φ = cf.artinMap L :=
  TauCeti.ClassFieldTheory.ClassFormation.eq_artinMap_of_character cf L φ hφ

/-- **Conjugation corresponds to conjugation of Artin symbols**: on the conjugate layer
`L.conjugate g`, the Artin symbol of `g · a` is the conjugate by `g` of the Artin symbol of `a`.
Tau Ceti's `ClassFormation.artinMap_conj`; the inclusion, norm and quotient diagrams are Tau Ceti's
`ClassFormation.artinMap_groundInclusion`, `ClassFormation.artinMap_groundNorm` and
`ClassFormation.artinMap_quotient`, and norm limitation is
`ClassFormation.normSubgroup_maximalAbelianLayer`. -/
theorem artinMap_conj (cf : ClassFormation F) (g : G) (L : NormalLayer G)
    (a : F.level L.ground) :
    cf.artinMap (L.conjugate g) (L.conjugateGroundLevelEquiv F g a) =
      (L.conjugateGalEquiv g).abelianizationCongr.toAdditive (cf.artinMap L a) :=
  TauCeti.ClassFieldTheory.ClassFormation.artinMap_conj cf L g a

end ClassFormation

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

/-- The dictionary between Tau Ceti's Kummer coefficient `KummerCoeff F n` and the carrier of
`muNRep n F`: Tau Ceti's `kummerCoeffEquivMuNRep`, equivariant along the comparison
(`kummerCoeffEquivMuNRep_smul`). -/
noncomputable abbrev muNRepCoeffDictionary (n : ℕ) (F : Type) [Field F] :
    TauCeti.KummerCoeff F n ≃+ (muNRep n F).V :=
  TauCeti.ClassFieldTheory.kummerCoeffEquivMuNRep n F

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

/-- The Kummer class is additive. -/
theorem kummerClass_mul (n : ℕ) (F : Type) [Field F] (a b : Fˣ) :
    kummerClass n F (a * b) = kummerClass n F a + kummerClass n F b := by
  by_cases hn : IsUnit (n : F)
  · rw [kummerClass_eq hn, kummerClass_eq hn, kummerClass_eq hn]
    exact TauCeti.ClassFieldTheory.kummerClass_mul F hn a b
  · unfold kummerClass
    rw [dite_eq_right_of_eq_false (eq_false hn), dite_eq_right_of_eq_false (eq_false hn),
      dite_eq_right_of_eq_false (eq_false hn), add_zero]

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

/-- `kummerEquiv_mixed` sends the power class of `a` to the Kummer class of `a`: Tau Ceti's
`kummerEquivOfCharZero_ofMul_mk`. -/
theorem kummerEquiv_mixed_mk (p : ℕ) [Fact p.Prime] (F : Type) [Field F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (n : ℕ) (hn : n ≠ 0) (a : Fˣ) :
    kummerEquiv_mixed p F n hn (Additive.ofMul (QuotientGroup.mk a)) = kummerClass n F a := by
  have : CharZero F := charZero_of_injective_algebraMap (algebraMap ℚ_[p] F).injective
  rw [kummerClass_eq ((Nat.cast_ne_zero.mpr hn).isUnit)]
  exact TauCeti.ClassFieldTheory.kummerEquivOfCharZero_ofMul_mk F hn a

end KummerClass

/-- **Multiplicative separable-closure coefficients `(Fˢ)ˣ`**, written additively: Tau Ceti's
`unitsRep`, the coefficients of the local Brauer group. -/
noncomputable abbrev unitsRep (F : Type) [Field F] : TopRep ℤ (Field.absoluteGaloisGroup F) :=
  TauCeti.ClassFieldTheory.unitsRep F

/-- The Brauer group `Br F = H²(G_F, (Fˢ)ˣ)` on Mathlib's continuous cohomology: Tau Ceti's `Br`. -/
noncomputable abbrev Br (F : Type) [Field F] : Type :=
  TauCeti.ClassFieldTheory.Br F

/-! ### The local `H²` bound

These precede `invMap`: the invariant is extended from the unramified layers to all of `Br K`
through `finite_h2_units` and `natCard_h2_units_le_finrank`. The cyclic computations behind the
bound are Tau Ceti's: `herbrandQuotient_unitFiltration_zero` (the Herbrand quotient of `𝒪[L]ˣ` is
`1`), `herbrandQuotient_units_eq_finrank` (that of `Lˣ` is `[L:K]`) and
`index_normGroup_of_isCyclic`. -/

/-- The order of the local relative Brauer group divides the extension degree, by Tau Ceti's
cyclic calculation and solvable reduction, independently of reciprocity. -/
theorem natCard_h2_units_dvd_finrank [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    [IsGalois K L] :
    Nat.card (groupCohomology (Rep.ofAlgebraAutOnUnits K L) 2) ∣ Module.finrank K L :=
  TauCeti.natCard_H2_units_dvd_finrank K L

/-- The local relative Brauer group is finite: its natural cardinal divides the positive
extension degree, so that cardinal cannot be zero. -/
theorem finite_h2_units [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    [IsGalois K L] : Finite (groupCohomology (Rep.ofAlgebraAutOnUnits K L) 2) := by
  apply Nat.finite_of_card_ne_zero
  intro h
  have hdiv := natCard_h2_units_dvd_finrank K L
  rw [h, zero_dvd_iff] at hdiv
  exact Module.finrank_pos.ne' hdiv

/-- The local relative Brauer group has at most `[L:K]` elements, by the divisibility bound. Its
finiteness is supplied separately by `finite_h2_units`. -/
theorem natCard_h2_units_le_finrank [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    [IsGalois K L] :
    Nat.card (groupCohomology (Rep.ofAlgebraAutOnUnits K L) 2) ≤ Module.finrank K L :=
  Nat.le_of_dvd Module.finrank_pos (natCard_h2_units_dvd_finrank K L)

/-- **The local invariant**, normalized by arithmetic Frobenius: Tau Ceti's `invMap`. The
local-field structure is bound in the header: `Br ℂ = 0`. -/
noncomputable abbrev invMap (K : Type) [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] : Br K ≃+ RatModInt :=
  TauCeti.ClassFieldTheory.invMap K

/-- Restriction `Br K → Br L` along an embedding of `L` into the separable closure: Tau Ceti's
`brRes`. -/
noncomputable abbrev brRes [Algebra K L] (iota : L →ₐ[K] SeparableClosure K) : Br K →+ Br L :=
  TauCeti.ClassFieldTheory.brRes K L iota

/-- Corestriction `Br L → Br K` for a finite extension: Tau Ceti's `brCor`. -/
noncomputable abbrev brCor [Algebra K L] [Module.Finite K L] (iota : L →ₐ[K] SeparableClosure K) :
    Br L →+ Br K :=
  TauCeti.ClassFieldTheory.brCor K L iota

/-- Restriction multiplies the invariant by the degree. -/
theorem invMap_brRes [Algebra K L] [ValuativeExtension K L] (iota : L →ₐ[K] SeparableClosure K)
    (a : Br K) : invMap L (brRes K L iota a) = Module.finrank K L • invMap K a :=
  TauCeti.ClassFieldTheory.invMap_brRes K L iota a

/-- Corestriction preserves the invariant. -/
theorem invMap_brCor [Algebra K L] [ValuativeExtension K L] [Module.Finite K L]
    (iota : L →ₐ[K] SeparableClosure K) (b : Br L) : invMap K (brCor K L iota b) = invMap L b :=
  TauCeti.ClassFieldTheory.invMap_brCor K L iota b

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

/-- **The cohomological symbol at a supplied coordinate**: the cup product of two classes of
`H¹(G_F, μ_n)` along the coefficient pairing `P`, read through an additive coordinate `tr` of
`H²(G_F, μ_n)`. It is Tau Ceti's `localSymbol`, whose bilinearity, Steinberg relation,
antisymmetry, symbol–norm criterion and nondegeneracy are Tau Ceti's theorems; the local Hilbert
symbol `localHilbertSymbol` fixes the arithmetic coordinate `invCoordinate`. -/
noncomputable def localSymbol {n : ℕ} {F : Type} [Field F]
    (P : TauCeti.TopPairing (muNRep n F) (muNRep n F) (muNRep n F))
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n)
    (x y : H n F 1 (muNRep n F)) : ZMod n :=
  TauCeti.ClassFieldTheory.localSymbol P tr x y

/-! ### The arithmetic coordinate and the local Hilbert symbol

The coordinate of `H²(K, μ_n)` is not a free parameter of the Hilbert symbol: replacing it by its
negative changes `(a, b)` into `(a, b)⁻¹` at `n ≥ 3` and leaves every coordinate-free law intact.
The arithmetic coordinate is read off the invariant. -/

/-- **The arithmetic coordinate of `H²(K, μ_n)`**, for `n` invertible in `K`: inflate along
`μ_n ↪ (Kˢ)ˣ` to `Br K` (Tau Ceti's `h2MuToBr`), apply `invMap`, and read the class `c/n` of
`ℚ/ℤ` as `c ∈ ℤ/n`. Tau Ceti's `h2MuEquivZMod`, pinned by
`invMap_h2MuToBr_invCoordinate_symm`. -/
noncomputable abbrev invCoordinate (n : ℕ) (hn : IsUnit (n : K)) :
    H n K 2 (muNRep n K) ≃+ ZMod n :=
  TauCeti.ClassFieldTheory.h2MuEquivZMod K hn

/-- The coordinate is pinned by the invariant: the class of coordinate `c` has invariant `c/n`. -/
theorem invMap_h2MuToBr_invCoordinate_symm (n : ℕ) (hn : IsUnit (n : K)) (c : ZMod n) :
    invMap K (TauCeti.ClassFieldTheory.h2MuToBr n K ((invCoordinate K n hn).symm c)) =
      ZMod.toRatAddCircle n c :=
  TauCeti.ClassFieldTheory.invMap_h2MuToBr_h2MuEquivZMod_symm K hn c

/-- **The local Hilbert symbol** `(a, b) ∈ ℤ/n` of `a, b ∈ Kˣ`, for a primitive `n`-th root of unity
`ζ ∈ K`: the cup product of the Kummer classes along `kummerCupPairing ζ`, read in the arithmetic
coordinate `invCoordinate`. -/
noncomputable def localHilbertSymbol {n : ℕ} [NeZero n] (ζ : K) (hζ : IsPrimitiveRoot ζ n)
    (a b : Kˣ) : ZMod n :=
  localSymbol (kummerCupPairing ζ hζ) (invCoordinate K n hζ.neZero'.out.isUnit)
    (kummerClass n K a) (kummerClass n K b)

/-! ### The Tate dual, local duality and the Euler characteristic

The Tate dual `A' = Hom(A, μ_n)` is Tau Ceti's internal hom with the conjugation action, read as an
object of `GalRep n F`; the evaluation pairing, contravariance, exactness and the chosen-root
comparison are Tau Ceti's (`tateDualEquiv`, `tateEvaluationPairing`, `tateDualMap`,
`tateDualMap_exact`, `muNRepToTateDual`, `bijective_muNRepToTateDual`,
`tateDualityPairing_muNRepToTateDual`).

**Smoothness is a hypothesis.** `GalRep n F` is Mathlib's `TopRep`, whose operators are continuous
one group element at a time. `finite_H`, `tateDualityPairing_perfect_mixed` and
`eulerCharacteristic_finrank_fp` carry Tau Ceti's `TauCeti.IsSmoothDiscrete (ZMod n) A` — the
carrier is discrete and every point stabilizer is open — as the instance argument
`[Fact (TauCeti.IsSmoothDiscrete (ZMod n) A)]`. It is found by instance search at `muNRep n F`
(`instFactIsSmoothDiscreteMuNRep`), at the Tate dual of a finite smooth discrete module (Tau Ceti's
`instFactIsSmoothDiscreteTateDual`) and at the trivial module `𝔽_p`
(`instFactIsSmoothDiscreteTrivialFp`). -/

section TateDual

attribute [local instance] TopRep.distribMulAction

/-- **The Tate dual** `A' = Hom(A, μ_n)`: Tau Ceti's `tateDual`. -/
noncomputable abbrev tateDual {n : ℕ} {F : Type} [Field F] (A : GalRep n F) : GalRep n F :=
  TauCeti.ClassFieldTheory.tateDual A

end TateDual

/-- The trivial module `𝔽_p` of `G_F`, Tau Ceti's `trivialFp`, is smooth, as an instance argument
(Tau Ceti's `isSmoothDiscrete_trivialFp`). -/
instance instFactIsSmoothDiscreteTrivialFp (p : ℕ) (F : Type) [Field F] :
    Fact (TauCeti.IsSmoothDiscrete (ZMod p) (TauCeti.trivialFp p (Field.absoluteGaloisGroup F))) :=
  ⟨TauCeti.isSmoothDiscrete_trivialFp p _⟩

/-- **A finite extension of `ℚ_p` carries the `p`-adic valuation.** For a nonarchimedean local
field `F` that is a finite extension of `ℚ_p`, the valuation of `F` restricts to the `p`-adic
valuation of `ℚ_p`. Both the valuation of `F` and the unique extension of the `p`-adic valuation
to `F` are henselian of rank one, and a field that is not separably closed is henselian for at
most one rank-one valuation up to equivalence (F. K. Schmidt; Engler–Prestel, *Valued Fields*,
§4.4); `F` is not separably closed, having finite degree over `ℚ_p`. This is the compatibility
`ValuativeExtension ℚ_[p] F` that Tau Ceti's local duality, Euler characteristic and cyclotomic
normalization assume, and it is what lets the exported forms below omit it. -/
theorem algebraMap_vle_algebraMap_iff_of_finite_padic (p : ℕ) [Fact p.Prime] (F : Type)
    [Field F] [ValuativeRel F] [TopologicalSpace F] [IsNonarchimedeanLocalField F]
    [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F] (a b : ℚ_[p]) :
    algebraMap ℚ_[p] F a ≤ᵥ algebraMap ℚ_[p] F b ↔ a ≤ᵥ b :=
  sorry

/-- Finiteness in local cohomological degrees zero through two, for a finite smooth discrete
module in mixed characteristic: Tau Ceti's `finite_H`, `n` being invertible in `F`. -/
theorem finite_H (p : ℕ) [Fact p.Prime] (F : Type) [Field F] [ValuativeRel F]
    [TopologicalSpace F] [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F]
    [Module.Finite ℚ_[p] F] (n : ℕ) (hn : n ≠ 0) (A : GalRep n F)
    (hA : Finite A.V) [hsm : Fact (TauCeti.IsSmoothDiscrete (ZMod n) A)]
    (i : ℕ) (hi : i ≤ 2) :
    Finite (H n F i A) :=
  haveI : CharZero F := charZero_of_injective_algebraMap (algebraMap ℚ_[p] F).injective
  TauCeti.ClassFieldTheory.finite_H (Nat.cast_ne_zero.mpr hn) A hsm.out hi

/-- **The local duality pairing** `Hⁱ(G_F, A') × Hʲ(G_F, A) → ℤ/n`, `i + j = 2`: the cup product
along the evaluation pairing, followed by the coordinate `tr`. Tau Ceti's `tateDualityPairing`,
whose evaluation pairing needs the discrete topology on `A`. -/
noncomputable abbrev tateDualityPairing {n : ℕ} {F : Type} [Field F] (A : GalRep n F)
    [DiscreteTopology A.V] (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (i j : ℕ) (hij : i + j = 2) :
    H n F i (tateDual A) → H n F j A → ZMod n :=
  TauCeti.ClassFieldTheory.tateDualityPairing A tr i j hij

/-- **Perfect local Tate duality in mixed characteristic**, for the named evaluation pairing and a
finite smooth discrete module: Tau Ceti's `tateDualityPairing_perfect_mixed`. The statement keeps
`[DiscreteTopology A.V]` because the pairing `tateDualityPairing` it names takes it. -/
theorem tateDualityPairing_perfect_mixed (p : ℕ) [Fact p.Prime]
    (F : Type) [Field F] [ValuativeRel F] [TopologicalSpace F]
    [IsNonarchimedeanLocalField F] [Algebra ℚ_[p] F] [Module.Finite ℚ_[p] F]
    (n : ℕ) (hn : n ≠ 0) (A : GalRep n F)
    (tr : H n F 2 (muNRep n F) ≃+ ZMod n) (hA : Finite A.V)
    [DiscreteTopology A.V] [Fact (TauCeti.IsSmoothDiscrete (ZMod n) A)]
    (i j : ℕ) (hij : i + j = 2) :
    (∀ x : H n F i (tateDual A),
        (∀ y : H n F j A, tateDualityPairing A tr i j hij x y = 0) → x = 0) ∧
      (∀ φ : H n F j A →+ ZMod n, ∃ x : H n F i (tateDual A),
        ∀ y : H n F j A, tateDualityPairing A tr i j hij x y = φ y) :=
  haveI : CharZero F := charZero_of_injective_algebraMap (algebraMap ℚ_[p] F).injective
  TauCeti.ClassFieldTheory.tateDualityPairing_perfect_mixed F n hn A tr hA i j hij

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
`localClassFormation_inv`), the unramified normalization is `localArtinMap_uniformizer` and
`localArtinMap_eq_frobenius_pow_valuation`, and `H³(G_K, (Kˢ)ˣ) = 0` is
`subsingleton_h3_unitsRep`. -/

/-- **The formation of a field**: the multiplicative group `(Fˢ)ˣ` of a separable closure, written
additively as Tau Ceti's `UnitsCoeff F` on Tau Ceti's `AbsoluteGaloisGroup F`. The local formation
and the multiplicative formation of a number field are this formation. -/
noncomputable abbrev fieldFormation (F : Type) [Field F] :
    Formation (TauCeti.AbsoluteGaloisGroup F) :=
  TauCeti.ClassFieldTheory.unitsFormation F

/-- **The ground level of the field formation is `H⁰(G_F, (Fˢ)ˣ)`**: both are the units of `Fˢ`
fixed by all of `G_F`. This is what reads Tau Ceti's `baseUnitsEquivInvariants` on the ground
level (`localGroundEquiv`). -/
theorem h0_unitsCoeff_eq_level_top (F : Type) [Field F] :
    TauCeti.ContCohomology.H0 (TauCeti.AbsoluteGaloisGroup F) (TauCeti.UnitsCoeff F) =
      ((fieldFormation F).level ⊤).toAddSubgroup := by
  ext x
  simp only [FixedPoints.mem_addSubgroup]
  exact ⟨fun h => (fieldFormation F).mem_level.2 fun u _ => h u,
    fun h g => (fieldFormation F).mem_level.1 h g (Subgroup.mem_top g)⟩

/-- The formation of multiplicative groups of finite separable extensions of `K`, written
additively: the field formation `fieldFormation K`. -/
noncomputable abbrev localFormation : Formation (TauCeti.AbsoluteGaloisGroup K) :=
  fieldFormation K

/-- Hilbert 90 and the local Brauer invariant make `localFormation K` a class formation: Tau Ceti's
`localClassFormation`. The local-field structure is bound in the header: the formation of a number
field is not a class formation. -/
noncomputable abbrev localClassFormation (K : Type) [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] : ClassFormation (localFormation K) :=
  TauCeti.ClassFieldTheory.localClassFormation K

/-- Inflation from the two-dimensional cohomology of the finite layer cut out by an open normal
subgroup `V` of the local formation to the local Brauer group: Tau Ceti's `brInfl`. -/
noncomputable abbrev brInfl (V : OpenNormalSubgroup (TauCeti.AbsoluteGaloisGroup K)) :
    (NormalLayer.ofOpenNormal V).H (localFormation K) 2 →+ Br K :=
  TauCeti.ClassFieldTheory.brInfl V

/-- Finite local reciprocity, transparently transported from the abstract Artin equivalence. -/
noncomputable abbrev localArtinEquiv [Algebra K L] [Module.Finite K L] [IsGalois K L]
    (iota : L →ₐ[K] SeparableClosure K) :
    Additive (Kˣ ⧸ TauCeti.normGroup K L) ≃+
      Additive (Abelianization (L ≃ₐ[K] L)) :=
  TauCeti.ClassFieldTheory.localArtinEquiv K L iota

/-- The finite local Artin map on `Kˣ`. -/
noncomputable abbrev localArtinMap [Algebra K L] [Module.Finite K L] [IsGalois K L]
    (iota : L →ₐ[K] SeparableClosure K) :
    Additive Kˣ →+ Additive (Abelianization (L ≃ₐ[K] L)) :=
  TauCeti.ClassFieldTheory.localArtinMap K L iota

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
equations stated against named maps: `artinMap_restrict` (against `restrictAbsolute`),
`unramifiedCoordinate_artinMap` (against `unramifiedCoordinate`) and `artinMap_norm` (against
`absoluteGaloisGroupExtend`). It has dense image and is not surjective. -/
noncomputable abbrev artinMap (K : Type) [Field K] [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] : Kˣ →* Field.absoluteGaloisGroupAbelianization K :=
  TauCeti.ClassFieldTheory.artinMap K

/-- **Restriction** of the absolute Galois group to a finite Galois extension embedded by `iota`:
Tau Ceti's restriction along an embedding, `AlgHom.restrictNormalHom`, after
`absoluteGaloisGroupComparison`. Its characterizing equation is `iota_restrictAbsolute_apply`. -/
noncomputable abbrev restrictAbsolute [Algebra K L] [Module.Finite K L] [IsGalois K L]
    (iota : L →ₐ[K] SeparableClosure K) : Field.absoluteGaloisGroup K →* (L ≃ₐ[K] L) :=
  iota.restrictNormalHom.comp (absoluteGaloisGroupComparison K).toMulEquiv.toMonoidHom

omit [ValuativeRel K] [TopologicalSpace K] [IsNonarchimedeanLocalField K] [ValuativeRel L]
  [TopologicalSpace L] [IsNonarchimedeanLocalField L] in
/-- The characterizing equation of `restrictAbsolute`: `iota` is injective, so it determines the
map. Mathlib's and Tau Ceti's `AlgHom.restrictNormalHom_commutes`. -/
theorem iota_restrictAbsolute_apply [Algebra K L] [Module.Finite K L] [IsGalois K L]
    (iota : L →ₐ[K] SeparableClosure K) (σ : Field.absoluteGaloisGroup K) (x : L) :
    iota (restrictAbsolute K L iota σ x) = absoluteGaloisGroupComparison K σ (iota x) :=
  iota.restrictNormalHom_commutes _ x

omit [ValuativeRel L] [TopologicalSpace L] [IsNonarchimedeanLocalField L] in
/-- The finite maps are the restrictions of the absolute map: Tau Ceti's `artinMap_restrict`. -/
theorem artinMap_restrict [Algebra K L] [Module.Finite K L] [IsGalois K L]
    (iota : L →ₐ[K] SeparableClosure K) (x : Kˣ)
    (σ : Field.absoluteGaloisGroup K)
    (hσ : (QuotientGroup.mk σ : Field.absoluteGaloisGroupAbelianization K) = artinMap K x) :
    localArtinMap K L iota (Additive.ofMul x) =
      Additive.ofMul (Abelianization.of (restrictAbsolute K L iota σ)) :=
  TauCeti.ClassFieldTheory.artinMap_restrict K L iota x σ hσ

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

/-! ### The unramified coordinate -/

section UnramifiedCoordinate

open TauCeti

/-- **Frozen public name.** The unramified coordinate `G_K^ab → Gal(K^ur/K) ≅ Ẑ`: Tau Ceti's
`unramifiedCoordinate`, the descent of `TauCeti.restrictMaximalUnramifiedHom` followed by
`TauCeti.maximalUnramifiedGaloisGroupEquivZHat`, which sends the arithmetic Frobenius to
`zHat.gen`. -/
noncomputable abbrev unramifiedCoordinate :
    Field.absoluteGaloisGroupAbelianization K →ₜ* zHat.{0} :=
  TauCeti.unramifiedCoordinate K

/-- The unramified coordinate on every class. -/
theorem unramifiedCoordinate_mk (σ : Field.absoluteGaloisGroup K) :
    unramifiedCoordinate K (QuotientGroup.mk σ) =
      TauCeti.maximalUnramifiedGaloisGroupEquivZHat K (AlgebraicClosure K)
        (TauCeti.restrictMaximalUnramifiedHom K σ) :=
  TauCeti.unramifiedCoordinate_mk σ

/-- **Frozen public name.** On the Artin map the unramified coordinate is the normalized valuation:
Tau Ceti's `unramifiedCoordinate_artinMap`. -/
theorem unramifiedCoordinate_artinMap (x : Kˣ) :
    unramifiedCoordinate K (artinMap K x) =
      zHat.ofInt (TauCeti.normalizedValuation K x) :=
  TauCeti.ClassFieldTheory.unramifiedCoordinate_artinMap K x

end UnramifiedCoordinate

/-! ### Conductors and unit-filtration reciprocity

The conductor exponent, the conductor ideal and the character conductor are Tau Ceti's
(`conductorExponent`, `conductorIdeal`, `characterConductorExp`), as is the norm equality at an
inverse-Herbrand depth with trivial upper group,
`map_normUnits_unitFiltration_psiNat_eq_of_upperRamificationGroup_eq_bot`, for every finite Galois
extension. The three statements below that name unit-filtration reciprocity are the open targets
of this layer. -/

/-- **The conductor exponent** of a finite separable `L/K`: the least `n` with
`U_K^(n) ⊆ N_{L/K}(Lˣ)`. Tau Ceti's `conductorExponent`. -/
noncomputable abbrev conductorExponent [Algebra K L] [Module.Finite K L] [Algebra.IsSeparable K L] :
    ℕ :=
  TauCeti.ClassFieldTheory.conductorExponent K L

/-- For a totally ramified abelian extension, norms of units and depth-`r` units generate all
units when the upper group at `r` is the whole Galois group (Serre, *Local Fields*, V §§3, 6). -/
theorem sup_norm_unitFiltration_eq_of_upper_eq_top [Algebra K L] [ValuativeExtension K L]
    [Module.Finite K L] [IsAbelianGalois K L]
    (_htr : TauCeti.IsTotallyRamified K L) (r : ℕ)
    (_hr : TauCeti.LocalFieldsRamification.upperRamificationGroup K L
      ⟨(r : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg r)⟩ = ⊤) :
    (TauCeti.unitFiltration L 0).map
        (Units.map (Algebra.norm K : L →* K)) ⊔ TauCeti.unitFiltration K r =
      TauCeti.unitFiltration K 0 :=
  sorry

/-- **Unit-filtration reciprocity** (Serre, *Local Fields*, XV §2, Theorem 2). For a finite
abelian `L/K`, in either characteristic, and every depth `n ≥ 0`, the finite reciprocity map
carries the image of `U_K^(n)` onto the upper ramification group `Gal(L/K)^n`, read in the
abelianization. At `n = 0` the image is the inertia group. -/
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
    conductorExponent K L = sInf {n : ℕ | TauCeti.LocalFieldsRamification.upperRamificationGroup K L
      ⟨(n : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg n)⟩ = ⊥} := by
  have h (n : ℕ) :=
    TauCeti.ClassFieldTheory.conductorExponent_le_iff_upperRamificationGroup_eq_bot K L (n := n)
  have hmem : conductorExponent K L ∈
      {n : ℕ | TauCeti.LocalFieldsRamification.upperRamificationGroup K L
        ⟨(n : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg n)⟩ = ⊥} :=
    (h _).1 le_rfl
  exact le_antisymm ((h _).2 (Nat.sInf_mem ⟨_, hmem⟩)) (Nat.sInf_le hmem)

section AbsoluteUpper

attribute [local instance] TauCeti.finiteIntermediateFieldValuativeRel
  TauCeti.finiteIntermediateFieldTopology TauCeti.finiteIntermediateField_isNonarchimedeanLocalField
  TauCeti.finiteIntermediateField_valuativeExtension

/-- **Unit-filtration reciprocity, absolute form**: for every `n ≥ 0` the closure of
`artinMap (U_K^(n))` in `G_K^ab` is the image of the absolute upper ramification group `G_K^n`.
That group is `RamificationOfCompleteDiscretelyValuedFields` §4a.1's; it enters as the argument
`absoluteUpperRamificationGroup` together with its description on a nonarchimedean local field,
the set of `σ` whose restriction to every finite Galois `M/K` lies in `Gal(M/K)^n`, each `M`
carrying Tau Ceti's local-field structure on finite intermediate fields. Both sides are closed
subgroups with the same image in every finite abelian quotient (`map_unitFiltration_normResidue`
and `artinMap_restrict`), the image of `G_K^n` being compact. -/
theorem closure_map_artinMap_unitFiltration (n : ℕ)
    (absoluteUpperRamificationGroup : Subgroup (Field.absoluteGaloisGroup K))
    (_habs : ∀ σ : Field.absoluteGaloisGroup K, σ ∈ absoluteUpperRamificationGroup ↔
      ∀ M : FiniteGaloisIntermediateField K (AlgebraicClosure K),
        AlgEquiv.restrictNormalHom (F := K) (K₁ := AlgebraicClosure K) M σ ∈
          TauCeti.LocalFieldsRamification.upperRamificationGroup K M
            ⟨(n : ℝ), le_trans (by norm_num : (-1 : ℝ) ≤ 0) (Nat.cast_nonneg n)⟩) :
    ((TauCeti.unitFiltration K n).map (artinMap K)).topologicalClosure =
      absoluteUpperRamificationGroup.map
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
Ceti's at the pin. This file names the idele carriers that the Hasse norm theorem is stated on, the
source `GlobalNormSubgroups` of the global correspondence and the class field `globalClassField` it
defines, because the ring class field of Layer 13 is a value of `globalClassField`, and the norm
index `card_ideleClassNormQuotient`.

⚠ Everything here is for a **number field**: the carriers are Mathlib's number-field idele and
idele-class groups, and the section's `NumberField K` hypothesis is load-bearing. -/

/-- **Principal ideles**: `Fˣ` embedded diagonally in Mathlib's idele group
`NumberField.IdeleGroup (𝓞 F) F`, the units of the adele ring. -/
noncomputable def principalIdele (F : Type) [Field F] [NumberField F] :
    Fˣ →* NumberField.IdeleGroup (𝓞 F) F :=
  Units.map (algebraMap F (NumberField.AdeleRing (𝓞 F) F)).toMonoidHom

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

/-- **The source of the global correspondence:** open subgroups of finite index in `C_K`. Tau
Ceti's `GlobalNormSubgroups`. -/
abbrev GlobalNormSubgroups : Type :=
  TauCeti.ClassFieldTheory.GlobalNormSubgroups K

/-- **The global class field attached to an open finite-index subgroup `N ≤ C_K`**: Tau Ceti's
`globalClassField`, the unique abelian layer with norm subgroup `N` (`globalClassField_unique`).
The Hilbert, narrow Hilbert, ray and ring class fields are all values of `classField` at
particular norm subgroups, never independent constructions. -/
noncomputable abbrev globalClassField (N : GlobalNormSubgroups K) :
    AbelianLayer (TauCeti.AbsoluteGaloisGroup K) :=
  TauCeti.ClassFieldTheory.globalClassField N

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

/-- The ring-class norm subgroup of an order `O` of a number field: the kernel of Tau Ceti's idelic
ring-class quotient `ringClassIdeleQuotient O : C_K → Pic O`, as an element of the source carrier
of the correspondence. Tau Ceti's `ringClassNormSubgroup`. -/
noncomputable abbrev ringClassNormSubgroup (O : TauCeti.GlobalNumberFields.NumberFieldOrder K) :
    GlobalNormSubgroups K :=
  TauCeti.ClassFieldTheory.ringClassNormSubgroup O

/-- **The ring class field of an order `O` of a number field `K`**: the class field of
`ringClassNormSubgroup`, Tau Ceti's `ringClassField`. It is defined for every order in every
number field; at the maximal order it is the Hilbert class field. -/
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

/-- **At the maximal order the ring class field is the Hilbert class field.** By
`globalClassField_unique` it is enough that the two norm subgroups agree: at Tau Ceti's maximal
order `maximalNumberFieldOrder K` the kernel of `ringClassIdeleQuotient` is the ray subgroup of the
trivial modulus. -/
theorem ringClassField_maximal :
    ringClassField K (TauCeti.GlobalNumberFields.maximalNumberFieldOrder K) =
      TauCeti.ClassFieldTheory.hilbertClassField K :=
  sorry

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

/-- Outside `finiteHilbertSupport` every finite invariant vanishes: Tau Ceti's
`finiteHilbertInvariantAt_eq_zero_of_notMem`. -/
theorem finiteHilbertInvariantAt_eq_zero_of_not_mem
    (a b : Kˣ) (v : HeightOneSpectrum (𝓞 K))
    (hv : v ∉ finiteHilbertSupport K a b) :
    finiteHilbertInvariantAt K v a b = 0 :=
  TauCeti.ClassFieldTheory.finiteHilbertInvariantAt_eq_zero_of_notMem K hv

/-- **Frozen public name.** Hilbert reciprocity in additive cohomological form: Tau Ceti's
`hilbertProductFormula`. The multiplicative translation is the product of all local signs being
`1`. -/
theorem hilbertProductFormula (a b : Kˣ) :
    (∑ v ∈ finiteHilbertSupport K a b, finiteHilbertInvariantAt K v a b) +
        ∑ w : InfinitePlace K, infiniteHilbertInvariantAt K w a b = 0 :=
  TauCeti.ClassFieldTheory.hilbertProductFormula a b

end Global

end TauCetiRoadmap.ClassFieldTheory
