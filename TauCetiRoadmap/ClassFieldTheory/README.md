# Roadmap: class field theory

**Summary.** The central object of this roadmap is an **abstract class formation** in the sense of
Artin–Tate. The build is organised around the implication

```text
formation
  -> class-formation axioms
  -> fundamental classes
  -> Tate's theorem
  -> finite-level Artin maps.
```

An invariant map is *data*, so each arithmetic instance begins by constructing its invariant and
only then satisfies the axioms. The two instances therefore run

```text
local Brauer group, invariant, Hilbert symbol, local duality
  -> local class formation
  -> local reciprocity
  -> local existence
  -> the local Weil group
```

and

```text
Brauer exact sequence, sum of local invariants
  -> global class formation
  -> global reciprocity
  -> global existence and the class-field correspondence
  -> norm theorems, class fields, Hilbert reciprocity.
```

The global strand is for **number fields**: its carriers are the idele and idele-class groups of a
number field, and global class field theory for one-variable function fields over finite fields is
outside this roadmap. Both strands end at a *correspondence*, not at an existence statement: the
class field attached to a norm subgroup is the unique **abelian** layer with that norm subgroup,
and the existence theorems below are stated so that they cannot return anything else.

The invariant never appears twice: the object a class formation is built from is not also a
theorem proved after it.

This is not a roadmap for constructing another cohomology theory. Finite-group Tate cohomology
is Mathlib's (`Mathlib/RepresentationTheory/Homological/TateCohomology`), its change-of-group maps,
low-degree descriptions and cup product with a class are Tau Ceti's, and continuous cohomology of
profinite groups is specified by `ProfiniteCohomology` and implemented in Tau Ceti on Mathlib's
`continuousCohomology` (Layer 0 names them). This roadmap uses those objects and introduces no
private class-field-theory replacement.

The abstract formalism is not decorative. The local and global Artin maps constructed later in
the roadmap must be obtained from the same degree `-2` to degree `0` Tate isomorphism.
This fixes the map, its functoriality, and its sign convention before any arithmetic calculation
is made. Everything downstream — local duality, Hilbert symbols, conductors, the Hasse norm
theorem, class fields, Hilbert reciprocity — is then stated against that one map.

Tau Ceti implements most of this development, under `TauCeti/NumberTheory/ClassFieldTheory/`, and
each layer names the Tau Ceti declarations that realize its targets. `Suggested.lean` names under
this roadmap's names the Tau Ceti declarations other roadmaps consume from this one, and states, on
Mathlib's and Tau Ceti's own carriers, the targets whose Lean form this roadmap fixes and that are
open at the Tau Ceti pin. It is not an exhaustive list of the theorems of local and global class
field theory.

## Scope and ownership

### Owned here

This roadmap owns the following constructions and theorems.

1. Tate's theorem, stated generically with its three hypotheses one by one, and its application
   to a class formation, giving cup-product isomorphisms in every integer degree (Artin–Tate's Main
   Theorem) compatible with restriction, corestriction and towers. It is stated on Tau Ceti's
   formation machinery, which this roadmap consumes and does not restate: formations, finite normal
   layers, their restriction, corestriction, inflation and conjugation, class formations with the
   invariant as data, and fundamental classes.
2. The finite-level Artin equivalence `A^U / N_{U/V}(A^V) ≃ (U / V)^ab` and the Artin map on
   `A^U`. These are definitionally derived from the inverse of the
   Tate isomorphism in degrees `-2` and `0`.
3. Functoriality of the Artin map in towers, under conjugation, and under passage to a quotient.
4. The local Brauer group on the imported continuous carrier, its invariant map, and the
   cohomological local Hilbert symbol built from Kummer classes, the continuous cup product,
   and the invariant; bilinearity, the Steinberg relation, antisymmetry, the symbol–norm
   criterion and nondegeneracy. Before the invariant map: the Herbrand quotient of local units,
   the cyclic norm index and the local `H²` bound.
5. Local Tate duality for the named evaluation pairing, finiteness of `H⁰`, `H¹`, `H²` of a
   finite smooth discrete module, and the local Euler-characteristic formula, in cardinality and
   `𝔽_p`-rank form.
6. The local class formation — built *from* the invariant map of item 4 — local Artin
   reciprocity, and the arithmetic-Frobenius normalization; the cohomological dimensions
   `cd_ℓ G_K = scd_ℓ G_K = 2` for `K/ℚ_p` finite; the absolute local Artin map into the
   topological abelianization of `G_K`, pinned by restriction, its unramified coordinate and norm
   functoriality, and its cyclotomic-character normalization; unit-filtration reciprocity, which
   carries `U_K^(n)` onto the upper ramification group `G^n` at every depth `n ≥ 0`, in both
   characteristics, and its absolute form; for that form, the absolute upper ramification groups
   `G_K^u` of a nonarchimedean local field, defined from Tau Ceti's finite upper ramification
   groups, with their closedness and finite projections; local conductors.
7. The norm limitation theorem: a layer and its maximal abelian sublayer have the same norm
   subgroup. The abelian-layer condition and the canonical maximal abelian sublayer it is stated
   on are Tau Ceti's.
8. Local existence for a finite **abelian** layer, uniqueness of that layer, and the local
   class-field correspondence with its quotient isomorphism and degree equality — with the full
   correspondence in mixed characteristic and only the prime-to-residue-characteristic part in
   equal characteristic.
9. The local Weil group as a full development: its carrier inside `G_K`, its own locally compact
   topology, functoriality under finite extensions, the exact sequence `1 → I_K → W_K → ℤ → 1`,
   and, for finite extensions of `ℚ_p`, the topological abelianization isomorphism
   `Kˣ ≃ W_K^ab`.
10. The archimedean local invariants and Artin maps, the exact sequence
    `0 → Br(K) → ⨁_v Br(K_v) → ℚ/ℤ → 0` in invariant coordinates, and the sum-of-local-invariants
    map on the idele layers, together with its descent to the idele-class layers: the obstruction
    to lifting an idele-class layer class to the idele layer, the refinement that kills it, and the
    independence of the descended value from every choice.
11. The global idele-class formation — whose invariant *is* the sum-of-local-invariants map of
    item 10 — global Artin reciprocity, and comparison with the unique ideal-theoretic Artin map
    supplied by `NumberFieldArithmetic`.
12. Global existence for a finite **abelian** layer over a number field, uniqueness of that
    layer, the global class-field correspondence with its quotient isomorphism and degree
    equality, and the norm-index theorem. Existence is proved from three named inputs — upward
    closure of norm subgroups, descent along a finite extension, and the Kummer case over
    `K(ζ_p)` — and is never assumed.
13. The cyclic Hasse norm theorem; the Hilbert, narrow Hilbert and ray class fields, each
    obtained by applying the correspondence of item 12 to a named norm subgroup; admissible
    moduli, the conductor of a finite abelian extension, and ray-class reciprocity for admissible
    moduli; Kronecker–Weber; the conductor–discriminant formula; the principal ideal theorem; and,
    for every order `O` of every number field `K`, its ring class field and the isomorphism
    `Gal(H_O/K) ≃ Pic O`.
14. Hilbert reciprocity (`hilbertProductFormula`), derived from item 10. Quadratic reciprocity is
    Mathlib's `legendreSym.quadratic_reciprocity` and is not a target here; recovering it from
    `hilbertProductFormula` is a Check of Layer 14.

### Boundaries with neighbouring roadmaps

- `ProfiniteCohomology` owns continuous cohomology of profinite groups, its explicit low-degree
  models, continuous cups, change-of-group maps, Kummer theory, and the finite-quotient colimit;
- `LocalFieldsRamification` owns valuations, unit and ramification filtrations, arithmetic
  Frobenius, conductors that are purely ramification-theoretic, and the tame quotient;
- on a nonarchimedean local field `K`, the absolute upper ramification group `G_K^u` taken
  directly from Tau Ceti's finite upper groups, the set of `σ ∈ G_K` whose restriction to every
  finite Galois `M/K` lies in `LocalFieldsRamification.upperRamificationGroup K M u`, is this
  roadmap's (Layer 7), with its closedness and finite projections. The filtration relative to a
  valuation subring over an arbitrary complete discretely valued field with perfect residue field,
  its inertia and wild-inertia terms, and its agreement with Layer 7's on a local field are
  `RamificationOfCompleteDiscretelyValuedFields` §4a.1's, a consumer of Layer 7 (*Downstream
  consumers*); Layer 7 takes nothing from it;
- `FunctionFieldArithmetic` owns Artin–Schreier–Witt theory and, in equal characteristic,
  `p`-primary local existence, local Kronecker–Weber, injectivity of the absolute Artin map and the
  full local class-field correspondence. Unit-filtration reciprocity (Layer 7) is this roadmap's in
  both characteristics, since its proof uses finite reciprocity and filtered norms only, and
  `FunctionFieldArithmetic` consumes it (*Downstream consumers*);
- `GlobalNumberFields` owns places, mixed weak approximation, moduli, ray and narrow class
  groups, adeles, ideles, Hecke-character carriers, infinity types, number-field orders, `Pic`,
  and `NarrowPic`;
- `NumberFieldArithmetic` owns finite-place Frobenius and the ideal-theoretic Artin map
  `artinHomAway` on `idealsAway`.

Consequently this roadmap defines no modulus, ray-class carrier, idele carrier, Hecke character,
order, Picard group, local quadratic-form invariant, or global quadratic form. It has no
dependency on `QuadraticFormInvariants`, and from pro-`p` group theory it consumes only the Sylow
equality `cd_p_eq_of_isProPSylow` and the pro-`p` test `cd_p_le_iff_elementaryAbelian_of_isProP`
of `ProfiniteProPGroups`, for the cohomological dimension of `G_K`. The Hilbert pairing is defined
here from Kummer classes, the continuous cup product, and the local invariant map; the product
formula is proved cohomologically. This fixes the dependency direction
`ClassFieldTheory → QuadraticFormInvariants`, never the reverse.

### Explicitly outside this roadmap

- global Weil groups and Weil's construction of the Weil group of a class formation (Artin–Tate
  XV; the local Weil group is a full layer of this roadmap, Layer 9);
- explicit power-reciprocity laws beyond quadratic reciprocity (Artin–Tate XII);
- Lubin–Tate theory, formal groups, and any construction of local class field theory not routed
  through the class formation. Local existence (Layer 8) is proved from the norm topology, the
  norm-limitation theorem and the Kummer theory of Layer 5, never from Lubin–Tate formal groups;
  no target of this roadmap names a Lubin–Tate object;
- Artin–Schreier–Witt theory, hence `p`-primary local existence in equal characteristic `p`, and
  with it injectivity of the absolute local Artin map and the Weil-group reciprocity isomorphism
  `Kˣ ≃ W_K^ab` for such fields: both are stated for finite extensions of `ℚ_p` only (Layers 8
  and 9);
- the Grunwald–Wang theorem and the realization of prescribed local abelian extensions by global
  ones. Global existence (Layer 12) is proved through Kummer theory over `K(ζ_p)` and norm
  descent, and no target of this roadmap names it;
- global class field theory for one-variable function fields over finite fields. The global
  formation, ideles, reciprocity, existence, and class-field correspondence developed here are for
  **number fields**: every global target carries `NumberField K` and is stated on the number-field
  idele and idele-class carriers of `GlobalNumberFields`. Nothing here is to be read as covering
  all global fields;
- Hasse–Minkowski, the classification of global quadratic forms, and the norm-equation and
  quaternion presentations of Hilbert symbols;
- pro-`p` group theory and the Demushkin structure of local Galois groups.

## Conventions

Other roadmaps cite these sections by number:

- §2.4 → *Tate's theorem and its Tate–Nakayama generalization*, below;
- §2.5 → *The direction of reciprocity*, below;
- §2.6 → *Frobenius convention*, below;
- §4 → the layers, *Layer 0* to *Layer 14*; "§4 Layer 9" is *Layer 9*.

### Formations

Artin–Tate describe a formation by a group `G`, a distinguished family of finite-index subgroups,
and a `G`-module `A` whose elements are fixed by sufficiently small subgroups. In the classical
applications the distinguished subgroups are the open subgroups of a profinite Galois group. Tau
Ceti's `ClassFieldTheory.Formation` is the equivalent topological formulation, and this roadmap
uses it:

- `G` is profinite;
- `A` is a discrete continuous additive `G`-module, i.e. a smooth discrete `TopRep ℤ G`: Tau
  Ceti's `Formation G` is `SmoothDiscreteTopRep ℤ G`;
- for an open subgroup `U`, the level is `A^U` (`Formation.level`, a submodule of `A`);
- a finite normal layer is a pair of open subgroups `V ≤ U` such that `V` is normal in `U`
  (`NormalLayer`);
- its finite Galois group is `Γ = U / V` (`NormalLayer.Gal`), finite because `V` is open in the
  compact group `U`;
- its coefficient module is `A^V`, with the induced `Γ`-action (`NormalLayer.rep`);
- its ground level is `(A^V)^Γ = A^U` (`NormalLayer.groundLevelEquiv`).

The additive convention is used in the abstract theory. Multiplicative groups such as `Kˣ` and
idele class groups enter through `Additive` adapters. No theorem should depend on silently
switching between the two conventions.

**Universe.** Mathlib's `tateCohomology` requires the finite group and the coefficient ring `ℤ`
to live in one universe, so the whole development is stated at universe `0` (`G : Type`,
`K : Type`), as Tau Ceti's formations are; the restriction disappears only if Mathlib generalizes
the Tate complex.

### Class formations

For every finite normal layer `V ◁ U`, put `Γ = U / V` and `C = A^V`. A class formation supplies
the following data and axioms; they are exactly the fields of Tau Ceti's `ClassFormation`
(`subsingleton_h1`, `inv`, `inv_injective`, `range_inv`, `inv_restrict`, `inv_infl`, `inv_conj`),
with `ℚ/ℤ` the rational circle `AddCircle (1 : ℚ)` and its subgroup of order `n` the `n`-torsion.

1. `H¹(Γ, C) = 0`.
2. An injective invariant homomorphism `inv_{U,V} : H²(Γ, C) → ℚ/ℤ`.
3. Its image is the unique subgroup of `ℚ/ℤ` of order `[U : V]`.
4. If the ground subgroup is replaced by an intermediate open subgroup, restriction multiplies
   the invariant by the relative degree.
5. Enlarging the top field, equivalently inflating to a refinement of the layer, does not change
   the invariant.
6. Conjugation carries the invariant map for one layer to that for the conjugate layer.

The fourth condition is the finite-layer form of

```text
inv_E (res_{F,E} x) = [E : F] · inv_F(x).
```

The fifth condition is made explicit in Lean even when it is suppressed in classical notation,
because the notation `inv_F` there comes from a single map on a direct-limit Brauer group.

These axioms stop at Tate's theorem and reciprocity. They do **not** imply an abstract existence
theorem. This roadmap therefore has no `ClassFormation`-level existence declaration: local and
global existence are separate arithmetic theorems whose proofs establish the relevant topology,
divisibility, and norm-limitation inputs in their own settings. In Artin–Tate's organization these
are the additional hypotheses IIIa–IIId, not consequences of the class-formation axioms.

### Fundamental classes

If the layer has degree `n`, the invariant axioms imply that `H²(Γ,C)` is cyclic of order `n`.
Its **fundamental class** is the unique element

```text
u_{U,V} : H²(Γ,C)
```

with invariant `1/n` in `ℚ/ℤ`. It is derived from the invariant map; it is not an independent
field of `ClassFormation` and it is never chosen arbitrarily. Tau Ceti implements it
(`ClassFormation.fundamentalClass`, `inv_fundamentalClass`, `fundamentalClass_generates`) with
every compatibility below.

The first compatibility theorem is

```text
res(u_{U,V}) = u_{U',V}
```

for an intermediate ground subgroup `V ≤ U' ≤ U`. For a refinement of the top subgroup, the
inflation formula is scaled: `inf(u_{U,V}) = [V : V'] · u_{U,V'}`. Corestriction goes the other
way and is scaled by the relative degree: `cor(u_{U',V}) = [U : U'] · u_{U,V}`, while it preserves
invariants (`inv_cor`). ⚠ The index is `[U : U']`, not `[U' : U]`: `U'` is the *sub*group, so
`[U : U']` is the relative field degree `[E : F]`, which is what `fundamentalClass_cor` calls
`T.relativeDegree`. The invariant normalization forces it —
`inv(u_{U',V}) = 1/[U' : V] = [U : U']/[U : V]`, and corestriction preserves invariants. These
statements are needed to apply Tate's theorem to every subgroup of `Γ`.

### Tate's theorem and its Tate–Nakayama generalization

The generic finite-group theorem is Tate's theorem (J. Tate, *The higher dimensional cohomology
groups of class field theory*, Ann. of Math. 56, 1952). Let `Γ` be finite, let `C` be a
`Γ`-module, and let `u ∈ H²(Γ,C)`. Suppose that for every subgroup `H` of `Γ`:

```text
H¹(H,C) = 0,
H²(H,C) is cyclic of order |H|,
res_H(u) generates H²(H,C).
```

Then, for every integer `r`, cup product with `u` gives an isomorphism

```text
Ĥ^r(Γ,ℤ)  ≃  Ĥ^{r+2}(Γ,C).
```

**The hypotheses are stated individually, not bundled.** `tateTheorem` takes each of the three as
a separate explicit argument, over the finite quotient system `H ↦ subgroupLayer H`; it never
takes a `ClassFormation`. This matters because the pieces are consumed separately downstream, and
a layer that satisfies only some of them — a cyclic layer of the local formation, an `S`-idele
layer of the global one — must still be able to use the theorem. Each datum is a declaration
rather than a clause of prose, and all are Tau Ceti's:

- the finite quotient system `H ↦ subgroupLayer H`, with its Galois group, degree and restriction
  datum: `NormalLayer.subgroupLayer`, `subgroupGalEquiv`, `degree_subgroupLayer`,
  `subgroupRestriction`, `relativeDegree_subgroupRestriction`;
- compatible fundamental classes under restriction, corestriction, inflation and conjugation:
  `fundamentalClass_restrict`, `fundamentalClass_cor`, `fundamentalClass_infl`,
  `fundamentalClass_conj`;
- the two low-degree Tate identifications: `tateHMinusTwoEquivAbelianization`,
  `tateHZeroEquivNormQuotient`;
- the restriction/corestriction normalization: `inv_restrict` (an axiom), `inv_cor` (a theorem),
  `LayerRestriction.cohomologyCor_cohomologyRes`, `tateCor_tateRes`;
- tower compatibility: `LayerRestriction.trans`, `relativeDegree_trans`, `cohomologyRes_trans`,
  `cohomologyCor_trans`, `tateRes_trans`, `tateCor_trans`, `LayerRefinement.trans`,
  `cohomologyInfl_trans`, `tateIso_res_trans`;
- the three hypotheses, verified for a class formation: `h1_subgroupLayer`,
  `card_H2_subgroupLayer`, `fundamentalClass_restrict_generates`.

⚠ `inv_cor` is a theorem, not a field of `ClassFormation`. Adding it as an axiom would let an
implementation satisfy it by fiat, and it is a consequence of `inv_restrict`, `inv_injective` and
`cor ∘ res = [E:F]`; Tau Ceti proves it so. ⚠ The restriction, corestriction and inflation squares
do not have the same shape: restriction multiplies invariants by the relative degree, corestriction
preserves them, and inflation of the fundamental class is scaled. A single "compatibility" clause
covering all three is false.

Artin–Tate prove it from their Preliminaries §2 Theorem A, the cup-product criterion (surjective,
bijective, injective in three consecutive degrees for every subgroup), and call the
class-formation specialization the **Main Theorem** (Chapter XIV §4, Theorem 1). The
generalization to an arbitrary coefficient module `M` with `Tor₁^ℤ(M,C) = 0`,

```text
Ĥ^r(Γ,M)  ≃  Ĥ^{r+2}(Γ, M ⊗ C),
```

is Nakayama's (T. Nakayama, *Cohomology of class field theory and tensor product modules I*, Ann.
of Math. 65, 1957), the **Tate–Nakayama theorem**; its hypotheses are the same three plus the
vanishing of `Tor₁`, and it is Tau Ceti's
`TauCeti.TateCohomology.cup_bijective_of_forall_isPGroup_of_lTensor_injective`, proved through the
Nakayama–Rim theorem of Layer 0. The class-field-theory application uses `M = ℤ`, i.e. Tate's
theorem, and the roadmap names the generic theorem `tateTheorem` and its application to a class
formation `tateIso`. The explicit degree `-2 → 0` map is Artin–Tate's *Nakayama map*, after
Nakayama's 1935 explicit formula (`nakayamaNegTwo`); it is not to be confused with the
Tate–Nakayama theorem.

The public isomorphism is not merely an existential equivalence between two groups. Its
underlying homomorphism is the named cup-product map with the named fundamental class. This
identity is part of the API.

### The direction of reciprocity

At `r = -2`, Tate's theorem gives

```text
Ĥ^{-2}(Γ,ℤ)  →  Ĥ^0(Γ,C).
```

The canonical low-degree identifications are

```text
Ĥ^{-2}(Γ,ℤ)  ≃  Γ^ab,
Ĥ^0(Γ,C)     ≃  A^U / N_{U/V}(A^V).
```

Thus cup product with the fundamental class gives the **Nakayama map**

```text
nakayamaNegTwo : Γ^ab ≃ A^U / N_{U/V}(A^V).
```

The Artin reciprocity direction used in this roadmap is its inverse:

```text
artinEquiv : A^U / N_{U/V}(A^V) ≃ Γ^ab.
```

The map on the ground level is

```text
artinMap : A^U → Γ^ab,
```

obtained by composing the quotient map with `artinEquiv`. Consequently its kernel is exactly the
norm subgroup. These are Tau Ceti's constructions, `ClassFormation.tateIso`,
`ClassFormation.nakayamaNegTwo`, `ClassFormation.artinEquiv` and `ClassFormation.artinMap`:
`tateIso` applies `tateTheorem` to the fundamental class, `artinEquiv` is `nakayamaNegTwo.symm`
**definitionally**, Tau Ceti's `ClassFormation.artinEquiv_eq_tateIso` is proved by `rfl`, and
`ClassFormation.tateIso_toAddMonoidHom` identifies `tateIso` with cup product with the fundamental
class. `Suggested.lean` keeps `ClassFormation.artinMap` under this roadmap's name.
The generic theorem and its cup-product characterization are implemented in Tau Ceti's
Formation/Tate/Theorem.lean, and the Artin constructions in Formation/ArtinMap.lean;
the two low-degree identifications
(`NormalLayer.tateHMinusTwoEquivAbelianization`, `NormalLayer.tateHZeroEquivNormQuotient`) and the
cup-product map `cupClass` are Tau Ceti's.
A character formula provides an independent normalization check. An arbitrary equivalence of
groups does not satisfy the contract.

### Frobenius convention

All local and global Artin maps use **arithmetic Frobenius**.

- For an unramified extension of nonarchimedean local fields, a uniformizer maps to the
  automorphism inducing `x ↦ x^q` on the residue field, and the unramified coordinate sends every
  lift of its absolute Artin symbol to the generator `zHat.gen` of `ℤ̂` (`1` in additive
  notation).
- For `K/ℚ_p` finite and a unit `u`, `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹`. Omitting the field
  norm is ill-typed away from `ℚ_p`.
- For a number-field extension and an unramified prime `𝔭`, the ideal Artin symbol is the
  arithmetic Frobenius at `𝔭`.
- For `ℚ(ζ_m)/ℚ` and a prime `ℓ` not dividing `m`, the Artin symbol of `(ℓ)` sends `ζ_m` to
  `ζ_m^ℓ`.

Choosing geometric Frobenius would invert every one of these formulae. The unramified local and
cyclotomic Examples of Layers 6, 7 and 11 are therefore mandatory. `geometricArtinMap` is defined
only as the precomposition of the arithmetic map with inversion, for interoperability.

### Further pinned conventions

- The local invariant map sends the fundamental class of a degree-`n` extension to `1/n` in
  `ℚ/ℤ`. Restriction multiplies invariants by the degree (`inv_restrict`); corestriction preserves
  them (`inv_cor`). Both directions are named maps in every degree, not one map and its inverse.
- An invariant map is data, and it is constructed before the class formation that carries it:
  `invMap` before `localClassFormation` (`localClassFormation_inv`), and `globalInv` — the sum of
  local invariants — before `globalClassFormation` (`globalClassFormation_inv`). No object of this
  roadmap is both a prerequisite of a construction and a theorem proved after it.
- The local Weil group carries the **Weil topology**, in which inertia is open, and not the
  subspace topology from `G_K`; its reciprocity isomorphism is with the **topological**
  abelianization `W_K / closure ⁅W_K, W_K⁆`.
- The ring class field is defined for every order of every number field. The description of
  `Pic O` by congruences modulo the conductor alone is its specialization to quadratic fields, not a
  hypothesis of the construction.
- **Every class field lives inside the separable closure**, as `IntermediateField K
  (SeparableClosure K)`, because that is the closure whose automorphism group is the formation's
  group, Tau Ceti's `AbsoluteGaloisGroup`. A class field is then literally
  `IntermediateField.fixedField` of the open normal subgroup the correspondence produces, with no
  intervening transport. For a number field the separable and algebraic closures agree, so nothing
  is lost.
- **A norm subgroup determines an abelian layer and only an abelian layer.** By norm limitation a
  nonabelian layer and its maximal abelian sublayer share a norm subgroup, so the final existence
  theorems return an abelian layer and are paired with uniqueness. The two order statements run in
  opposite directions and both are named: inclusion-preserving on subgroups of `G_K`,
  inclusion-reversing on the fields they cut out.
- ⚠ **The correspondence runs in one direction on subgroups and the opposite direction on
  fields.** Inclusion of open normal subgroups of `G_K` is *reverse* inclusion of the fields they
  cut out, so `localClassFieldCorrespondence` and `globalClassFieldCorrespondence` are order
  **isomorphisms** onto `AbelianLayer G_K` — `N₁ ≤ N₂ ↔ V₁ ≤ V₂`, recorded as
  `localClassField_le_iff` and `globalClassField_le_iff` — while the classical order-**reversing**
  statement is on fields, `localClassField_orderReversing` and `globalClassField_orderReversing`,
  obtained from the Galois dictionary `classField_le_classField_iff`. Writing the subgroup form
  with the inclusions reversed would be false; `localNormSubgroup_top` and
  `globalNormSubgroup_top` pin the extreme case, `V = ⊤ ↦ K ↦ N = Kˣ`.
- Tate cohomology is Mathlib's, defined for every `r : ℤ`. Inflation is used only in positive
  degrees; Tate degree zero is a quotient by the norm and does not admit the naive inflation
  map.
- The global Artin map is a transport of the abstract Artin map and agrees with
  `NumberFieldArithmetic.artinHomAway`; there is one ideal-theoretic Artin map in the portfolio.
- A modulus's infinite part consists of real places. The modulus, ray subgroup and ray-class
  group are imported from `GlobalNumberFields`, never redefined here.
- The absolute Galois group of the formation is Tau Ceti's separable-closure group
  `AbsoluteGaloisGroup`; Mathlib's algebraic-closure
  `Field.absoluteGaloisGroup` and its topological abelianization are the carriers of the frozen
  local exports `artinMap` and `unramifiedCoordinate`, related by the comparison
  `absoluteGaloisGroupComparison`, which is Tau Ceti's `absoluteGaloisGroupRestrictEquiv`.
- `ℤ̂` is Tau Ceti's `zHat`, written multiplicatively; no second profinite completion of `ℤ` is
  built here.
- `cyclicHasseNorm` and `hilbertProductFormula` are frozen public names. Their statements use the
  global and local carriers of Layers 10–14; neither may be replaced with a proposition-valued
  interface whose hypotheses simply assume the conclusion. `normResidue` is a compatibility form of
  `localArtinEquiv`; it must not become a second independently constructed equivalence.

## Exact supplier contracts

| Material | Supplier |
|---|---|
| Integer-graded finite-group Tate cohomology, its long exact sequence, and its comparison with ordinary cohomology and homology | Mathlib `RepresentationTheory/Homological/TateCohomology` |
| Cohomological triviality and projective dimension (Nakayama–Rim), submodules of free modules over a principal ideal domain, primary components of Tate cohomology, and the Tate–Nakayama theorem | Tau Ceti: `Rep.isZero_res_of_projective`, `Rep.projective_of_isZero_res`, `Rep.isZero_res_of_exact` (`RepresentationTheory/Homological/TateCohomology/Projective/Basic.lean`), `Rep.projective_ker_of_isZero_res` (`TateCohomology/NakayamaRim.lean`), `Submodule.free_of_isPrincipalIdealRing` (`LinearAlgebra/FreeModule/PID.lean`), `TauCeti.TateCohomology.primaryComponent_tateCohomology_eq_bot` (`TateCohomology/PrimaryComponent.lean`), `TauCeti.TateCohomology.cup_bijective_of_forall_isPGroup_of_lTensor_injective` (`TateCohomology/Cup/TateNakayama.lean`) |
| The formation machinery of Artin–Tate: formations and their levels, finite normal layers with their Galois groups, degrees, coefficient modules, cohomology carriers, norms and low Tate degrees, the finite quotient system, restriction, corestriction, inflation and conjugation of layers with their tower laws, the maps of abelianized Galois groups, the abelian layers, class formations with the invariant as data, fundamental classes with their restriction, corestriction, inflation and conjugation formulae, the three hypotheses of Tate's theorem, and the cup product with a class | Tau Ceti, `TauCeti/NumberTheory/ClassFieldTheory/Formation/`: `ClassFieldTheory.Formation`, `NormalLayer`, `LayerRestriction`, `LayerRefinement`, `ClassFormation`, `AbelianLayer`, `cupClass`, and the declarations listed in the Conventions and Layers 1 and 2 |
| Tate's theorem and its cup-product characterization and naturality, the Nakayama and Artin constructions, the four functoriality diagrams and norm limitation, the units formation, the local class formation and finite local reciprocity | Tau Ceti, Formation/Tate/Theorem.lean, Formation/Tate/Naturality.lean, Formation/Tate/Conjugation.lean, Formation/Tate/Inflation.lean, Formation/ArtinMap.lean, Formation/NormLimitation.lean, Formation/Units.lean, Local/ClassFormation.lean and Local/Reciprocity.lean, consumed under Tau Ceti's names; `Suggested.lean` keeps `tateTheorem`, `ClassFormation.artinMap`, `localArtinMap` and `normResidue` as reducible aliases under this roadmap's names, and restates `artinMap_conj` as a closed proof |
| Restriction, corestriction, inflation, cup products, and low-degree Tate descriptions | Tau Ceti's `LayerRestriction.tateRes`, `tateCor`, `trivialTateRes`, `trivialTateCor`, `LayerRefinement.cohomologyInfl`, `cupClass`, `NormalLayer.tateHMinusTwoEquivAbelianization` and `NormalLayer.tateHZeroEquivNormQuotient` |
| Continuous cohomology of profinite groups and its operations | `ProfiniteCohomology` Layers 1, 4, 5, 10, 11 and 12 (below); at the pin Tau Ceti's `TopPairing`, `TopPairing.cup`, `TopPairing.cup_coeffMap`, `TopPairing.cup_gradedComm`, `ContinuousCohomology.coeffMap`, `ContinuousCohomology.degreeCast`, `cohomologicalDimensionAt` and `strictCohomologicalDimensionAt` on Mathlib's `continuousCohomology` |
| Profinite groups, open subgroups, finite quotients, and topological abelianization | Mathlib (`OpenSubgroup`, `OpenNormalSubgroup`, `TopologicalAbelianization`, `Field.absoluteGaloisGroupAbelianization`) |
| The normal basis theorem for a finite Galois extension of arbitrary fields: a basis indexed by the Galois group whose value at `σ` is `σ θ` | Mathlib, `Mathlib/FieldTheory/Galois/NormalBasis.lean`: `IsGalois.normalBasis`, `IsGalois.normalBasis_apply` |
| Local fields, valuations, unit filtrations, norms, ramification, and arithmetic Frobenius; the maximal unramified extension, inertia, arithmetic Frobenius lifts and `Gal(K^ur/K) ≅ Ẑ`, under their Tau Ceti names | `LocalFieldsRamification` (completed): Tau Ceti's `unitFiltration`, `normGroup`, `ramificationIndex`, `normalizedValuation`, `frobeniusAlgEquiv`, `IsUnramified`, `IsTotallyRamified`, `LocalFieldsRamification.upperRamificationGroup`, `LocalFieldsRamification.psiNat`, `inertiaSubgroup` |
| Herbrand's theorem, filtered norms and Hasse–Arf for finite extensions of nonarchimedean local fields | `LocalFieldsRamification` (completed), at the pin in `TauCeti/NumberTheory/LocalField/`: Herbrand's quotient and subgroup theorems `upperRamificationGroup_quotient` and `upperRamificationGroup_fixedField` (`Herbrand/UpperQuotient.lean`), `LocalFieldsRamification.psiNat` (`Herbrand/Basic.lean`), the shifted norm inclusion `map_normUnits_unitFiltration_psiNat_le` (`Norm/Herbrand.lean`), the graded norms `normGradedMap` (`Norm/Graded.lean`), the norm equality at a trivial upper group `map_normUnits_unitFiltration_psiNat_eq_of_upperRamificationGroup_eq_bot` for every finite Galois extension (`Norm/Surjectivity.lean`), `LocalFieldsRamification.hasseArf` (`Herbrand/HasseArf/Abelian.lean`), and the unit Herbrand quotient `herbrandQuotient_unitFiltration_zero` (`UnitFiltration/TateCohomology.lean`) |
| For the absolute upper ramification groups of Layer 7: Herbrand's theorem for restriction between finite Galois levels, the local-field structure on finite intermediate fields and the valuative structure of one level over another, compactness of the absolute Galois group, and surjectivity and continuity of restriction | Tau Ceti's `LocalFieldsRamification.map_restrictNormalHom_upperRamificationGroup` (`TauCeti/NumberTheory/LocalField/Herbrand/UpperQuotient.lean`), `finiteIntermediateFieldValuativeRel`, `finiteIntermediateFieldTopology`, `finiteIntermediateField_isNonarchimedeanLocalField` and `finiteIntermediateField_valuativeExtension` (`TauCeti/NumberTheory/LocalField/FiniteExtension/IntermediateField.lean`), `AlgHom.valuativeExtension` (`TauCeti/NumberTheory/LocalField/AlgebraicExtension/Basic.lean`), and Tau Ceti's `CompactSpace (Field.absoluteGaloisGroup K)` instance (`TauCeti/FieldTheory/Galois/AbsoluteGaloisGroup/Basic.lean`); Mathlib's `AlgEquiv.restrictNormalHom_surjective` and `InfiniteGalois.restrictNormalHom_continuous` |
| The comparison of the algebraic-closure and separable-closure absolute Galois groups, restriction along an embedding, the open subgroup cut out by a finite extension, the class field of an open normal subgroup and the abelian layers, the profinite integers `zHat`, the Herbrand quotient and two-periodicity, and the Galois action on the integers of a local field | Tau Ceti: `absoluteGaloisGroupRestrictEquiv`, `AlgHom.restrictNormalHom`, `galoisSubgroup`, `galoisSubgroupEquiv`, `ClassFieldTheory.classField`, `OpenNormalSubgroup.IsAbelianClassFieldLayer`, `zHat`, `TateCohomology.herbrandQuotient`, `Rep.FiniteCyclicGroup.periodicIso`, `integerRingIsInvariantSubring` |
| The coefficient dictionary between discrete modules and topological representations, the Galois-cohomology coefficients `μ_n` and `(Kˢ)ˣ`, the Kummer map, the explicit `H¹` with its functoriality and its comparison with continuous cohomology, and the internal hom with its conjugation action and evaluation pairing | Tau Ceti: `ofDiscreteModule`, `ofDiscreteModuleMap`, `IsSmoothDiscrete`, `ofDiscreteModule_isSmoothDiscrete`, `KummerCoeff`, `UnitsCoeff`, `kummerMap`, `kummerMap_eq_kummerCocycleClass`, `ContCohomology.H1`, `ContCohomology.explicitMap1`, `ContCohomology.explicitH1AddEquivContinuousCohomology`, `ContCohomology.cocycleEquiv1`, `InternalHom`, `homAction`, `InternalHom.evalPairing`, `InternalHom.smul_eq_self_iff` |
| Grothendieck groups of modular representations, the lattice defect, and the modular Artin induction theorem | `RepresentationTheory/ModularInduction` Layers 0, 1, 3 and 4 (below) |
| The Sylow equality for `cd_p` and the pro-`p` test for it | `ProfiniteProPGroups` (completed): `cd_p_eq_of_isProPSylow`, `cd_p_le_iff_elementaryAbelian_of_isProP` |
| Number fields, places, completions, ideles, idele classes, moduli, ray classes, weak approximation, orders, and Picard groups | `GlobalNumberFields` (completed): Mathlib's `NumberField.IdeleGroup`, its principal-idele map `NumberField.IdeleGroup.unitEmbedding` (`Mathlib/NumberTheory/NumberField/AdeleRing.lean`) and `NumberField.IdeleClassGroup`; Tau Ceti's `GlobalNumberFields.NumberFieldOrder`, `GlobalNumberFields.Pic`, `GlobalNumberFields.Modulus`, `GlobalNumberFields.ideleNormMap`, `GlobalNumberFields.ideleClassNormMap`, `GlobalNumberFields.IsFiniteLocalNorm`, `IsInfiniteLocalNorm` and `IsLocalNormEverywhere` |
| Relative discriminants of extensions of Dedekind domains | Tau Ceti's `TauCeti.relDiscr` (`RingTheory/DedekindDomain/Discriminant/Basic.lean`) |
| This roadmap's own targets that Tau Ceti implements at the pin, under the names used here: the coefficient objects, Kummer classes and equivalences, `Br`, `invMap`, `brRes`, `brCor`, `h2MuEquivZMod`, `localSymbol`, `kummerCupPairing`, `tateDual`, local duality and the Euler characteristic; the local class formation, `localArtinEquiv`, `normResidue`, the absolute `artinMap` with `artinMap_restrict`, `artinMap_norm` and `ker_artinMap_eq_iInf`, `unramifiedCoordinate`, `conductorExponent`, `conductorIdeal`, `characterConductorExp`, the explicit cyclotomic symbols and the cyclotomic normalization; local existence and the local correspondence; the local Weil group; the global formation, the Brauer sequence, `globalInv`, the global class formation and global reciprocity, global existence and the global correspondence, the Hasse norm theorem, the ray, Hilbert, narrow Hilbert and ring class fields, `kroneckerWeber` and the Hilbert invariants | Tau Ceti, `TauCeti/NumberTheory/ClassFieldTheory/` (`Brauer/`, `Local/`, `LocalExistence/`, `WeilGroup/`, `Global/`, `GlobalExistence/`, `ClassFields/`); `Suggested.lean` names the ones other roadmaps consume from this roadmap |
| Frobenius classes and the ideal-theoretic Artin map away from ramified primes | `NumberFieldArithmetic` (completed) |

### From TauCetiRoadmap.ProfiniteCohomology

Continuous cohomology of profinite groups on Mathlib's `continuousCohomology`, as Tau Ceti
implements it: coefficient maps `ContinuousCohomology.coeffMap` (Layer 1); the finite-quotient
colimit (Layers 4 and 10); the conjugation invariants `H1ConjInvariants` (Layer 5);
the long exact sequence `longExact_exact`, corestriction with `corestriction_comp_res` and the
Mackey formula `corestriction_mackey`, and Shapiro's lemma `shapiroIso` (Layer 10); `cd_p`,
`scd_p`, `cd_p_le_of_isClosed`, `cd_p_le_scd_p` and the strict-dimension criterion
`strictCohomologicalDimensionAt_le_iff_forall_openSubgroup` at `n = 2` (Layer 11); and the
coefficient pairings `TopPairing` with the graded cup and its laws `cup_coeffMap`, `cup_add_left`
and `cup_gradedComm`, and the degree casts `ContinuousCohomology.degreeCast` (Layer 12).

### From TauCetiRoadmap.RepresentationTheory.ModularInduction

For the Euler characteristic of Layer 5: the Grothendieck group `modRepK0` with its universal
property `modRepK0.lift` (Layer 0) and induction `modRepK0.ind` (Layer 1); the lattice defects
`latticeDefect_add_of_exact`, `latticeDefect_eq_zero_of_finite` and
`latticeDefect_eq_of_finiteIndex` (Layer 3); and the modular Artin theorem
`modularArtin_exists_nsmul_mem_indCyclicCoprime` (Layer 4), proved there without Brauer
characters.

## How to read the build

The layer order below **is** the dependency order. Every layer's prerequisites are Mathlib, Tau
Ceti, a supplier of *Exact supplier contracts*, or an *earlier* layer of this roadmap; no layer uses
a name introduced later. Six orderings are normative rather than editorial:

- the local Brauer group and its invariant map are built in Layer 5 and consumed by the local class
  formation in Layer 6, never the other way round, and within Layer 5 the local `H²` bound precedes
  the invariant on all of `Br K`;
- within Layer 5, `finite_H` precedes local duality, and duality precedes the Euler characteristic,
  whose additivity uses it;
- local existence is Layer 8, after the Kummer theory of Layer 5 that its proof uses;
- the sum-of-local-invariants map is built in Layer 10 and *is* the invariant of the global class
  formation of Layer 11, so it cannot also be a theorem proved after it;
- the cyclotomic normalization of the absolute local Artin map is a theorem of Layer 7, proved by
  comparison with the explicit local symbols of the cyclotomic fields over `ℚ`, whose product
  formula is a direct computation; Layer 10 consumes it for
  `sumLocalInv_brLocalization_eq_zero`, so it cannot be proved from the global class formation;
- the archimedean Artin maps are built in Layer 10, beside `infiniteInvMap` and before
  `sumLocalInv_brLocalization_eq_zero`, which reads the Artin symbol at `∞` as a local invariant;
  Layer 11 consumes them.

Layer 5 feeds both the local and the global column: the local column consumes `invMap` on `K`
itself, the global column consumes it at every completion, and both consume the Galois dictionary
`classField` recorded there. Layer 4's norm limitation theorem also feeds both existence layers.
Layer 11 additionally consumes the absolute local Artin map of Layer 7 through `localArtinAt`.
`RepresentationTheory/ModularInduction` enters only Layer 5, for the Euler characteristic, and
`ProfiniteProPGroups` only the end of Layer 6, for the cohomological dimension of `G_K`. The
abstract Layers 0–4 do not depend on any arithmetic instance; within the local column, Layer 5's
coefficient dictionaries and Kummer transports depend only on `ProfiniteCohomology`; and Layer 10
depends on Layer 5 only for `invMap` and the local unit computations, never on its duality or
Euler characteristic.

`Suggested.lean` is an acceptance test of suggested forms, not a second implementation and not an
exhaustive checklist. It imports `Mathlib` and individual Tau Ceti modules only, never another
roadmap's `Suggested.lean`, and it consumes Mathlib's and Tau Ceti's declarations by name. It
contains the transparent aliases `ClassFormation`, `tateTheorem` and `ClassFormation.artinMap`;
the declarations other roadmaps consume from this one, each a Tau Ceti declaration under this
roadmap's name and a closed proof, except that `eulerCharacteristic_finrank_fp` and
`cyclotomicCharacter_artinMap` take Tau Ceti's compatibility hypothesis from Layer 5's open
`algebraMap_vle_algebraMap_iff_of_finite_padic` and are closed once it is proved; with
`sorry`, the targets whose Lean form it fixes and that are open at the Tau Ceti pin: Layer 5's
`algebraMap_vle_algebraMap_iff_of_finite_padic`, Layer 7's `map_unitFiltration_normResidue`,
`sup_norm_unitFiltration_eq_of_upper_eq_top` and `closure_map_artinMap_unitFiltration`, and Layer
13's `isPrincipal_map_hilbertClassField` and `relDiscr_eq_finprod_abelianConductor`; and the one
definition these need, Layer 7's `localAbsoluteUpperRamificationGroup`, with a real body.
Everything else this roadmap names is Mathlib's or Tau Ceti's, under its library name. It contains
no definition whose body is `sorry`, no arbitrary `Nonempty (X ≃ Y)` where a canonical map is
required, no theorem quantified over an arbitrary pairing where a named pairing is meant, and no
coordinate left free where the arithmetic coordinate is meant.

The Examples of the layers are acceptance tests. They pin the direction and normalization of the
Artin map in cases where the answer is elementary, and they are meant to catch four errors which
are easy to hide in an abstract development:

1. using an arbitrary equivalence instead of cup product with the fundamental class;
2. using the cup-product direction `Γ^ab → A^U/N(A^V)` as the Artin map instead of its inverse;
3. normalizing the Artin map by geometric rather than arithmetic Frobenius;
4. reversing the class-field correspondence, i.e. attaching the maximal abelian extension to `Kˣ`
   rather than to the trivial subgroup.

The minimal suite of these tests is Tau Ceti's at the pin: `artinMap_trivialLayer`;
`localNormSubgroup_top`; `localArtinMap_uniformizer` for an arbitrary finite unramified extension;
`localArtinMap_quadratic_eq_nontrivial_iff_not_norm`; `globalArtinMap_Qi_prime`;
`globalArtinMap_cyclotomic_prime` with the explicit `ℚ(ζ₅)` value at `2`; and the rejection test
`not_isAdmissibleModulus_one_Qi`. Together they test triviality, the direction of the class-field
correspondence, the norm kernel, a nontrivial group of order two, arithmetic Frobenius, a
non-involutive Artin symbol, and that ray-class reciprocity is never written at an inadmissible
modulus.

## Layer 0: the cohomology suppliers

The finite-group and continuous cohomology this roadmap uses already exists, under these names; no
second carrier is built here.

1. Finite-group Tate cohomology is Mathlib's `tateCohomology`
   (`Mathlib/RepresentationTheory/Homological/TateCohomology/Basic.lean`), with its connecting map,
   long exact sequence and the comparisons `isoGroupCohomology` and `isoGroupHomology`.
   Restriction, corestriction, inflation and conjugation in every Tate degree, with
   `cor ∘ res = [G:H]` and the tower laws, the low-degree descriptions
   `NormalLayer.tateHMinusTwoEquivAbelianization` and `NormalLayer.tateHZeroEquivNormQuotient`, the
   cup product with a class `cupClass`, and the generic cup-product criterion of Tate's theorem
   (Artin–Tate, Preliminaries §2, Theorem A) are Tau Ceti's, in
   `TauCeti/NumberTheory/ClassFieldTheory/Formation/`. Two-periodicity for cyclic groups is Tau
   Ceti's `Rep.FiniteCyclicGroup.periodicIso`, and the Herbrand quotient is Tau Ceti's
   `TateCohomology.herbrandQuotient`, with `herbrandQuotient_eq_mul_of_shortExact`,
   `herbrandQuotient_eq_of_finite_kernel_of_finite_cokernel` and
   `herbrandQuotient_trivial_int_eq_card`.
2. Continuous cohomology is Mathlib's `continuousCohomology` on `TopRep`, with Tau Ceti's
   coefficient pairings `TopPairing`, cup products `TopPairing.cup`, coefficient maps
   `ContinuousCohomology.coeffMap` and degree casts `ContinuousCohomology.degreeCast`, as
   `ProfiniteCohomology` specifies.
3. **Cohomological triviality and projective dimension.** The theorem of Nakayama and Rim: a
   representation `A : Rep k G` of a finite group is cohomologically trivial exactly when it has
   projective dimension at most one over `k[G]`. Cohomological triviality is the conclusion of Tau
   Ceti's criterion `TauCeti.TateCohomology.isZero_of_forall_isPGroup`, written out as
   `∀ (S : Subgroup G) (n : ℤ), IsZero (tateCohomology (res S.subtype A) n)`, so vanishing in two
   consecutive degrees on the subgroups of prime-power order suffices and no new predicate is
   introduced. The ring `k` is a principal ideal domain of characteristic zero in which every prime
   number is a unit or generates a maximal ideal, which covers `ℤ`, `ℤ_[p]`, `ℤ_(p)` and every
   field of characteristic zero. All four statements are Tau Ceti's, in namespace `Rep`, and none
   carries a finiteness hypothesis on `A`:
   - `Rep.isZero_res_of_projective`: a projective `k[G]`-module is cohomologically trivial (for any
     commutative ring `k`);
   - `Rep.projective_of_isZero_res`: a cohomologically trivial representation whose underlying
     `k`-module is free, of any rank, is projective over `k[G]`;
   - `Rep.projective_ker_of_isZero_res`: if `A` is cohomologically trivial, every surjection onto
     `A.ρ.asModule` from a projective `k[G]`-module has projective kernel, so every cohomologically
     trivial `A` has a projective resolution of length one;
   - `Rep.isZero_res_of_exact`: conversely, `A` is cohomologically trivial when
     `0 → P₁ → P₀ → A → 0` is exact with `P₀` and `P₁` projective (for any commutative ring `k`).

   The kernel statement uses `Submodule.free_of_isPrincipalIdealRing`, Tau Ceti's: over a
   principal ideal domain every submodule of a free module is free, in any rank (Lang, *Algebra*,
   III Theorem 7.1); Mathlib has the finite-rank case, `Submodule.nonempty_basis_of_pid`. The route
   is Serre, *Local Fields*, IX §§3–5; Brown, *Cohomology of Groups*, VI §8; Rim, Ann. of Math. 69
   (1959).
4. **`p`-primary Tate cohomology sees only `p`**, Tau Ceti's
   `TauCeti.TateCohomology.primaryComponent_tateCohomology_eq_bot`: if multiplication by `p` is
   bijective on `A`, the `p`-primary component of `Ĥⁿ(S, A)` is trivial for every subgroup `S` and
   every `n ∈ ℤ`, because it is killed by `#S` and multiplication by `p` on `A` induces a bijection
   of it. With the long exact sequences, a morphism whose kernel and cokernel have bijective
   multiplication by `p` therefore induces isomorphisms on the `p`-primary components of Tate
   cohomology.
5. **The Tate–Nakayama theorem**, Tau Ceti's
   `TauCeti.TateCohomology.cup_bijective_of_forall_isPGroup_of_lTensor_injective`, proved through
   the Nakayama–Rim theorem (Conventions, *Tate's theorem and its Tate–Nakayama generalization*).

`LocalGaloisGroups` consumes the kernel statement at `k = ℤ_[p]` for its Tate module and the
primary-component statement for `Lˣ → A(L)`, the `p`-adic completion of the multiplicative group of
a `p`-adic field, under this roadmap's names `TateCohomology.projective_ker_of_isZero_res` and
`TateCohomology.primaryComponent_tateCohomology_eq_bot`; `Suggested.lean` restates those two as
closed proofs.

**Exit criterion,** met by Tau Ceti at the pin. `tateTheorem` and Tau Ceti's
`ClassFormation.tateIso`, `ClassFormation.nakayamaNegTwo` and `ClassFormation.artinEquiv` are
stated on the imported Tate groups and the imported cup product `cupClass`, with no locally defined
cohomology object.

### Examples

- Over `k = ℚ` every representation of a finite group is cohomologically trivial, its Tate groups
  being killed by `#G`, which is invertible; every `ℚ[G]`-module is projective (Maschke), as the
  theorem requires.
- For `G` of order `2` acting trivially on `ℤ`, `Ĥ⁰(G, ℤ) = ℤ/2 ≠ 0`, so `ℤ` is not
  cohomologically trivial and has no projective resolution of length one over `ℤ[G]`.
- For `G = ℤ/p` acting trivially on `ℤ[1/p]`, multiplication by `p` is bijective, and indeed
  `Ĥ⁰(G, ℤ[1/p]) = ℤ[1/p]/pℤ[1/p] = 0`.

### Dependencies

Mathlib finite-group cohomology and Tate cohomology; `ProfiniteCohomology` (continuous cohomology);
Tau Ceti's `Rep` and `TateCohomology` namespaces.

## Layer 1: formations and finite normal layers

**Implemented in Tau Ceti**, in `TauCeti/NumberTheory/ClassFieldTheory/Formation/` (`Basic`,
`Restriction`, `Refinement`, `Corestriction`, `Conjugation`, `GroundNorm`, `GaloisMaps`,
`AbelianLayer` and `Tate/`), and consumed here under Tau Ceti's names; this roadmap restates none of
it. Tau Ceti provides:

- `Formation G`, the smooth discrete `TopRep ℤ G` on a profinite `G`, with `Formation.level U = A^U`
  a submodule of the ambient module;
- the finite quotient `NormalLayer.Gal = U / V`, finite because `V` is open in the compact group
  `U`, and the degree `NormalLayer.degree`;
- the induced representation of `U / V` on `A^V` (`NormalLayer.rep`);
- the equality `(A^V)^(U/V) = A^U` (`NormalLayer.groundLevelEquiv`);
- **the finite quotient system:** for every subgroup `H ≤ U/V`, the corresponding intermediate open
  subgroup (`subgroupLayer`), its Galois group (`subgroupGalEquiv`), its degree
  (`degree_subgroupLayer`), the restriction datum relating it to `L`
  (`NormalLayer.subgroupRestriction`) and its relative degree
  (`relativeDegree_subgroupRestriction`), together with the identification of the restricted
  representation with the coefficient module of that intermediate layer
  (`LayerRestriction.repIso`);
- the layers `V ◁ ⊤` of open normal subgroups (`NormalLayer.ofOpenNormal`), which are the
  finite Galois extensions of the ground field of the formation;
- **the abelian layers among them.** `IsAbelianClassFieldLayer V` says that `V` contains the
  **closed** commutator subgroup `(commutator G).topologicalClosure`, the subgroup Mathlib's
  `TopologicalAbelianization` and `Field.absoluteGaloisGroupAbelianization` already quotient by;
  no second closed commutator subgroup is defined here, and the algebraic `commutator G` is the
  wrong subgroup because it need not be closed. Tau Ceti proves the finite-quotient form
  `isAbelianClassFieldLayer_iff_isMulCommutative`, the layer form
  `isMulCommutative_gal_ofOpenNormal`, and the resulting identification
  `abelianizationGalEquiv : Abelianization L.Gal ≃ L.Gal`, which is what lets the
  abelianization-valued Artin equivalence of Layer 4 be read as an isomorphism onto `L.Gal`;
- **the canonical maximal abelian sublayer** `maximalAbelianLayer V = V · [G,G]‾`, with
  `le_maximalAbelianLayer`, `isAbelianClassFieldLayer_maximalAbelianLayer` and the universal
  property `maximalAbelianLayer_le`. It is data — a join of two named subgroups — never a choice
  of "some abelian layer with the same norm subgroup";
- the norm `A^V → A^U`, the norm subgroup and the norm quotient (`norm`, `normSubgroup`,
  `NormQuotient`, `normQuotientMk`);
- restriction (`LayerRestriction`), refinement (`LayerRefinement`), and conjugation
  (`NormalLayer.conjugate`, `conjugateCohomologyIso`, `conjugateTateIso`) between layer
  representations, on ordinary and Tate cohomology, together with the ground-level inclusion,
  norm and identification (`groundInclusion`, `groundNorm`, `groundEquiv`,
  `conjugateGroundLevelEquiv`), and the transfer, inclusion, quotient and conjugation maps on
  abelianized Galois groups (`transferHom`, `inclusionHom`, `quotientHom`, `conjugateGalEquiv`);
  tower objects remember the actual inclusions, not only equal cardinalities;
- **restriction and corestriction as separate named maps** in every degree
  (`LayerRestriction.cohomologyRes`, `cohomologyCor`, `tateRes`, `tateCor`, `trivialTateRes`,
  `trivialTateCor`) with the normalization `cor ∘ res = [E:F]`
  (`cohomologyCor_cohomologyRes`, `tateCor_tateRes`);
- **tower compatibility:** restrictions and refinements compose (`LayerRestriction.trans`,
  `LayerRefinement.trans`), the relative degree is multiplicative along a tower
  (`relativeDegree_trans` in both namespaces), and every one of the maps above is functorial along
  a composite (`cohomologyRes_trans`, `cohomologyCor_trans`, `tateRes_trans`, `tateCor_trans`,
  `cohomologyInfl_trans`).

All Tate groups in a finite layer are the imported finite-group Tate groups of `U/V`.

**Exit criterion,** met by Tau Ceti at the pin. The expressions

```text
Ĥ^r(U/V,ℤ),
Ĥ^r(U/V,A^V),
A^U / N_{U/V}(A^V),
(U/V)^ab
```

are all represented by named types and canonical maps, and restriction (`cohomologyRes`),
corestriction (`cohomologyCor`) and towers (`LayerRestriction.trans`) each have a name.

### Examples

- For `G = Ẑ` acting trivially on `A = ℤ` and open subgroups `V = mnẐ ≤ U = nẐ`, the layer has
  `Γ = ℤ/m`, the norm `A^V → A^U` is multiplication by `m`, and the ground-level quotient `ℤ/m` is
  `Γ^ab`; at `V = U` the group `Γ` is trivial and so is the quotient.
- If `G/V` is a Klein four group, `V` is an abelian layer and `maximalAbelianLayer V = V`; if
  `G/V ≅ S₃`, `maximalAbelianLayer V` is the layer of index `2`, which cuts out the quadratic
  subextension.

### Dependencies

Layer 0; Mathlib's open subgroups and topological abelianization.

## Layer 2: class formations and fundamental classes

**Implemented in Tau Ceti**, in `Formation/ClassFormation.lean`, and consumed here. Tau Ceti's
`ClassFormation` has the axioms of the Conventions with the invariant as data, and Tau Ceti proves:

- `H²(U/V,A^V)` is cyclic of order `[U:V]` (`natCard_H2`, `isAddCyclic_H2`);
- existence and uniqueness of the class of invariant `1/[U:V]` (`existsUnique_inv_eq`), which is
  `fundamentalClass` (`inv_fundamentalClass`, `eq_fundamentalClass_iff`);
- `fundamentalClass` generates `H²` (`fundamentalClass_generates`);
- restriction of a fundamental class is the fundamental class of the restricted layer
  (`fundamentalClass_restrict`);
- corestriction preserves invariants (`inv_cor`) and carries the fundamental class to
  `[E:F] · u_{K/F}` (`fundamentalClass_cor`);
- the scaled inflation and the conjugation formulae (`fundamentalClass_infl`,
  `fundamentalClass_conj`).

Tau Ceti also proves, as separate named theorems, the three hypotheses Layer 3 consumes:

- `h1_subgroupLayer` — `H¹` vanishes on the layer of every subgroup;
- `card_H2_subgroupLayer` — that layer's `H²` has `#H` elements;
- `fundamentalClass_restrict_generates` — the restricted fundamental class generates it.

The invariant is data. The fundamental class is derived. A structure with an unrelated chosen
class for every subgroup is not an acceptable substitute. This roadmap re-exports Tau Ceti's
structure as `ClassFormation`, so that the targets of Layers 3 and 4 are its methods, and restates
none of it.

**Exit criterion,** met by Tau Ceti at the pin. The hypotheses of Tate's theorem are available
*individually* for the restriction of the fundamental class to every subgroup of `U/V`
(`h1_subgroupLayer`, `card_H2_subgroupLayer`, `fundamentalClass_restrict_generates`).

### Examples

- For an unramified local layer of degree `6` and its intermediate field `E` of degree `2`, the
  fundamental class has invariant `1/6`, and its restriction to the layer over `E` has invariant
  `2 · (1/6) = 1/3`, of order `3 = [L:E]`.
- Corestriction from the subgroup of index `3` preserves invariants: the fundamental class of the
  layer of degree `2` has invariant `1/2 = 3 · (1/6)`, so it corestricts to `3` times the
  fundamental class of the layer of degree `6`; the reversed index `1/3` is not an integer.

### Dependencies

Layer 1.

## Layer 3: Tate's theorem for a class formation

Use Tau Ceti's generic theorem `tateTheorem` on its layers, with its three hypotheses as separate
explicit arguments (Conventions, *Tate's theorem*), and its characterization by `cupClass`
(Tau Ceti's `tateTheorem_toAddMonoidHom`), both in Formation/Tate/Theorem.lean.
Its class-formation specialization is

```text
tateIso (r : ℤ) :
  Ĥ^r(U/V,ℤ) ≃ Ĥ^{r+2}(U/V,A^V)
```

as that theorem applied to Tau Ceti's fundamental class and to Tau Ceti's three Layer 2 theorems, so
that Tau Ceti's `ClassFormation.tateIso_toAddMonoidHom` (against
`ClassFormation.cupFundamentalClass`) is a proof rather than a second assertion. Its compatibilities
are Tau Ceti's:

- with restriction to a subgroup (`tateIso_res`, through `tateRes` and `trivialTateRes`);
- with corestriction (`tateIso_cor`, through `tateCor` and `trivialTateCor`);
- with a tower of ground fields (`tateIso_res_trans`);
- with conjugation (`tateIso_conj`, Formation/Tate/Conjugation.lean);
- with inflation in positive degrees, with the scaled formula (`tateIso_infl`,
  Formation/Tate/Inflation.lean).

The scaled inflation formula matters: the fundamental class of a smaller layer inflates to a
degree multiple of the fundamental class of the larger layer. No statement should claim unscaled
commutativity in positive degrees, and the restriction, corestriction and inflation squares do not
all have the same shape.

**Exit criterion.** There is one named, cup-product-defined family of isomorphisms in all integer
degrees, `tateIso`, obtained from a generic theorem whose hypotheses are visible in its type.

### Examples

- For `C₂` acting on `ℂˣ` by complex conjugation, `H¹ = 0` and
  `#H² = #(ℝˣ/ℝ_{>0}) = 2 = #Ĥ⁻²(C₂, ℤ)`, and the three hypotheses hold.
- For `C₂` acting trivially on `ℤ/2`, `H¹ = ℤ/2 ≠ 0`, so the first hypothesis excludes it.

### Dependencies

Layers 0, 1 and 2 (Tau Ceti's).

## Layer 4: the abstract Artin map

The two low-degree identifications are Tau Ceti's (`NormalLayer.tateHMinusTwoEquivAbelianization`,
`NormalLayer.tateHZeroEquivNormQuotient`). Define

```text
nakayamaNegTwo : (U/V)^ab ≃ A^U / N(A^V),
artinEquiv     : A^U / N(A^V) ≃ (U/V)^ab := nakayamaNegTwo.symm,
artinMap       : A^U → (U/V)^ab.
```

These are Tau Ceti's definitions in Formation/ArtinMap.lean, with this definitional chain;
`Suggested.lean` keeps `ClassFormation.artinMap` under this roadmap's name. Tau Ceti proves:

1. `ker artinMap = N(A^V)` (`ker_artinMap`) and the elementwise `artinMap_eq_zero_iff`;
2. `artinMap` is surjective (`surjective_artinMap`);
3. the four Artin–Tate diagrams: inclusion of ground levels corresponds to group-theoretic
   transfer, the norm to inclusion of Galois groups, conjugation to conjugation, and passage to
   a quotient extension to the quotient map on Galois groups (`artinMap_groundInclusion`,
   `artinMap_groundNorm`, `artinMap_conj`, `artinMap_quotient`), every map being Tau Ceti's;
   `artinMap_conj` is re-exported under this roadmap's name;
4. the character formula

   ```text
   χ (artinMap a)
     = inv (class(a) ∪ δ(χ))
   ```

   for every character `χ : (U/V)^ab → ℚ/ℤ` (`character_artinMap`), where `class(a)` is Tau
   Ceti's `NormalLayer.zeroTateClass`, and `δ(χ)` and the cup are Tau Ceti's connecting class
   `NormalLayer.characterConnectingClass` and bundled additive pairing
   `NormalLayer.artinCharacterCup` in Formation/Character.lean;
5. uniqueness: any homomorphism satisfying the character formula is `artinMap`
   (`eq_artinMap_of_character`);
6. **the norm limitation theorem** `ClassFormation.normSubgroup_maximalAbelianLayer`
   (Formation/NormLimitation.lean): a layer and its maximal abelian sublayer have the same norm
   subgroup. The inclusion `≤` is functoriality of the norm along `V ≤ V·[G,G]‾`; the reverse
   follows because `artinEquiv` identifies both norm quotients with `(G/V)^ab = G/(V·[G,G]‾)`, so
   the two subgroups have the same finite index. It is a consequence of reciprocity and never of
   existence.

The character formula is the second protection against accidentally using the inverse map or the
opposite fundamental class. Norm limitation is what forces Layers 8 and 12 to state existence with
an abelian layer: without it `∃ V, N(V) = N` would have two witnesses for every nonabelian `V`.

**Exit criterion.** Downstream files can refer to the Artin map without choosing an arbitrary
isomorphism or reopening a sign convention, and `normSubgroup_maximalAbelianLayer` is available to
the two existence layers.

### Examples

- **The trivial layer.** For the layer `U/U`, the norm quotient, `(U/U)^ab` and the Artin map are
  all trivial; this reduces to the unique map between trivial groups, not to a cardinality
  argument. It is also the direction test for the correspondence: the layer `V = ⊤`, which cuts out
  the ground field itself, has norm subgroup the whole of `Kˣ` resp. `C_K`.
- **Kernel, quotient and cyclic layers.** For every finite normal layer, the Artin symbol of `a`
  is `artinEquiv` of the class of `a`, by definition, and it vanishes exactly when `a ∈ N(A^V)`.
  For a cyclic layer the norm quotient has `[U:V]` elements, and the Artin symbol of `a` generates
  `Γ` exactly when the class of `a` generates the norm quotient. The character formula is the most
  sensitive abstract test of the sign convention; it is proved from the definition of
  `artinEquiv`, not postulated as a second normalization.

### Dependencies

Layer 3.

## Layer 5: local coefficients, the Brauer group, the local invariant, and duality

Keep all continuous cohomology on the imported Mathlib carrier:

```text
GalRep n F = ProfiniteCohomology.TopRep (ZMod n) G_F,
H n F i A  = continuousCohomology i A.
```

The layer also records, once, the Galois dictionary that both arithmetic columns need in order to
state their class-field correspondence in fields: `classField F V` is the fixed field of an open
normal subgroup of `G_F` inside the separable closure, and `classField_le_classField_iff` is the
order-reversing half of the Galois correspondence. Both are Tau Ceti's
(`TauCeti.ClassFieldTheory.classField` and its `classField_le_classField_iff`), consumed under these
names. They are recorded here, before Layer 8 and Layer 12, because both use them and neither may
restate them.

Nothing in this layer uses local reciprocity, the abelian norm-index theorem
(`index_localNormSubgroup`), local existence, or the local class formation of Layers 1–4 and 6.

**The coefficient objects.** Every coefficient object of this layer is Tau Ceti's, consumed by
name and never built a second time. `absoluteGaloisGroupComparison` is Tau Ceti's
`absoluteGaloisGroupRestrictEquiv`, through which Mathlib's `G_F` acts on Tau Ceti's modules of the
separable closure. `muNRep n F` is Tau Ceti's `muNRep` (MuNRep.lean): the `n`-th roots of unity
`μ_n(Fˢ)`, Tau Ceti's `KummerCoeff F n` restricted along the comparison, a smooth discrete
`ZMod n`-module (`isSmoothDiscrete_muNRep`, as an instance `instFactIsSmoothDiscreteMuNRep`), with
`muNRepCoeffDictionary`, Tau Ceti's `kummerCoeffEquivMuNRep`, identifying its carrier with
`KummerCoeff F n` equivariantly (`kummerCoeffEquivMuNRep_smul`). The units `(Fˢ)ˣ` over `ℤ` are
Tau Ceti's `unitsRep F`.

**The Kummer class.** `kummerClass n F a` is Tau Ceti's `kummerClass F hn a` when `n` is invertible
in `F` (`kummerClass_eq`): the transport to `H¹(G_F, μ_n)` of the Kummer map `kummerMap F n hn a`,
the degree-zero connecting map of the Kummer sequence, by the degree-one comparison
`muNRepH1Equiv`; on cocycles it is the class of `g ↦ gα/α` for an `n`-th root `α` of `a`
(`kummerClass_eq_kummerCocycleClass`). It is additive (`kummerClass_mul`). Where `n` is not
invertible in `F` there is no Kummer sequence and the value is `0`; every theorem that uses it makes
`n` invertible. The Kummer equivalences are Tau Ceti's: `kummerEquiv` for `n` invertible in `F`,
with `kummerEquiv_ofMul_mk`, and, for `F/ℚ_p` finite, `kummerEquivOfCharZero`, exported as
`kummerEquiv_mixed`, which sends the power class of `a` to its Kummer class
(`kummerEquivOfCharZero_ofMul_mk`). `kummerEquiv_mixed` is valid for every `n ≠ 0`,
including `n = p`; this is not a consequence of the prime-to-`p` unit case.

The Brauer carrier `Br F = H²(G_F,(Fˢ)ˣ)`, its invariant `invMap` normalized by arithmetic
Frobenius, and `brRes` and `brCor` with the degree-multiplying restriction and degree-free
corestriction squares (`invMap_brRes`, `invMap_brCor`) are Tau Ceti's (Brauer/Basic.lean,
Brauer/Invariant.lean, Brauer/Restriction.lean). The invariant is constructed first on unramified
layers, using arithmetic Frobenius, and then on the full Brauer group through the local `H²` bound
below. The degree-`n` piece is the subgroup of `ℚ/ℤ` of order `n`, and the fundamental class of a
degree-`n` local layer is the class of invariant `1/n`.

**Local units and the `H²` bound.** Before the invariant is extended from the unramified layers to
all of `Br K`, Tau Ceti proves, in this order (Milne, *Class Field Theory*, III, Lemmas 2.3–2.6):

- for cyclic `L/K`, the Herbrand quotient of the local units `unitFiltration L 0 = 𝒪[L]ˣ`, with
  the Galois action, is `1` (`herbrandQuotient_unitFiltration_zero`). Mathlib's normal basis
  `IsGalois.normalBasis K L`, scaled by a power of a uniformizer into `𝒪[L]`, spans an open lattice
  free over `𝒪[K][Gal(L/K)]`; a small multiple `A` of it satisfies `A · A ⊆ πA`, so `1 + A` is an
  open Galois-stable cohomologically trivial subgroup of finite index, and the invariance of the
  Herbrand quotient under a map with finite kernel and cokernel
  (`herbrandQuotient_eq_of_finite_kernel_of_finite_cokernel`) gives `1`. `𝒪[L]` itself need not be
  free over `𝒪[K][Gal(L/K)]`, which holds only in the tame case;
- for cyclic `L/K` the Herbrand quotient of `Lˣ` (Mathlib's `Rep.ofAlgebraAutOnUnits K L`) is
  `[L:K]` (`herbrandQuotient_units_eq_finrank`), by multiplicativity along
  `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0` (`herbrandQuotient_eq_mul_of_shortExact`) and
  `herbrandQuotient_trivial_int_eq_card`;
- **the cyclic norm index** `index_normGroup_of_isCyclic`: for cyclic `L/K`,
  `[Kˣ : N_{L/K}(Lˣ)] = [L:K]`, because `Ĥ⁰(Gal(L/K), Lˣ)` is the norm quotient and
  `Ĥ⁻¹ ≅ H¹` vanishes by Hilbert 90 (`groupCohomology.H1ofAutOnUnitsUnique`) and two-periodicity.
  ⚠ This is a Herbrand-quotient computation; it is not the norm-index theorem
  `index_localNormSubgroup` of Layer 8, which is reciprocity;
- **the local `H²` bound and finiteness**: Tau Ceti's divisibility theorem
  `natCard_H2_units_dvd_finrank` (Brauer/LocalH2Bound.lean) says that `#H²(Gal(L/K), Lˣ)` divides
  `[L:K]` for every finite Galois `L/K`, by cyclic two-periodicity, the unit Herbrand quotient and
  solvable reduction. Since `[L:K] > 0`, divisibility forces the natural cardinal to be nonzero, so
  `H²(Gal(L/K), Lˣ)` is finite, and it gives `#H²(Gal(L/K), Lˣ) ≤ [L:K]`. Finiteness is a
  separate consequence: an infinite type has natural cardinal zero, so the inequality alone would
  not give it.

Then the invariant extends: the unramified relative Brauer group of degree `[L:K]` has `[L:K]`
elements and lies in the kernel of restriction to `L`, since restriction multiplies the unramified
invariant by `[L:K]`; that kernel is the relative Brauer group of `L/K`. Finiteness together with
the bound makes the two equal. So `Br K` is the union of the unramified relative Brauer groups,
and `invMap` is the unramified invariant on all of it. Equality in the bound is the class-formation
axiom of Layer 6.

**Checks.**

- For `L = K`, the relative `H²` is trivial and its cardinal is `1`.
- For a cyclic extension of degree `m`, two-periodicity and the cyclic norm index give cardinal
  exactly `m`, in either characteristic.
- An infinite additive group has natural cardinal `0`, which satisfies the numerical bound but
  cannot divide the positive extension degree; this tests the finiteness step.

**The coordinates of `H²(F, μ_n)`.** For `F/ℚ_p` finite and every `n ≠ 0`, the coordinate
`h2MuEquivZMod_mixed : H²(F,μ_n) ≃ ZMod n` is Tau Ceti's canonical `h2MuEquivZMod`, read off the
invariant, `n` being invertible in `F`. Along an isomorphism `e : μ_p ≅ T` of coefficient objects
it transports to `h2FpEquivZMod_of_mu : H²(F, T) ≃ ZMod p`, Tau Ceti's `h2EquivZModOfMuNRepIso`; a
chosen primitive `p`-th root supplies `e` at the trivial module `𝔽_p`, and without such a
coefficient identification the zero module is a counterexample.

**The Hilbert symbol.** A primitive `n`-th root `ζ ∈ F` fixes the coordinate
`muNRepEquivZMod ζ : μ_n(Fˢ) ≃ ℤ/n`, `ζ ↦ 1` (`muNRepEquivZMod_generator`; Mathlib's
`IsPrimitiveRoot.zmodEquivZPowers` with `IsPrimitiveRoot.zpowers_eq`), and, lying in `F`, it makes
the Galois action on `μ_n(Fˢ)` trivial (`muNRep_ρ_eq_self`). `kummerCupPairing ζ` is the pairing
`μ_n × μ_n → μ_n`, `(x, y) ↦ log_ζ(x) · y` (`kummerCupPairing_bil`, symmetric by
`kummerCupPairing_bil_comm`), and `localSymbol P tr` is the cup along a coefficient pairing `P`
followed by an additive coordinate `tr` of `H²(G_F, μ_n)`. `localSymbol` is the symbol at a
supplied coordinate, an auxiliary construction: its kernel, bilinearity, Steinberg relation,
antisymmetry, norm criterion and nondegeneracy hold at every coordinate, but a free coordinate does
not determine a symbol. The coordinate of the public symbol is the arithmetic one, Tau Ceti's
`h2MuEquivZMod`: inflate along `μ_n ↪ (Kˢ)ˣ` to `Br K` (`h2MuToBr`), apply `invMap`, and read the
class `c/n` of `ℚ/ℤ` as `c ∈ ℤ/n` (`invMap_h2MuToBr_h2MuEquivZMod_symm`). The local Hilbert symbol
of `a, b ∈ Kˣ` at a primitive `n`-th root `ζ ∈ K` is
`localSymbol (kummerCupPairing ζ) (h2MuEquivZMod K hn) (kummerClass n K a) (kummerClass n K b)`,
with `hn` the invertibility of `n` in `K`. This is the canonical owner of the cohomological local
Hilbert pairing; no quadratic-form or quaternion symbol is imported.

Its laws are Tau Ceti's (Local/Symbol.lean, Local/CyclicClass.lean), for `n` invertible in `K`,
which at `n = 2` over `ℚ_2` is the case Layer 14 needs:

- bilinearity after transport of Kummer classes, `localSymbol_kummerClass_mul`;
- the Steinberg relation `(a, 1 − a) = 0`, `localSymbol_kummerClass_eq_zero_of_add_eq_one`, which
  holds in particular at the named pairing `kummerCupPairing ζ`;
- antisymmetry `localSymbol_antisymm`, from the graded commutativity of the cup
  (`ProfiniteCohomology.cup_gradedComm`) and the symmetry of `kummerCupPairing ζ`;
- the symbol–norm criterion `localSymbol_eq_zero_iff_mem_normGroup`: for `μ_n ⊆ K` and
  `L = K(b^{1/n})`, stated about that extension exactly (a chosen `s` with `s^n = b` generating
  `L`), the symbol of `a` and `b` vanishes exactly when `a ∈ normGroup K L`; the cup of the two
  Kummer classes is the class of the cyclic algebra, through two-periodicity
  (`Rep.FiniteCyclicGroup.periodicIso`) and inflation into `Br K`, injective by Hilbert 90;
- nondegeneracy, `forall_localSymbol_kummerClass_eq_zero_iff`: `a` pairs to zero with every `b`
  exactly when `a ∈ (Kˣ)ⁿ`, by antisymmetry, the norm criterion and the cyclic norm index; both
  sides of the pairing being the finite group `Kˣ/(Kˣ)ⁿ`, the Hilbert pairing is perfect.

**Checks.**

- Over `ℚ_7` with `n = 3` (`μ_3 ⊆ ℚ_7`), the cyclic algebra of the unramified cubic extension with
  arithmetic Frobenius and parameter `7` has invariant `1/3`, so its coordinate is `1`; the negated
  coordinate gives `2`, and every coordinate-free law holds for both.
- At `n = 2` the two coordinates agree, `−1 = 1` in `ℤ/2`, so the quadratic symbol cannot detect a
  sign error in the coordinate.
- If `a` is an `n`-th power its Kummer class vanishes and the local Hilbert symbol of `a` and `b` is
  `0` for every `b`. Two Kummer classes naturally cup into `μ_n ⊗ μ_n`, not `μ_n`: multiplication of
  roots of unity is not biadditive. A primitive root supplies the additional pairing, and the
  Steinberg law is stated only for that named pairing. At exponent two the primitive root is `-1`
  and the identification is canonical, which is what lets Layer 6 read the quadratic Artin symbol
  off `localSymbol` at the named pairing `kummerCupPairing (-1)`
  (`localArtinMap_quadratic_eq_hilbertSymbol`). That theorem, like the Steinberg law and local
  duality, is stated for the named pairing only: a statement quantified over an arbitrary pairing
  admits the zero pairing, under which every symbol is trivial.

**The Tate dual.** `tateDual A = Hom(A, μ_n)` is Tau Ceti's internal hom `InternalHom G_F A μ_n`,
the additive maps `A → μ_n` with the conjugation action `homAction`,
`(g · φ)(a) = g · φ(g⁻¹ · a)`, read in `GalRep n F` through `ofDiscreteModule`. The evaluation
pairing `tateEvaluationPairing A : Hom(A, μ_n) × A → μ_n` is Tau Ceti's `InternalHom.evalPairing`.
Neither is a second construction, and their equations are Tau Ceti's: the carrier is
`Hom(A, μ_n)` (`tateDualEquiv`), the action is conjugation (`tateDualEquiv_ρ_apply`), the pairing is
evaluation (`tateEvaluationPairing_bil`), and the invariants are the equivariant maps,
`H⁰(G_F, Hom(A, μ_n)) = Hom_{G_F}(A, μ_n)` (`tateDual_ρ_eq_self_iff`). The dual is discrete, finite
for finite `A` and `n ≠ 0`, and smooth for finite smooth discrete `A` (`isSmoothDiscrete_tateDual`,
and as an instance `instFactIsSmoothDiscreteTateDual`). The dual is contravariant, `tateDualMap
f = f^*`; evaluation is natural (`tateEvaluationPairing_tateDualMap`), which gives the naturality
of the duality pairing in cohomology through `ProfiniteCohomology.cup_coeffMap`
(`tateDualityPairing_tateDualMap`); and the dual of a short exact sequence is short exact when `n`
is invertible in `F` (`tateDualMap_exact`). After a primitive root `ζ ∈ F` is chosen,
`muNRepToTateDual ζ : μ_n → Hom(μ_n, μ_n)`, `x ↦ (y ↦ log_ζ(x) · y)`, is an isomorphism
(`bijective_muNRepToTateDual`), and through it the `(1, 1)` duality pairing at `A = μ_n` is the
Hilbert pairing `localSymbol (kummerCupPairing ζ)` (`tateDualityPairing_muNRepToTateDual`). Read
through the coordinate `muNRepEquivZMod ζ`, this says that the cup square on `H¹(G_F, ℤ/n)` is the
`(1, 1)` Tate-duality pairing; `LocalGaloisGroups` consumes it in that form.

**Smoothness.** Duality and the Euler characteristic are stated for finite **smooth discrete**
modules: Tau Ceti's `IsSmoothDiscrete (ZMod n) A` says that the carrier is discrete and every point
stabilizer is open, and it enters as the instance argument
`[Fact (TauCeti.IsSmoothDiscrete (ZMod n) A)]`. It does not follow from a discrete carrier:
`GalRep n F` is Mathlib's `TopRep`, whose operators are continuous one group element at a time,
not jointly in the group variable. For finite `A` it makes the kernel of the action an open
subgroup `G_L`, and every reduction starts from the finite Galois extension `L/K` it cuts out; it is
also the hypothesis under which `ProfiniteCohomology` supplies Shapiro's lemma and corestriction.
Instances supply it at `muNRep n F` (`instFactIsSmoothDiscreteMuNRep`), at the Tate dual of a finite
smooth discrete module (`instFactIsSmoothDiscreteTateDual`) and at the trivial module `𝔽_p`, Tau
Ceti's `trivialFp` (`instFactIsSmoothDiscreteTrivialFp`). Discreteness is part of smoothness, so
`finite_H` and the Euler characteristic carry no separate `[DiscreteTopology A.V]`; the duality
pairing `tateDualityPairing` and its perfectness theorem keep that binder only because the
evaluation pairing is defined for discrete `A` without reference to smoothness.

**The `p`-adic valuation on a finite extension of `ℚ_p`.** Tau Ceti states local duality, the Euler
characteristic and the cyclotomic normalization for `F` whose valuation extends that of `ℚ_p`
(`ValuativeExtension ℚ_[p] F`, through Tau Ceti's `FinitePadicExtension`). The exported forms of
this roadmap carry no such hypothesis, because it is automatic:
`algebraMap_vle_algebraMap_iff_of_finite_padic` says that for a nonarchimedean local field `F` that
is a finite extension of `ℚ_p`, the valuation of `F` restricts to the `p`-adic valuation. Both the
valuation of `F` and the unique extension to `F` of the `p`-adic valuation are henselian of rank
one, and a field that is not separably closed is henselian for at most one rank-one valuation up to
equivalence (F. K. Schmidt; Engler–Prestel, *Valued Fields*, §4.4); `F` is not separably closed,
since it has finite degree over `ℚ_p`.

**Local duality and the Euler characteristic.** In mixed characteristic Tau Ceti proves, in this
order:

1. `finite_H`: `H⁰`, `H¹`, `H²` of a finite smooth discrete module are finite. Shapiro's lemma and
   dimension shifting along `0 → A → Coind_{G_L}^{G_K} A → A₂ → 0` reduce it to `G_L` acting
   trivially, and there to `ℤ/ℓ ≅ μ_ℓ`, where `H¹` is `Lˣ/(Lˣ)^ℓ` (`kummerEquiv_mixed`, finite by
   Tau Ceti's `card_powerClasses`) and `H²` is `ℤ/ℓ` (`h2MuEquivZMod_mixed`).
2. `tateDualityPairing_perfect_mixed`, for the named evaluation pairing; quantifying over an
   arbitrary pairing would admit the zero pairing. The base case is the Hilbert pairing over a
   field containing `μ_n`, read through `tateDualityPairing_muNRepToTateDual`, with
   `h2MuEquivZMod_mixed` against `H⁰ = ℤ/m` in degrees `(0,2)` and `(2,0)`; Shapiro's lemma
   (`ProfiniteCohomology.shapiroIso`) and corestriction, which preserves the invariant
   (`invMap_brCor`), give coinduced modules; and the four lemma along
   `0 → A → Coind_{G_L}^{G_K} A → A₂ → 0` and its dual (`tateDualMap_exact`), with `finite_H`,
   gives every finite smooth discrete `A`. A general finite `G_K`-module need not admit a
   filtration by trivial modules: over `ℚ_2`, the nontrivial unramified action on `ℤ/3` is the
   regression example, and it is why the closing step coinduces rather than filters.
3. The Euler characteristic, in cardinality form `eulerCharacteristic_mixed`:
   `#H¹ = #H⁰ · #H² · p^{[F:ℚ_p] v_p(#A)}`, and in `𝔽_p`-rank form
   `eulerCharacteristic_finrank_fp`. The proof is a dévissage (NSW (7.3.1)–(7.3.4); Milne,
   *Arithmetic Duality Theorems*, I, Theorem 2.8): both sides are multiplicative in short exact
   sequences (the `(0,2)` case of duality makes `H²` right exact), so they descend to the
   Grothendieck group `modRepK0` of `𝔽_ℓ[Gal(L/K)]`-modules, where the modular Artin theorem of
   `RepresentationTheory/ModularInduction` reduces them to modules induced from cyclic subgroups
   of order prime to `ℓ`; there Shapiro's lemma, semisimplicity, duality, equivariant Kummer theory
   and the lattice defect of `Lˣ/(Lˣ)^ℓ` compute both.

`finite_H`, `tateDualityPairing_perfect_mixed` and `eulerCharacteristic_finrank_fp` are exported
under these names for `LocalGaloisGroups`.

**Checks.**

- Over `ℚ_2` let `M` be `ℤ/3` with the nontrivial unramified action; Frobenius acts by
  `2 ≡ −1 mod 3`, so `M` is `μ_3`, `H⁰(ℚ_2, M) = 0`, and its dual `M' = Hom(μ_3, μ_3)` is the
  trivial module `ℤ/3`, with `#H⁰(ℚ_2, M') = 3`. Duality in degrees `(0,2)` and `(2,0)` gives
  `#H²(ℚ_2, M) = 3`, matching `H²(ℚ_2, μ_3) ≅ ℤ/3`, and `#H²(ℚ_2, M') = 1`. The Euler
  characteristic gives `#H¹(ℚ_2, M) = 1 · 3 · 1 = 3`, the factor `p^{[F:ℚ_p] v_p(#A)}` being `1`
  because `2 ∤ 3`; Kummer theory agrees, `ℚ_2ˣ/(ℚ_2ˣ)³ ≅ ℤ/3`, and so does `M'`:
  `#H¹(ℚ_2, ℤ/3) = 3 · 1 · 1`. A pairing that matched `H⁰(M)` with `H²(M)` instead of
  `H²(M')` would give `#H²(ℚ_2, μ_3) = 1`.
- Over `ℚ_p` with `p` odd and `A = ℤ/p` trivial, `#H¹ = p² = p · 1 · p`, since `ℚ_pˣ/(ℚ_pˣ)^p` has
  `𝔽_p`-dimension `2` and `μ_p ⊄ ℚ_p`; over `ℚ_2` with `A = ℤ/2`, `#H¹ = 8 = 2 · 2 · 2`, since
  `#ℚ_2ˣ/(ℚ_2ˣ)² = 8`.
- Finiteness needs the local hypothesis: over `ℚ`, which is not a local field,
  `H¹(G_ℚ, ℤ/2) ≅ ℚˣ/(ℚˣ)²` is infinite, the classes of `−1` and of the primes being independent.

**Exit criterion.** `Br K`, `invMap`, `localSymbol`, `tateDualityPairing_perfect_mixed`,
`finite_H`, `eulerCharacteristic_mixed` and `eulerCharacteristic_finrank_fp` all exist and none of
them mentions an Artin map, and `algebraMap_vle_algebraMap_iff_of_finite_padic` is proved.

### Examples

- For `ℚ_2` and `a = b = −1`, the local Hilbert symbol at `ζ = −1` is `1 ∈ ℤ/2`: `−1` is not a
  norm from `ℚ_2(i)`, since `x² + y² = −1` has no solution in `ℚ_2`.
- For `ℚ_p` with `p` odd and `a, b` units, the symbol vanishes: units are norms from the
  unramified quadratic extension.

### Dependencies

Layer 0 (the Herbrand quotient, its multiplicativity and invariance, and two-periodicity for finite
cyclic groups); `ProfiniteCohomology`; `LocalFieldsRamification`; Mathlib's normal basis theorem
`IsGalois.normalBasis`; Tau Ceti's comparison of absolute Galois groups, `classField` and Galois
action on the integers of a local field; Tau Ceti's coefficient dictionary `ofDiscreteModule` with
its smoothness predicate `IsSmoothDiscrete`, Galois-cohomology coefficients `KummerCoeff` and
`UnitsCoeff`, Kummer map `kummerMap`, explicit `H¹` with its comparison, and internal hom
`InternalHom` with its evaluation pairing; for the Euler characteristic,
`RepresentationTheory/ModularInduction` (its Layers 0, 1, 3 and 4). **Not** Layers 1–4, and in
particular not the local class formation, the local Artin map, or local existence.

## Layer 6: the local class formation and finite local reciprocity

For a nonarchimedean local field `K`, the formation is the field formation, Tau Ceti's
`unitsFormation K` (Formation/Units.lean), whose module is the multiplicative group of a separable
closure written additively: Tau Ceti's `UnitsCoeff K` through `ofDiscreteModule`, on Tau Ceti's
`AbsoluteGaloisGroup K`, so that the local Brauer group `Br K = H²(G_K, (Kˢ)ˣ)` of Layer 5 is the
continuous `H²` of the same coefficients. Its ground level is `H⁰(G_K, (Kˢ)ˣ)`, the units of `Kˢ`
fixed by all of `G_K`, which Tau Ceti's `baseUnitsEquivInvariants` identifies with `Kˣ`; that
identification is `localGroundEquiv`, through which the norm subgroups of `Kˣ` are read in Layer 8.
The local class formation is Tau Ceti's `localClassFormation` (Local/ClassFormation.lean). Its
invariant is Layer 5's: Tau Ceti's `localClassFormation_inv` identifies it with `invMap` after
inflation `brInfl`, so that Layers 5 and 6 carry one normalization. Its axioms rest on:

- Hilbert 90;
- the Layer 5 local Brauer invariant `invMap`;
- compatibility of restriction with multiplication by degree;
- the finite-layer description of the Brauer group;
- the Layer 5 cyclic norm index `index_normGroup_of_isCyclic` and the local `H²` finiteness and
  bound, from `natCard_H2_units_dvd_finrank`, which show that the degree-`n` layer contributes the
  subgroup of order `n`.

The proof of `localClassFormation` uses no local reciprocity, norm-index theorem, local existence or
local duality: each is downstream of Tate's theorem.

For a finite extension `L/K` embedded in `Kˢ` by `iota`, the restriction of `unitsFormation K` to
the open subgroup `galoisSubgroup K L iota`, read on `G_L` through Tau Ceti's
`galoisSubgroupEquiv K L iota`, is `unitsFormation L`, the module isomorphism being induced on units
by `separableClosureRingEquiv K L iota`; this is Tau Ceti's `localFormationRestrict`. The invariant
of `localClassFormation L` on a layer is then that of `localClassFormation K` on the corresponding
layer with ground `galoisSubgroup K L iota`: the first is `invMap L` after inflation, the second is
`[L:K]` times the invariant of the layer with the same top and ground `⊤` on a class it restricts
(`inv_restrict`), and `invMap_brRes` identifies the two. This is what makes the local Artin map of
`L` an abstract Artin map of the formation of `K`, and it is the input of the norm functoriality
`artinMap_norm` of Layer 7.

For a finite Galois extension `L/K` embedded by `iota : L →ₐ[K] Kˢ`, the abstract norm quotient
and Galois quotient are identified with

```text
Kˣ / N_{L/K}(Lˣ),
Gal(L/K)^ab,
```

and `localArtinEquiv`, `localArtinMap` and `normResidue` are Tau Ceti's Local/Reciprocity.lean
constructions; `Suggested.lean` keeps `localArtinMap` and `normResidue` as reducible aliases. They
transport `ClassFormation.artinEquiv` through Tau Ceti's `layerNormQuotientEquiv` and the
abelianization of `layerGalEquiv`, the native layer identifications. The map does not depend on
`iota` (`localArtinEquiv_eq_of_iota`); `normResidue` is its multiplicative form for the canonical
embedding. The arithmetic normalization

```text
localArtinMap(π_K) = arithmeticFrobenius
```

for an unramified extension is Tau Ceti's `localArtinMap_uniformizer` (`normResidue_uniformizer`),
using the Frobenius object `frobeniusAlgEquiv` exported by `LocalFieldsRamification`; units are
norms in this case, so the local Artin map is determined by the valuation modulo `[L:K]`
(`localArtinMap_eq_frobenius_pow_valuation`). The quadratic tests below, including the comparison
with the Layer 5 `localSymbol`, are Tau Ceti's.

The cohomological dimension of `G_K` is stated against `ProfiniteCohomology.cd_p` and
`ProfiniteCohomology.scd_p`, which are aliases of Tau Ceti's `cohomologicalDimensionAt` and
`strictCohomologicalDimensionAt`:

- `H³(G_K, (Kˢ)ˣ) = 0` (Tau Ceti's `subsingleton_h3_unitsRep`), since on every finite layer
  `Ĥ³(Gal(L/K), Lˣ) ≅ Ĥ¹(Gal(L/K), ℤ) = 0` by `tateIso` at degree `1` for `localClassFormation K`,
  and continuous cohomology is the finite-quotient colimit;
- `cd_ℓ G_K = 2` for `K/ℚ_p` finite and every prime `ℓ` (Tau Ceti's
  `cohomologicalDimensionAt_absoluteGaloisGroup_eq_two`; NSW (7.1.8)(i); Serre, *Galois
  Cohomology*, II §5.3): for `≤ 2`, the Sylow equality `ProfiniteProPGroups.cd_p_eq_of_isProPSylow`
  and the pro-`ℓ` test `cd_p_le_iff_elementaryAbelian_of_isProP` reduce to `H³(G_L, μ_ℓ)`, which
  embeds into `H³(G_L, (Lˢ)ˣ) = 0` because `Br L ≅ ℚ/ℤ` is divisible; for `≥ 2`,
  `H²(K(μ_ℓ), μ_ℓ) ≅ ℤ/ℓ` and `ProfiniteCohomology.cd_p_le_of_isClosed`;
- `scd_ℓ G_K = 2` (`scd_p_absoluteGaloisGroup_eq_two`, Tau Ceti's
  `strictCohomologicalDimensionAt_absoluteGaloisGroup_eq_two`; NSW (7.2.5)): `≥ 2` is
  `ProfiniteCohomology.cd_p_le_scd_p`, and `≤ 2` is the strict-dimension criterion
  `strictCohomologicalDimensionAt_le_iff_forall_openSubgroup` at `n = 2` (NSW (3.3.4)), whose
  second condition `H²(G_L, ℚ_ℓ/ℤ_ℓ) = 0` follows from the `(2,0)` case of duality at the trivial
  modules `ℤ/ℓᵐ`, dual to `μ_{ℓᵐ}(L)`, whose inverse limit under `ℓ`-th powers is `0` because
  `μ_{ℓ^∞}(L)` is finite.

The statements are for finite extensions of `ℚ_p`, at universe `0`: in characteristic `p`,
`cd_p G_K = 1`.

**Exit criterion.** The finite local map `localArtinMap` is visibly the abstract Artin map, a
uniformizer maps to arithmetic Frobenius, and the kernel is the norm group.

### Examples

- **Unramified extensions.** Let `L/K` be unramified of degree `n`, `π` a uniformizer of `K` and
  `q` the size of the residue field. Then `Kˣ / N(Lˣ)` is cyclic of order `n` with the class of `π`
  a generator, `localArtinMap(π)` is the arithmetic Frobenius, `localArtinMap(u) = 1` for every unit
  `u`, `localArtinMap(x) = Frob^{v(x)}`, and `Frob(x̄) = x̄^q`. The arithmetic Frobenius is the
  object exported by `LocalFieldsRamification`; no new automorphism with the right residue-field
  action is introduced. For `K = ℚ_p` this is the principal sign test for local reciprocity.
- `ℚ₂(ζ₅)/ℚ₂` is unramified of degree four, and `localArtinMap(2)(ζ₅) = ζ₅²`; replacing
  arithmetic by geometric Frobenius changes the exponent from `2` to `3` modulo `5`. For root order
  `m` prime to the residue characteristic, `localArtinMap(π)(ζ_m) = ζ_m^q` (Serre, *Local Fields*,
  IV §4); roots of such orders lie in the maximal unramified subextension, so the
  ambient finite Galois extension need not itself be unramified. For `K = L = ℚ_2`, `ζ = −1`,
  `m = 2` and `π = 2`, the Artin map is trivial and fixes `−1`; the excluded formula would give
  `−1 = (−1)^2 = 1`. At `m = 1` the root is `1` and the formula is valid over every local field.
- **Quadratic extensions.** For `L/K` quadratic with nontrivial automorphism `τ`,
  `localArtinMap(a) = 1` exactly when `a` is a norm from `L`, and `τ` otherwise, the smallest
  nontrivial test of the norm-kernel theorem; and `localArtinMap(a) = τ` exactly when
  `(a,d)_K = −1`. ⚠ The Hilbert-symbol comparison is stated about
  the extension `K(√d)` **exactly**: `d` a nonsquare in `Kˣ`, a chosen `s : L` with `s² = d`,
  `K(s) = L`, `[L:K] = 2`, and `τ s = −s`. A bare existential `∃ s : L, s² = d` does not pin `L`:
  it also holds for `L = K(√d, √e)`, which has degree four and three nontrivial automorphisms, none
  of which the symbol `(a,d)_K` determines. ⚠ The symbol is `localSymbol` at the named pairing
  `kummerCupPairing (-1)`; a version quantified over an arbitrary `P : TopPairing μ₂ μ₂ μ₂` is
  false, the zero pairing having that type.
- Over `ℚ₂(i)` and `a = −1`: `(−1,−1)₂ = −1`, so `−1` is not a norm and `Art(−1) = τ`.

### Dependencies

Layers 1–5; `LocalFieldsRamification`; for the cohomological dimension of `G_K` at the end of the
layer, `ProfiniteProPGroups` (`cd_p_eq_of_isProPSylow`, `cd_p_le_iff_elementaryAbelian_of_isProP`)
and `ProfiniteCohomology` Layer 11.

## Layer 7: the absolute local Artin map, its normalizations, and conductors

For a specified nonarchimedean local-field structure on `K`, Tau Ceti's
`artinMap : Kˣ → G_K^ab` (Local/ArtinMap.lean) is the inverse limit over finite abelian extensions
of the finite maps, into the topological abelianization. Its parameters include the valuation,
topology and local-field instance used in that construction. It is pinned by three named
equations, each stated against a defined map, all Tau Ceti's.

- **Restriction.** `restrictAbsolute K L iota : G_K →* Gal(L/K)` is the restriction of the absolute
  Galois group to a finite Galois extension embedded by `iota`: Tau Ceti's restriction along an
  embedding, `AlgHom.restrictNormalHom` (FieldTheory/Galois/Restriction.lean), after
  `absoluteGaloisGroupComparison`. It is characterized by
  `iota (restrictAbsolute σ x) = absoluteGaloisGroupComparison σ (iota x)`, Tau Ceti's
  `AlgHom.restrictNormalHom_commutes`. The finite maps are the restrictions of the absolute map
  (`artinMap_restrict`); because the finite quotients of `G_K^ab` are the `Gal(L/K)^ab`, this
  determines `artinMap`.
- **Unramified coordinate.** `unramifiedCoordinate : G_K^ab →ₜ* Ẑ` is Tau Ceti's: the descent to the
  topological abelianization of `restrictMaximalUnramifiedHom` followed by
  `maximalUnramifiedGaloisGroupEquivZHat` (LocalField/Unramified/Coordinate.lean), so
  `unramifiedCoordinate_mk` computes it on every class. It is continuous and surjective; its kernel
  is the image of inertia (`unramifiedCoordinate_mk_eq_one_iff`, against Tau Ceti's
  `inertiaSubgroup`), and it sends exactly the arithmetic Frobenius lifts to `zHat.gen`
  (`unramifiedCoordinate_mk_eq_gen_iff`, against `IsArithFrobeniusLift`). On the Artin map it is the
  normalized valuation (`unramifiedCoordinate_artinMap`). Hence every lift of `Art_K(u)`, `u` a
  unit, lies in inertia (`mem_inertiaSubgroup_of_mk_eq_artinMap`), and every lift of `Art_K(π)`,
  `π` a uniformizer, is an arithmetic Frobenius lift
  (`isArithFrobeniusLift_of_mk_eq_artinMap_uniformizer`).
- **Norm functoriality.** For `L/K` finite, embedded in `Kˢ` by `iota`, the image of `Art_L(x)`
  in `G_K^ab` under `absoluteGaloisGroupExtend K L iota` — Tau Ceti's map identifying `G_L` with
  the open subgroup `galoisSubgroup K L iota` of `G_K` — is `Art_K(N_{L/K} x)` (`artinMap_norm`).
  It is the absolute form of `artinMap_groundNorm`, through `localFormationRestrict` of Layer 6
  and `artinMap_restrict`.

The map is natural in the local field: a ring isomorphism `K ≃+* K'` that is a homeomorphism,
extended to the algebraic closures, carries `Art_K` to `Art_{K'}` (`artinMap_congr`); conjugation
by the extension is determined up to an inner automorphism, invisible in `G_{K'}^ab`. It has dense
image (`denseRange_artinMap`: each `localArtinMap` is surjective, and `artinMap_restrict`
transports this to every finite quotient of `G_K^ab`), kernel the intersection of the norm groups
(Layer 8, `ker_artinMap_eq_iInf`), and it is not surjective, so no finite-cardinality statement
about its target is valid. For `K/ℚ_p` finite it is continuous (`continuous_artinMap`): the
preimage of the open subgroup cutting out a finite abelian `L/K` is `normGroup K L`, which
contains the `[L:K]`-th powers, an open subgroup. `geometricArtinMap` is defined only as the
precomposition of the arithmetic map with inversion.

**The cyclotomic normalization** `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹`, with the field norm, is Tau
Ceti's: `localCyclotomicCharacter_artinMap_padic_uniformizer` (`χ_cyc(Art_{ℚ_p}(p)) = 1`,
Local/Cyclotomic.lean), `localCyclotomicCharacter_artinMap_padic` (`χ_cyc(Art_{ℚ_p}(u)) = u⁻¹` for
`u ∈ ℤ_pˣ`) and `localCyclotomicCharacter_artinMap_unit` (for `F/ℚ_p` finite with
`ValuativeExtension ℚ_[p] F`), in Local/ExplicitCyclotomicSymbol/ArtinMap.lean. This roadmap exports
them as `cyclotomicCharacter_artinMap_padic_uniformizer`, `cyclotomicCharacter_artinMap_padic` and
`cyclotomicCharacter_artinMap`, read through Mathlib's `cyclotomicCharacter`; the last carries no
compatibility hypothesis, which `algebraMap_vle_algebraMap_iff_of_finite_padic` of Layer 5 supplies,
so it is closed once that target is proved.
Tau Ceti's proof compares `Art_{ℚ_p}` with the explicit local symbols of the cyclotomic fields over
`ℚ` (`cyclotomicSymbol`, `realCyclotomicSymbol`, with the product formula `prod_cyclotomicSymbol`,
a direct computation along Milne, *Class Field Theory*, VII Example 8.2, and
`cyclotomicSymbol_norm_fixes`), so it uses no reciprocity law and no Lubin–Tate theory. These
equations are consumed by `LocalGaloisGroups` to identify the abstract Demushkin orientation, and
by Layer 10 for `sumLocalInv_brLocalization_eq_zero`.

**Conductors.** The conductor exponent, the conductor ideal and the character conductor are Tau
Ceti's attained minima `conductorExponent`, `conductorIdeal` and `characterConductorExp`, with
minimality and the unramified criterion. Character-conductor attainment uses that `ℂˣ` has no small
subgroups; continuity plus a neighbourhood basis alone is insufficient, as the identity `Kˣ → Kˣ`
is trivial on no unit-filtration subgroup. For finite abelian `L/K`, Tau Ceti's
`conductorExponent_le_iff_upperRamificationGroup_eq_bot` says that `conductorExponent K L ≤ n`
exactly when `G^n = 1`; so `conductorExponent K L` is the least `n ≥ 0` with `G^n = 1`
(`conductorExponent_eq_sInf_upperRamificationGroup`, a corollary), `0` exactly for unramified
`L/K` and otherwise `1 + u` for the largest upper jump `u`, an integer by Hasse–Arf. For a
character `χ` of `Gal(L/K)`, the least `n` with `χ ∘ normResidue` trivial on `U_K^(n)` is the least
`n` with `χ(G^n) = 1` (Tau Ceti's `conductorExponent_fixedField_ker`).

**The absolute upper ramification groups.** Let `K` be a nonarchimedean local field, in either
characteristic, and `G_K = Field.absoluteGaloisGroup K` with the Krull topology. Its finite levels
are the `M : FiniteGaloisIntermediateField K (AlgebraicClosure K)`, each carrying Tau Ceti's
local-field structure on finite intermediate fields (`finiteIntermediateFieldValuativeRel`,
`finiteIntermediateFieldTopology`, `finiteIntermediateField_isNonarchimedeanLocalField`,
`finiteIntermediateField_valuativeExtension`). For real `u ≥ −1` define the absolute upper
ramification group `G_K^u` as the set of `σ ∈ G_K` whose restriction
`AlgEquiv.restrictNormalHom M σ` lies in
`Gal(M/K)^u = LocalFieldsRamification.upperRamificationGroup K M u` for every finite level `M`:
the intersection over `M` of the preimages of the finite upper groups, hence a subgroup (Milne,
*Class Field Theory*, I §4, the definition after Proposition 4.4, p. 46). This is
`localAbsoluteUpperRamificationGroup K u`, with `u` in Tau Ceti's
`LocalFieldsRamification.RamificationIndexDomain`, the reals `u ≥ −1`; the local-field structure
of the finite levels is installed as local instances.

- For every `u ≥ −1`, `G_K^u` is closed in `G_K`, since each restriction is continuous into the
  finite discrete group `Gal(M/K)` (`InfiniteGalois.restrictNormalHom_continuous`); hence it is
  compact, `G_K` being compact (Tau Ceti's `CompactSpace (Field.absoluteGaloisGroup K)` instance).
- **Finite projections.** For every finite level `M` and every `u ≥ −1`, restriction maps `G_K^u`
  onto `Gal(M/K)^u`. For finite levels `M ⊆ M′`, restriction carries `Gal(M′/K)^u` onto
  `Gal(M/K)^u`: Herbrand's theorem in the upper numbering, Tau Ceti's
  `LocalFieldsRamification.map_restrictNormalHom_upperRamificationGroup`, applied to `M′/M/K` with
  the local-field structures of the two levels and the valuative structure of `M′` over `M` given
  by Tau Ceti's `AlgHom.valuativeExtension` along the inclusion (Milne, *Class Field Theory*, I,
  Proposition 4.4, p. 46). Given `τ ∈ Gal(M/K)^u`, for each finite level `M′ ⊇ M` the set of
  `σ ∈ G_K` with `σ|_M = τ` and `σ|_(M′) ∈ Gal(M′/K)^u` is closed, and it is nonempty because `τ`
  lifts to `Gal(M′/K)^u` and every element of `Gal(M′/K)` lifts to `G_K`
  (`AlgEquiv.restrictNormalHom_surjective`). Finitely many of these sets contain the one of the
  compositum of their levels, so compactness of `G_K` gives an element in all of them; it lies in
  `G_K^u`, because every finite level lies in a level containing `M`, and restricts to `τ`.

*Needs:* Tau Ceti's `LocalFieldsRamification.upperRamificationGroup`,
`LocalFieldsRamification.map_restrictNormalHom_upperRamificationGroup`, the local-field structure
on finite intermediate fields, `AlgHom.valuativeExtension`
(`TauCeti/NumberTheory/LocalField/AlgebraicExtension/Basic.lean`) applied to the inclusion
`M → M′` for the valuative structure of `M′` over `M` that Herbrand's theorem takes, and the
compactness of `G_K`; Mathlib's `FiniteGaloisIntermediateField`, `AlgEquiv.restrictNormalHom`,
`AlgEquiv.restrictNormalHom_surjective` and `InfiniteGalois.restrictNormalHom_continuous`.

**Checks.**

- At `u = −1` every finite upper group is the whole group, so `G_K^(−1) = G_K`. For
  `−1 < u ≤ 0` every finite upper group is the inertia group `G_0`, a real index being read
  through its ceiling, so at the unramified level `M` of degree `f`, `G_K^u` restricts trivially
  to `M` while `G_K` maps onto `Gal(M/K) ≅ ℤ/f`: the filtration drops below `G_K` just above `−1`
  and is constant on `(−1, 0]`; reading the index through its floor would keep `G_K^u = G_K` there.
- For odd `p`, `K = ℚ_p` and the level `ℚ_p(ζ_p)`, the image of `G_K^0` is all of
  `Gal(ℚ_p(ζ_p)/ℚ_p) ≅ (ℤ/p)ˣ` and the image of `G_K^u` is trivial for every `u > 0`, the level being
  tamely and totally ramified.
- For `K = ℚ_2`, take the levels `ℚ_2(ζ_8)`, with group `(ℤ/8)ˣ` and upper groups `G` for `u ≤ 1`,
  `{1, 5}` for `1 < u ≤ 2` and `1` for `u > 2`, and its subfield `ℚ_2(√2)`, the fixed field of
  `{1, 7}`, with break `2`. The images of `G_K^u` at both levels agree with restriction at every
  `u`. The lower numbering cannot replace the upper one in the definition: at depth `3` the lower
  group of `ℚ_2(ζ_8)/ℚ_2` is `{1, 5}`, but `σ_5` restricts to the nontrivial element of
  `Gal(ℚ_2(√2)/ℚ_2)`, whose lower group at depth `3` is trivial, so the set defined with lower
  groups at depth `3` does not map onto `{1, 5}`.

**Unit-filtration reciprocity** (`map_unitFiltration_normResidue`). Let `L/K` be a finite abelian
extension of nonarchimedean local fields, in equal or mixed characteristic, with group `G`, and let
`G^v` be its upper ramification groups, `LocalFieldsRamification.upperRamificationGroup`. Write
`U_K^(0) = 𝒪[K]ˣ` and `U_K^(n) = 1 + 𝔪_K^n` for `n ≥ 1`, the groups `unitFiltration K n`. For every
integer `n ≥ 0`, `normResidue` carries the image of `U_K^(n)` in `Kˣ/N_(L/K)(Lˣ)` onto the image of
`G^n` in `Gal(L/K)^ab = Gal(L/K)`: `U_K^(n) ↔ G^n`. At `n = 0` this says that the units map onto
the inertia group `G_0`; the map is the arithmetic normalization of Layer 6, under which a
uniformizer maps to an arithmetic Frobenius on the maximal unramified subextension. The absolute
form follows (`closure_map_artinMap_unitFiltration`): for every `n ≥ 0`, the closure of
`artinMap(U_K^(n))` in `G_K^ab` is the image of the absolute upper ramification group `G_K^n`
defined above under the quotient map
`Field.absoluteGaloisGroup K → Field.absoluteGaloisGroupAbelianization K`, `G_K^n` being
`localAbsoluteUpperRamificationGroup K n`. (Jean-Pierre
Serre, [Local Fields](#source-serre-local-fields), XV §2, Theorem 2 and Corollary 3 to Theorem 1.)

**Filtered norms.** Two norm statements for a finite Galois extension `E/F` of nonarchimedean
local fields with group `J`, in either characteristic, at an integer `r ≥ 0`, enter the proof:

- if `J^r = 1`, then `N_(E/F)(U_E^(ψ_(E/F)(r))) = U_F^(r)`. This is Tau Ceti's
  `map_normUnits_unitFiltration_psiNat_eq_of_upperRamificationGroup_eq_bot`, for every finite
  Galois `E/F` and without an abelian or totally ramified hypothesis;
- if `J` is abelian and `J^r = J`, then `U_F^(0) = N_(E/F)(U_E^(0)) · U_F^(r)`
  (`sup_norm_unitFiltration_eq_of_upper_eq_top`), a target of this layer (Serre, *Local Fields*,
  V §§3, 6). The hypothesis `J^r = J` forces `E/F` to be totally ramified, since
  `J^r ⊆ J^0 = J_0` for `r ≥ 0`, so total ramification is not a separate hypothesis. For prime
  degree it follows from surjectivity of the graded norms (`normGradedMap`) at depths strictly
  below the unique break. For a general finite abelian group, induct along a
  prime-order quotient series: Herbrand's quotient and subgroup theorems
  (`upperRamificationGroup_quotient`, `upperRamificationGroup_fixedField`) transport the hypothesis
  to the two steps; decompose `U_F^(0)` using the quotient step and then `U_M^(0)` using the
  subgroup step, and the shifted norm inclusion `map_normUnits_unitFiltration_psiNat_le` sends the
  remaining `U_M^(ψ_(M/F)(r))` into `U_F^(r)`. This proof uses no reciprocity comparison.

*Proof of unit-filtration reciprocity.* Functoriality in finite quotients and norms
(`artinMap_quotient`, `artinMap_groundNorm`) reduces to `L/K` totally ramified: for the maximal
unramified subfield `L_0`, the upper groups at nonnegative depths are those of `L/L_0`, and
`N_(L_0/K)(U_(L_0)^(n)) = U_K^(n)`. At depth zero, the norm valuation formula and the norm-index
theorem identify the image of the units with inertia: for a totally ramified extension, a norm of a
uniformizer is a uniformizer, so the units surject onto the norm quotient; unramified normalization
and norm functoriality give the general case. This uses finite reciprocity, not the all-depth
comparison.

For a totally ramified abelian `L/K`, put `H = G^n`, `M = L^H` and `s = ψ_(M/K)(n)`. Herbrand's
quotient theorem gives `(G/H)^n = 1`, and its subgroup formula gives `H^s = H`. The two filtered
norm statements give `N_(M/K)(U_M^(s)) = U_K^(n)` and `U_M^(0) = N_(L/M)(U_L^(0)) · U_M^(s)`.
Depth-zero reciprocity for `L/M` therefore gives `Art_(L/M)(U_M^(s)) = H`. Norm functoriality
carries this equality to `Art_(L/K)(U_K^(n)) = H`, including `H = G`, `H = 1` and `n = 0`.

For the absolute form, restrict to every finite abelian quotient using `artinMap_restrict`. The
finite projections of `G_K^n` identify its image in `Gal(L/K)` with `Gal(L/K)^n` at every finite
abelian level `L`. Its image in `G_K^ab` is compact, `G_K^n` being closed in the compact `G_K`,
hence closed, so agreement in all finite abelian quotients identifies it with the closure of the
Artin image.

*Needs:* Layer 4 (`artinMap_quotient`, `artinMap_groundNorm`); Layer 6 (`normResidue`, finite
reciprocity, the norm kernel and unramified normalization); `artinMap_restrict` above; Tau Ceti's
`unitFiltration`, the norm valuation formula, `LocalFieldsRamification.psiNat`,
`upperRamificationGroup_quotient`, `upperRamificationGroup_fixedField`,
`map_normUnits_unitFiltration_psiNat_le`, `normGradedMap`,
`map_normUnits_unitFiltration_psiNat_eq_of_upperRamificationGroup_eq_bot` and
`LocalFieldsRamification.hasseArf`; for the absolute form, the absolute upper ramification groups
above, with their closedness and finite projections, and Mathlib compactness for the Artin-image
comparison.

**Checks.**

- For the trivial extension both filtered norm statements reduce to identity norms and every upper
  group is trivial; the conductor is `0`.
- In a totally ramified tame extension, the second filtered norm statement at `r = 0` is
  tautological, and the first at `r = 1` gives surjectivity on principal units.
- For `ℚ_2(√2)/ℚ_2`, the break is `2` in both numberings: the second statement at `r = 2` gives
  `U_K^(0) = N(U_L^(0)) · U_K^(2)` (`N(1 + √2) = −1 ∉ 1 + 4ℤ_2`), and the first at `r = 3` gives
  `N(U_L^(ψ(3))) = U_K^(3)` with `ψ(3) = 4`. The first cannot be extended to `r = 2`: `5 ∈ U_K^(2)`
  is not a norm. These test `H = G` and `H = 1` in the fixed-field argument.
- Over `ℚ_2`, the field `ℚ_2(∛2, ζ_3)` is tame with group `S_3`, `e = 3` and `G^1 = 1`, and
  `ψ(1) = 3`, so `N(U_L^(3)) = U_K^(1)`: the first statement needs neither abelian nor totally
  ramified extensions.
- At depth `0`, the absolute comparison identifies the closure of `artinMap(𝒪[K]ˣ)` with the
  image of `G_K^0`, whose restriction to every finite level is that level's inertia group; its
  image in an unramified finite quotient is trivial.
- For an unramified `L/K`, `G^0 = G_0 = 1`, so `normResidue` kills `U_K^(0)`, the conductor
  exponent is `0`, and a uniformizer maps to the arithmetic Frobenius.
- For odd `p`, `K = ℚ_p` and `L = ℚ_p(ζ_p)`, `G^0 = G` and `G^v = 1` for `v > 0`, so
  `normResidue(U_K^(0)) = Gal(L/K)`, `normResidue(U_K^(1)) = 1` and the conductor exponent is `1`:
  units of positive depth do not reach tame inertia.
- For `K = ℚ_2` and `L = ℚ_2(√2)`, `normResidue(U_K^(2)) = Gal(L/K)` and `normResidue(U_K^(3)) = 1`:
  `5 ∈ U_K^(2)` is not a norm, `1 + 8ℤ_2` consists of norms, and the conductor exponent is `3`.
- For `K = F_p((t))` and `y^p − y = t⁻¹`, the break is `1`, so `normResidue(U_K^(1)) = Gal(L/K)`,
  `normResidue(U_K^(2)) = 1` and the conductor exponent is `2`, in equal characteristic.
- The lower numbering cannot replace the upper one: for `ℚ_2(ζ_8)/ℚ_2`, `G_3 = ⟨σ_5⟩` while
  `G^3 = 1`, and indeed `U_(ℚ_2)^(3) = 1 + 8ℤ_2` consists of norms from `ℚ_2(ζ_8)`, whose conductor
  exponent is `3`.

**Exit criterion.** `LocalGaloisGroups` can consume the local-cohomological exports of this roadmap
by name, `cyclotomicCharacter_artinMap` included, and `map_unitFiltration_normResidue`,
`sup_norm_unitFiltration_eq_of_upper_eq_top` and `closure_map_artinMap_unitFiltration` are proved.

### Examples

- At `ℚ_p`, the unramified coordinate of `Art(p)` is the generator `zHat.gen` and that of a unit is
  trivial, and `χ_cyc(Art(u)) = u⁻¹`; at `p = 2`, test `u = −1`, `u = −3` and the uniformizer
  separately.
- At `p = 2` and `u = −1`, the explicit symbol is `−1 = u⁻¹` on `μ_{2^n}`, so
  `χ_cyc(Art_{ℚ_2}(−1)) = −1`: `−1` is not a norm from `ℚ_2(i)`, so `i ↦ −i`. At `u = −3` on `μ_16`,
  `(−3)⁻¹ ≡ 5 mod 16`, against `13` without the inverse.
- The uniformizer: `p = N(1 − ζ_{p^n})` for every `n ≥ 1`, so `Art_{ℚ_p}(p)` fixes `μ_{p^∞}`.

### Dependencies

Layers 4–6; `LocalFieldsRamification` (with Tau Ceti's maximal unramified extension, inertia,
arithmetic Frobenius lifts and `Gal(K^ur/K) ≅ Ẑ`, and, for unit-filtration reciprocity, the
declarations listed under *Needs*); Tau Ceti's `galoisSubgroup`, `galoisSubgroupEquiv`, `zHat`,
`inertiaSubgroup`, the local-field structure on finite intermediate fields,
`AlgHom.valuativeExtension`,
`LocalFieldsRamification.map_restrictNormalHom_upperRamificationGroup` and the compactness of
`G_K`; for the cyclotomic normalization, Tau Ceti's explicit cyclotomic
symbols and Layer 5's `algebraMap_vle_algebraMap_iff_of_finite_padic`.

## Layer 8: separate arithmetic local existence and the local class-field correspondence

The endpoint of the layer is a **correspondence**, not an existence statement. `∃ V, N(V) = N` on
its own names nothing: by the norm limitation theorem of Layer 4 a layer and its maximal abelian
sublayer have the same norm subgroup, so a nonabelian `V` and `maximalAbelianLayer V` are two
witnesses to the same existence statement. Every final target below therefore either constrains `V`
to be an abelian layer or is explicitly labelled a forgetful corollary. Tau Ceti implements the
layer (`TauCeti/NumberTheory/ClassFieldTheory/LocalExistence/`), under the names below.

After reciprocity is established, develop the topology of norm subgroups and prove:

- the norm subgroup `localNormSubgroup V ≤ Kˣ` of an open normal subgroup of `G_K` is open
  (`isOpen_localNormSubgroup`) and of finite index (`finiteIndex_localNormSubgroup`);
- it is monotone in `V` (`localNormSubgroup_mono`) — hence inclusion-reversing on fields — and
  respects composita and intersections; `localNormSubgroup_top` pins the extreme case
  `V = ⊤ ↦ K ↦ Kˣ`, which is what fixes the direction of the correspondence;
- the concrete forms of norm limitation, `localNormSubgroup_maximalAbelianLayer`;
- for `K/ℚ_p` finite, every open finite-index subgroup of `Kˣ` is the norm subgroup of a finite
  **abelian** layer (`localAbelianExistence`), with `localExistence` retained only as the
  corollary that forgets abelianity;
- for a general nonarchimedean local field of residue characteristic `p`, every open finite-index
  subgroup of `Kˣ` whose index is prime to `p` is the norm subgroup of a finite abelian layer
  (`localAbelianExistence_primeToResidueCharacteristic`), again with a forgetful corollary; no
  `p`-primary equal-characteristic claim is exported;
- **uniqueness**: distinct finite abelian extensions have distinct norm subgroups
  (`localClassField_unique`). This is the half that turns existence into *the* class field
  attached to `N`, and it is false without the abelianity hypotheses;
- **the class field** `localClassField K p N`, defined from existence and canonical by uniqueness,
  with its characterizing equation `localClassField_normSubgroup`;
- **the correspondence** at its two local scopes: `localClassFieldCorrespondence`, the full
  correspondence for finite extensions of `ℚ_p`, and
  `localClassFieldCorrespondencePrimeToResidueCharacteristic`, whose two carriers
  `LocalNormSubgroupsPrimeTo` and `AbelianLayerPrimeTo` are cut down by the prime-to-`p` condition
  so that the excluded equal-characteristic `p`-primary case cannot be read off it. Each scope
  carries both order statements: `localClassField_le_iff` on subgroups and
  `localClassField_orderReversing` on fields, with
  `localClassFieldPrimeToResidueCharacteristic_orderReversing` at the prime-to-`p` scope;
- **the quotient isomorphism and the degree**: `localAbelianGaloisEquiv` is an isomorphism
  `Kˣ / N_{L/K}(Lˣ) ≃ Gal(L/K)` onto the Galois group of the layer itself, not onto an
  abelianization, and `localAbelianGaloisEquiv_artinMap` says it is the abstract Artin map of the
  layer read through `abelianizationGalEquiv`. `index_localNormSubgroup` and
  `localClassField_index` are the equality `[Kˣ : N] = [L : K]`;
- for `K/ℚ_p` finite, injectivity of the absolute `artinMap` (`injective_artinMap`) and the
  comparison with the profinite completion of `Kˣ`, both of which follow from
  `localAbelianExistence`; the kernel description `ker_artinMap_eq_iInf` — the kernel is the
  intersection of all norm subgroups — holds for every local field. ⚠ Injectivity is **not**
  asserted in equal characteristic: every prime-to-`p` norm subgroup contains the pro-`p` principal
  units, so the intersection of the norm subgroups this roadmap constructs there is not trivial,
  and the missing extensions are the excluded Artin–Schreier–Witt ones;
- the compatibility of the Layer 7 conductors with existence: the norm subgroup attached to an
  abelian extension of conductor exponent `n` contains `U(K,n)` and no smaller step of the unit
  filtration. In either scope of existence, the class field attached to `U(K,n)·⟨π⟩` has
  conductor at most `n`, equal to `n` exactly when this subgroup contains no `U(K,m)` with `m < n`
  (Milne, *Class Field Theory*, I §1, 1.9, p. 23).

The construction order is normative: norm subgroups first define the normic topology and its
completion; norm limitation precedes `localAbelianExistence_primeToResidueCharacteristic`; the
Layer 5 Kummer theory then gives `localAbelianExistence` for finite extensions of `ℚ_p`, after
which uniqueness, the correspondence, injectivity and the comparison with the profinite completion
follow. Local class field theory here is routed through the class formation and Kummer theory,
never through Lubin–Tate theory. Full equal-characteristic `p`-primary existence requires the
excluded Artin–Schreier–Witt theory and is not asserted here.

There is deliberately no abstract existence theorem for `ClassFormation`. This layer verifies its
arithmetic and topological inputs in the two stated ranges. Existence does not appear as a
hypothesis in a structure used to prove reciprocity.

**Exit criterion.** `localClassFieldCorrespondence` and
`localClassFieldCorrespondencePrimeToResidueCharacteristic` are proved — which subsumes
`localAbelianExistence`, `localClassField_unique` and both order statements — and `artinMap` is
injective for finite extensions of `ℚ_p`.

### Examples

- For `K = ℚ_2`, `U_K^(0) = U_K^(1) = ℤ_2ˣ`, so `U_K^(1)·⟨2⟩ = Kˣ` defines the trivial
  extension, of conductor `0` rather than `1`.
- At depth `0`, `U_K^(0)·⟨π⟩ = Kˣ`, again giving the trivial class field.
- For odd `p`, the class field of `U_(ℚ_p)^(1)·⟨p⟩` is `ℚ_p(ζ_p)`, of conductor `1`:
  `N(1 − ζ_p) = p` and the unit norms are `U^(1)`, of index `p − 1`; `U_(ℚ_p)^(0)` is not contained
  in this subgroup.
- The whole group `Kˣ` corresponds to the layer `V = ⊤`, that is to `K` itself; the trivial
  subgroup, which is not of finite index, corresponds to no finite layer.

### Dependencies

Layers 4–7. In particular the Kummer theory of Layer 5 (`kummerClass`, `kummerEquiv_mixed`,
`h2MuEquivZMod_mixed`), the local duality of Layer 5 and the Galois dictionary `classField` of
Layer 5 are prerequisites of this layer, not consequences of it.

## Layer 9: the local Weil group

A full layer, not a corollary of reciprocity, implemented in Tau Ceti
(`TauCeti/NumberTheory/ClassFieldTheory/WeilGroup/`). In order:

- **the carrier.** `localWeilGroup K ≤ G_K`, with the valuation, topology and nonarchimedean
  local-field instance retained as parameters, is the preimage of `ℤ ⊆ Ẑ` under the imported
  surjection `G_K → Gal(K^ur/K) ≅ Ẑ`; it contains inertia (`inertiaSubgroup_le_localWeilGroup`), is
  normal, is dense in `G_K` (`dense_localWeilGroup`) and is a proper subgroup;
- **the topology.** `WeilGroup K` is a type synonym for that subgroup carrying the **Weil
  topology**, the unique group topology in which inertia, *carrying the profinite topology it
  already has as a closed subgroup of `G_K`*, is an open subgroup — equivalently, the unique group
  topology making `I_K ↪ W_K` an open topological embedding
  (`isOpenEmbedding_inertiaToWeil`, `weilTopology_unique`). ⚠ Requiring only that the subgroup be
  open does **not** determine the topology: one could refine the topology on `I_K` itself and
  translate it across the cosets, so the fixed profinite topology on `I_K` is part of the
  characterization. ⚠ It is also not the subspace topology: inertia is *not* open in `G_K`,
  because its image in `Ẑ` is the non-open singleton, while it is open in `W_K`
  (`isOpen_inertia_weil`). `W_K` is a locally compact, totally disconnected topological
  group, it is not compact, and the inclusion `weilToAbsolute : W_K → G_K` is a continuous
  injection with dense image;
- **functoriality under finite extensions.** `weilTransfer` is a continuous injection
  `W_L → W_K` with open image (`isOpen_range_weilTransfer`) of index `[L:K]`
  (`index_range_weilTransfer`); the degree map is multiplied by the residue degree along it
  (`weilDegree_weilTransfer`), so `deg_K = f(L/K) · deg_L`, equal only in the totally ramified
  case. The characterizing equation `weilToAbsolute_weilTransfer` is
  `weilToAbsolute K (weilTransfer K L iota w) = absoluteGaloisGroupExtend K L iota (weilToAbsolute L w)`.
  Thus the inclusion is attached to the selected separable-closure identification, including its
  conjugation choice. Since `weilToAbsolute` is injective, the characterizing equation makes the
  transfer along the identity embedding the identity, and transfers compose along composable
  embeddings. For `L/K` finite Galois, restriction `weilRestrict : W_K → Gal(L/K)` is surjective
  with kernel the image of `weilTransfer` (`range_weilTransfer_eq_ker_weilRestrict`);
- **the exact sequence with inertia.** `weilDegree : W_K → ℤ` is surjective
  (`surjective_weilDegree`) with kernel inertia (`ker_weilDegree`), giving
  `1 → I_K → W_K → ℤ → 1`, and it agrees with the frozen `unramifiedCoordinate`
  (`unramifiedCoordinate_weilDegree`), which fixes the arithmetic normalization;
- **the abelianization comparison**, for `K/ℚ_p` finite. `localWeilArtinEquiv : Kˣ ≃ₜ* W_K^ab`
  onto the **topological** abelianization `W_K / closure ⁅W_K, W_K⁆`. ⚠ The algebraic
  `Abelianization (W_K)` is the wrong target: the commutator subgroup of `W_K` need not be closed.
  `localWeilArtinEquiv_compat` and `mem_range_artinMap_iff` identify the image of `artinMap` in
  `G_K^ab` with the image of the Weil group, under the same hypotheses.

*Source:* Tate, *Number theoretic background*, Corvallis Part 2, §1, for the Weil carrier,
topology and finite-extension inclusions; the chosen embedding is Tau Ceti's conjugation map in
FieldTheory/Galois/AbsoluteGaloisGroup/FiniteExtension.lean.

Injectivity of `artinMap` (`injective_artinMap`), hence Layer 8, is a prerequisite of the
abelianization comparison, and it is available for finite extensions of `ℚ_p` only; so the
carrier, the topology, functoriality and the inertia sequence are stated for every nonarchimedean
local field, and the reciprocity isomorphism is not. ⚠ For `𝔽_q((t))` the prime-to-`p` norm
subgroups all contain the principal units, so no equal-characteristic form of `Kˣ ≃ W_K^ab` is
reachable without the excluded Artin–Schreier–Witt theory. Global Weil groups are outside this
roadmap.

**Exit criterion.** `W_K` has a carrier, a topology, functoriality, an exact sequence and, in
mixed characteristic, a reciprocity isomorphism `localWeilArtinEquiv`, each with a name.

### Examples

- For `L = K` with the identity absolute embedding, the Weil inclusion is the identity.
- In a tower with compatible separable-closure identifications, the two successive inclusions
  equal the direct inclusion.
- For an unramified extension of degree `d`, a degree-one Weil element maps to degree `d`.
- A noncentral inner twist of `W_L` preserves its image and degree but fails the characterizing
  square; the square therefore fixes the inclusion beyond its image and index.

### Dependencies

Layers 5–8; Tau Ceti's unramified-extension API (`inertiaSubgroup` and the exact sequence
`1 → I_K → G_K → Ẑ → 1`).

## Layer 10: global carriers, the Brauer sequence, and the sum of local invariants

Use the idele and idele-class carriers from `GlobalNumberFields` through Tau Ceti's
Global/Formation.lean: `ideleFormation` and `globalFormation` are Tau Ceti's formations for a
fixed separable closure of the number field `K`. Their finite-layer coefficient comparisons
identify the action with the placewise arithmetic Galois action on ideles and its
quotient action on idele classes. The formation of the multiplicative groups `Lˣ` themselves is the
field formation of Layer 6, Tau Ceti's `unitsFormation K`. Tau Ceti implements the
layer, under the names below.

Build the archimedean half of the local package here, since the global sum needs it: the complex
Brauer group vanishes, the real Brauer group is cyclic of order two, and the nontrivial real class
has invariant `1/2` (`infiniteInvMap`, `infiniteInvMap_eq_zero_of_isComplex`,
`range_infiniteInvMap_of_isReal`). ⚠ Real places are not ignorable: dropping them already breaks
the sum formula for `ℚ(i)/ℚ`.

The archimedean Artin maps are built here too, before the sum formula uses them; Layer 11 only
consumes them. They come from the formation machinery of Layers 1–4 and the archimedean Brauer
computation, with no reciprocity law:

- `infiniteClassFormation K w`, the field formation of `K_w` as a class formation (Hilbert 90 and
  `infiniteInvMap`), whose invariant on a layer over `K_w` is `infiniteInvMap` after inflation
  (`infiniteClassFormation_inv`);
- `infiniteArtinAt K w : K_wˣ → G_{K_w}^ab`, which on every layer `V ◁ ⊤` is the abstract Artin
  map of that class formation (`infiniteArtinAt_layer`), so Layer 4's `character_artinMap` gives
  the archimedean character formula `χ(Art_w x) = inv_w(x ∪ δχ)` as a closed proof
  (`character_infiniteArtinAt`); on `ℂ/ℝ` this is Tau Ceti's `realInv_realClass`, the cyclic
  class of `x` at complex conjugation having invariant `0` or `1/2` by the sign of `x`;
- `Art_ℂ` is trivial (`infiniteArtinAt_eq_one_of_isComplex`), and `Art_ℝ` has kernel
  `ℝ_{>0} = N_{ℂ/ℝ}(ℂˣ)` and sends a negative element to complex conjugation
  (`infiniteArtinAt_eq_one_iff_of_isReal`), so it acts on the `m`-th roots of unity through
  `realCyclotomicSymbol m` (`infiniteArtinAt_rootsOfUnity_of_isReal`);
- norm functoriality at the archimedean places, the analogue of `artinMap_norm`
  (`infiniteArtinAt_norm`): elementary, the norm being the identity for `ℝ/ℝ` and `ℂ/ℂ` and
  positive for `ℂ/ℝ`, where both sides are trivial.

Continuous cohomology of the absolute Galois group is the imported finite-quotient colimit from
`ProfiniteCohomology`; no second continuous carrier is built here. The exact sequence

```text
0 → Br(K) → ⨁_v Br(K_v) → ℚ/ℤ → 0
```

is in invariant coordinates: `finiteInvAt` and `infiniteInvAt` are the local invariants,
`brauerSupport` is the finite ramification set, `brLocalization` is the localization map and
`sumLocalInv` the sum of local invariants. Injectivity of `brLocalization`
(Albert–Brauer–Hasse–Noether) is Tau Ceti's
`brLocalization_injective_of_subsingleton_h1_globalFormation`, applied with the `H¹`-vanishing
`subsingleton_h1_globalFormation` below; the vanishing of the sum of the local invariants of a
global class is `sumLocalInv_brLocalization_eq_zero`; and `exists_br_of_sum_eq_zero` says that a
finitely supported family of local invariants with zero sum, of order dividing two at real places
and zero at complex ones, comes from `Br K`.

**Global Herbrand quotients and fixed points** (`herbrandQuotient_ideleClassRep_eq_finrank`). For a
finite Galois extension `L/K` of number fields, with its arithmetic action of `G = Gal(L/K)`,
extension of ideles induces `C_K ≃ C_L^G`. Under this comparison the group norm
`c ↦ ∏_(σ ∈ G) σ(c)` is the arithmetic idele-class norm, giving
`Ĥ⁰(G, C_L) ≃ C_K/N_(L/K)(C_L)`. Hilbert 90 applied to `1 → Lˣ → I_L → C_L → 1` supplies
the fixed-point comparison; it uses no global reciprocity.

For cyclic `G`, the Tate groups `Ĥ⁰(G, C_L)` and `Ĥ⁻¹(G, C_L)` are finite and
`h_G(C_L) = [L:K]`. The statement is on the native finite-layer representation, with the
finite-layer coefficient comparisons above identifying it with `C_L`. Its finite-set inputs are the
following calculations on the imported arithmetic carriers:

- The S-idele Herbrand calculation: let `S` be a finite set of places of `K` containing all
  archimedean places and all places ramified in `L`, and let `T` be its full inverse image in
  `L`. For `I_(L,T) = ∏_(w ∈ T) L_wˣ × ∏_(w ∉ T) 𝒪_wˣ`, the two Tate groups defining its
  Herbrand quotient are finite and `h_G(I_(L,T)) = ∏_(v ∈ S) [L_w:K_v]`, with any `w | v`.
  Shapiro and the local norm-index calculation give the factors, including degree two at a
  real place that becomes complex; the unramified unit factors outside `T` have quotient `1`.
- The S-unit Herbrand calculation: for `U_(L,T) = Lˣ ∩ I_(L,T)`, the same two Tate groups
  are finite and `h_G(U_(L,T)) = (∏_(v ∈ S) [L_w:K_v])/[L:K]`. Use the Galois-equivariant
  logarithmic unit lattice and its torsion subgroup, whose Herbrand quotient is `1`.
- The S-class-group comparison: the quotient map gives the exact sequence
  `1 → U_(L,T) → I_(L,T) → C_L → Cl_(L,T) → 1`, where `Cl_(L,T)` is the ideal class group
  modulo the classes of the finite primes in `T`. Enlarge `S` by the base places under primes
  generating the ideal class group of `L`; then `Cl_(L,T) = 1`. Multiplicativity gives the
  stated idele-class quotient and finiteness before either fundamental inequality is used.

*Source:* Milne, *Class Field Theory*, VII, Proposition 2.7, Proposition 3.1, Lemmas 4.1–4.2
and Theorem 4.3, pp. 206–211.

**Checks.**

- For `L = K`, all local degrees and all three Herbrand quotients are `1`; the Tate groups
  are trivial and the fixed-point comparison is the identity.
- For `ℚ(i)/ℚ` with `S = {∞, 2}`, the local-degree product is `4`, the S-unit quotient is
  `2`, and the idele-class quotient is `2`. Omitting the real place loses a factor of `2`.
- If `S` does not kill the S-class group, the cokernel above remains present; enlarging `S`
  to include places under its generators removes it. Adding an unramified nonsplit place
  multiplies both finite-set quotients by its local degree and leaves `h_G(C_L)` unchanged.

The hard arithmetic input is separated from the abstract formalism. This Herbrand calculation
establishes the first fundamental inequality, then the second and the required `H¹`-vanishing and
order of `H²`:

- the first fundamental inequality, `degree_le_natCard_normQuotient_of_isCyclic`, from
  `herbrandQuotient_ideleClassRep_eq_finrank` and the fixed-point and norm comparisons (Milne VII,
  Corollary 4.4);
- the second fundamental inequality, reduced to cyclic extensions of prime degree by the usual
  Sylow and tower arguments, in its `H²` form `natCard_H2_globalFormation_dvd_degree` (Milne VII,
  Theorem 5.1);
- `H¹`-vanishing for idele classes, `subsingleton_h1_globalFormation`, from which inflation on
  `H²` of idele classes is injective and inflation–restriction in degree two is exact.

`sumLocalInv_brLocalization_eq_zero` is Milne VII Theorem 8.1(b), from the local symbols alone. For
`a ∈ ℚˣ` and `ℚ(μ_m)/ℚ` the local Artin symbols are Layer 7's explicit ones (the cyclotomic
normalization on the `ℓ`-power roots of unity at `ℓ`, `localArtinMap_cyclotomic_uniformizer` on
the others, `infiniteArtinAt_rootsOfUnity_of_isReal` at `∞`), so their product is `1` by
`prod_cyclotomicSymbol` (Example 8.2). `artinMap_norm` and `infiniteArtinAt_norm` carry this
product formula to the cyclotomic extensions of every number field (Lemma 8.4). For a cyclic layer,
the character formula at each place (Layer 4's `character_artinMap` for the local class formations,
`character_infiniteArtinAt` at the archimedean places) turns it into the vanishing of the sum of
local invariants on `H²(Gal(L/K), Lˣ)` (Lemma 8.5). Every class of `Br K` lies in `H²` of a cyclic
cyclotomic layer, by injectivity of `brLocalization` and the local degrees of cyclotomic extensions
(Proposition 7.2, Lemma 7.3), which gives the general case (Lemma 8.6).

Then define the layer invariant. On an idele layer, `H²(Gal(L/K), I_L)` is the direct sum of the
local Brauer groups, and `ideleSumLocalInv` is the sum of `ideleLocalInvAt` and
`ideleInfiniteInvAt` over the places, finitely supported by `ideleSupport` and inflation-invariant
(`ideleSumLocalInv_infl`). Because `sumLocalInv_brLocalization_eq_zero` kills the image of
`H²(Gal(L/K), Lˣ)`, that sum descends along `ideleToClassH2` to the *image* of the idele layer, with
`globalInv_ideleToClassH2` recording the descent equation.

⚠ That image is not the whole of `H²(Gal(L/K), C_L)`. From `1 → Lˣ → I_L → C_L → 1` the
obstruction to lifting a class lies in `H³(Gal(L/K), Lˣ)`: the connecting map is
`classToMultiplicativeH3`, into the third cohomology of `unitsFormation K`, and
`range_ideleToClassH2` is the exactness statement. The maps `ideleToClassH2` and
`classToMultiplicativeH3` are Tau Ceti's arithmetic quotient and connecting maps, and
`range_ideleToClassH2` and `surjective_ideleToClassH2_of_isCyclic` are Tau Ceti's proofs in
`TauCeti/NumberTheory/ClassFieldTheory/Global/LiftingObstruction.lean`.
`H¹`-vanishing does not make the obstruction vanish. For `L = ℚ(√13, √17)` every decomposition
group has order at most two — the decomposition groups at unramified primes are cyclic, `13` splits
in `ℚ(√17)` and `17` splits in `ℚ(√13)`, and the field is totally real — so
`H²(Gal(L/ℚ), I_L) = ⨁_v Br(L_w/ℚ_v)` is killed by `2`, while `H²(Gal(L/ℚ), C_L)` is cyclic of
order `4`. In general the image has order `lcm_v [L_w : K_v]`. The lift exists for every class
exactly when `lcm_v [L_w : K_v] = [L:K]` (Milne, *Class Field Theory*, VIII §4, the calculation
preceding Lemma 4.1). Cyclicity is sufficient, `surjective_ideleToClassH2_of_isCyclic`, since then
`H³(Gal(L/K), Lˣ) ≃ H¹(Gal(L/K), Lˣ) = 0`.

**Checks.**

- For `ℚ(√13, √17)/ℚ` the local-degree lcm is `2 < 4`, so the lift is not surjective.
- For `ℚ(√2, √3)/ℚ`, the local degree at `2` is `4`: neither `2`, `3` nor `6` is a square in
  `ℚ_2`, so the local compositum is biquadratic. The lift is surjective although its Galois
  group is Klein four.
- For a cyclic extension the lcm is the global degree, including the trivial extension;
  this recovers the cyclic theorem without asserting its converse.

The invariant is therefore defined on every class by refinement, in three named steps:

- **the cyclotomic input**, `exists_refinement_ideleSumLocalInv_eq`: some refinement of every
  layer carries an idele-layer class of invariant `1/[L:K]`, obtained by adjoining a cyclic
  cyclotomic extension with a local degree divisible by `[L:K]` (Milne VII, Lemma 7.3);
- **killing the obstruction**, `exists_refinement_mem_range_ideleToClassH2`: after inflation to
  that refinement every class of `H²(Gal(L/K), C_L)` lifts to the idele layer. The restriction of
  the idele class of invariant `1/[L:K]` to the layer over `L` has invariant `0`, hence vanishes on
  idele classes by `sumLocalInv_brLocalization_eq_zero`, `exists_br_of_sum_eq_zero` and injectivity
  of `brLocalization`; inflation–restriction then places its image in the inflation of
  `H²(Gal(L/K), C_L)`, where it has order `[L:K]`, and the second inequality makes it a generator;
- **independence**, `ideleSumLocalInv_eq_of_ideleToClassH2_eq`: two lifts to two refinements have
  the same sum of local invariants, by passing to a common refinement
  (`LayerRefinement.exists_commonRefinement`), where they differ by the image of
  `H²(Gal(M/K), Mˣ)`.

`globalInv` is then pinned by the two equations `globalInv_ideleToClassH2` and `globalInv_infl`,
and `globalInv_unique` says that they determine it. `globalInv_injective` and `range_globalInv`
follow by the same argument (Milne VIII §4, Theorem 4.7): `H²(Gal(L/K), C_L)` is cyclic of order
`[L:K]`, generated by the class of invariant `1/[L:K]`.

Global reciprocity, global existence, Chebotarev, and the classification of norm subgroups are
forbidden inputs to this layer: each is downstream of the abstract Artin map, which is downstream
of the class formation, which is downstream of `globalInv`.

**Exit criterion.** The archimedean Artin maps exist with their character formula, `globalInv`
exists on every layer, is the sum of local invariants of a lift at a refinement by named theorems,
and no declaration of this layer mentions `globalArtinMap`.

### Examples

- For `ℚ(i)/ℚ` and the quaternion class `(−1, −1)`, the local invariants are `1/2` at `2` and at
  `∞` and `0` elsewhere, with sum `0`; without the real place the sum would be `1/2`.
- For `ℚ(√13, √17)/ℚ`, the idele-layer image in `H²(Gal(L/ℚ), C_L) ≅ ℤ/4` is the subgroup of
  order `2`.

### Dependencies

Layer 1; from Layer 5, `Br K`, `invMap` and the local unit computations
(`herbrandQuotient_unitFiltration_zero`, `herbrandQuotient_units_eq_finrank`,
`index_normGroup_of_isCyclic`); from Layer 6, `unitsFormation`;
`LocalFieldsRamification`; `GlobalNumberFields`; `ProfiniteCohomology`. That is all the layer needs
through injectivity of `brLocalization`: the carriers, the archimedean Brauer computation, the
Herbrand quotients, both fundamental inequalities and `H¹`-vanishing. None of it waits for Layer
5's Tate dual, local duality or Euler characteristic. The archimedean Artin maps add Layers 2, 4
and 7 (`realCyclotomicSymbol`, `absoluteGaloisGroupExtend`), and
`sumLocalInv_brLocalization_eq_zero` and everything after it add Layers 2, 4, 6 and 7. **Not** the
global class formation and **not** the global Artin map: Layer 11 builds both out of this layer's
output.

## Layer 11: the global class formation and global Artin reciprocity

`globalInv` is packaged into `globalClassFormation`, and `globalClassFormation_inv` records that
the invariant of the global class formation *is* the sum-of-local-invariants map of Layer 10, not a
second normalization. The local–global compatibility of fundamental classes
(`ideleSumLocalInv_fundamentalClass`) is then a comparison theorem stated after the structure
exists, and is not used in its construction. Tau Ceti implements the layer.

For a finite Galois extension `L/K`, the abstract Artin equivalence transports to

```text
C_K / N_{L/K}(C_L) ≃ Gal(L/K)^ab
```

(`globalArtinEquiv`). The resulting `globalArtinMap` satisfies:

- compatibility with every local Artin map, through the decomposition group at a place
  (`globalArtinMap_local`, with local factor `localArtinAt`, the completion instance of
  `artinMap`, read in `Gal(L/K)^ab` by `decompositionRestrict`, which `decompositionRestrict_mk`
  pins as restriction along a place of `L` above `v`);
- triviality on principal ideles (`globalArtinMap_principal`, the reciprocity law), which holds
  because the global class formation is built on idele classes, its invariant being the
  sum of local invariants of Layer 10 that `sumLocalInv_brLocalization_eq_zero` makes well defined;
- compatibility in towers;
- agreement, at every unramified finite prime, with `NumberFieldArithmetic.artinHomAway`
  (`globalArtinMap_ideal`), identified by its prime values and the supplier's uniqueness theorem;
- arithmetic Frobenius normalization (`globalArtinMap_isArithFrobAt`).

`[IsAbelianGalois K L]` is adapted to the explicit commutativity hypothesis of
`NumberFieldArithmetic.artinHomAway` through the single adapter
`algEquiv_commute_of_isAbelianGalois`. At the archimedean places it consumes Layer 10's
`infiniteArtinAt` and its laws; it does not build a second archimedean Artin map.

There is one ideal-theoretic Artin map in the portfolio. The class-field-theory map is compared to
it by a theorem, not duplicated.

**Exit criterion.** The global map `globalArtinMap` is the transported abstract Artin map and its
value on an unramified prime is the existing Frobenius class.

### Examples

- **Global quadratic fields.** For a quadratic field `L/ℚ` of discriminant `D` and a rational prime
  `ℓ ∤ D`, the Artin symbol of `(ℓ)` is trivial exactly when `ℓ` splits, i.e. `(D/ℓ) = 1`. The
  special case `ℚ(i) = ℚ(ζ₄)` is mandatory: `ℓ ≡ 1 mod 4` gives `Art((ℓ)) = 1` and `ℓ ≡ 3 mod 4`
  gives complex conjugation, i.e. `Art((ℓ))(i) = i^ℓ`; `5 = N(2 + i)` splits and `3` is inert. For
  `ℚ(√5)`, `ℓ ≡ ±1 mod 5` gives `1` and `ℓ ≡ ±2 mod 5` gives `τ`: `11` gives `1` and `7` gives `τ`.
  Compute `ℚˣ/N_{ℚ(i)/ℚ}ℚ(i)ˣ` locally and compare the sign at the real place; for `ℚ(√5)/ℚ`, check
  the norm index and the cyclic Hasse norm theorem.
- **Cyclotomic fields.** For `m ≥ 1` and a prime `ℓ ∤ m`, under the standard identification
  `Gal(ℚ(ζ_m)/ℚ) ≃ (ℤ/mℤ)ˣ`, `Art((ℓ))(ζ_m) = ζ_m^ℓ`; equivalently `Art((ℓ))` corresponds to
  `ℓ mod m`. This is a direct test that the roadmap uses arithmetic rather than geometric
  Frobenius: a quadratic example alone cannot distinguish an automorphism from its inverse. The
  proof factors through `globalArtinMap_ideal`, `NumberFieldArithmetic.artinHomAway_apply_prime`
  and `IsArithFrobAt`, and the action of arithmetic Frobenius on roots of unity; there is no second
  cyclotomic Artin map. For `ℚ(ζ₅)/ℚ`, `Art((2))(ζ₅) = ζ₅²` of order four, `Art((3))(ζ₅) = ζ₅³` and
  `Art((11))(ζ₅) = ζ₅`; for `ℚ(ζ₈)/ℚ`, `Art((3))`, `Art((5))` and `Art((7))` send `ζ₈` to `ζ₈³`,
  `ζ₈⁵` and `ζ₈⁷`. `ℚ(i) = ℚ(ζ₄)`, `ℚ(√2) ⊂ ℚ(ζ₈)` and `ℚ(√5) ⊂ ℚ(ζ₅)` have conductors `4`, `8`
  and `5`.
- **Towers.** For the quadratic subfield `ℚ(√5)` of `ℚ(ζ₅)`, the restriction of the cyclotomic
  Artin symbol of `(ℓ)` is trivial exactly when `ℓ` is a square modulo `5` (`11` gives `1`, `7`
  does not); this tests the tower restriction square and the arithmetic formulae simultaneously.
  For `K ≤ E ≤ L`, compare the three finite Artin maps and the norm/transfer squares
  `artinMap_groundInclusion` and `artinMap_groundNorm`, both when the Galois group is cyclic of
  order four (`ℚ ≤ ℚ(√5) ≤ ℚ(ζ₅)`) and when it is the Klein four group (`ℚ(√5,√13)/ℚ`, restricted
  to all three quadratic subfields). In the cyclic case, with `g` a generator and `H = ⟨g²⟩`,
  inclusion `H → G` sends `g²` to `g²` while the transfer `G → H` sends `g` to `g²` and is onto
  `H`: the two are different maps, and the statement must use the actual transfer. In the Klein
  four case the transfer to a subgroup of order two is `x ↦ x² = 1`, trivial, while the quotient
  map is not, so the transfer cannot be replaced by the quotient map.

### Dependencies

Layers 1–4, 6, 7 and 10; `NumberFieldArithmetic`.

## Layer 12: separate arithmetic global existence, the norm index, and the global correspondence

Every target of this layer is for a **number field**; global class field theory for function
fields is outside this roadmap. Tau Ceti implements the layer
(`TauCeti/NumberTheory/ClassFieldTheory/GlobalExistence/`).

After global reciprocity is established, develop the topology of idele-class norm subgroups —
they are open, of finite index, distinct for distinct finite abelian extensions, and monotone in
the layer subgroup, hence inclusion-reversing on fields — and prove:

- `isOpen_globalNormSubgroup`, `finiteIndex_globalNormSubgroup`, `globalNormSubgroup_mono`, the
  concrete norm limitation `globalNormSubgroup_maximalAbelianLayer`, and the direction test
  `globalNormSubgroup_top`;
- every open finite-index subgroup of `C_K`, an element of `GlobalNormSubgroups K`, is the norm
  subgroup of a finite **abelian** layer of the global formation (`globalAbelianExistence`), with
  `globalExistence` retained only as the corollary that forgets abelianity;
- **uniqueness**, `globalClassField_unique`, and hence the class field `globalClassField K N` with
  its characterizing equation `globalClassField_normSubgroup`;
- **the global class-field correspondence** `globalClassFieldCorrespondence`, together with both
  order statements, `globalClassField_le_iff` on subgroups and `globalClassField_orderReversing`
  on fields;
- **the quotient isomorphism and the degree**: `globalAbelianGaloisEquiv` is an isomorphism
  `C_K / N_{L/K}(C_L) ≃ Gal(L/K)` onto the Galois group itself, characterized as the abstract
  Artin map by `globalAbelianGaloisEquiv_artinMap`; `index_globalNormSubgroup` and
  `globalClassField_index` give `[C_K : N] = [L:K]`, and `galClassFieldEquiv` transports the
  layer's Galois group to `Gal(classField V / K)`;
- the norm-index theorem `[C_K : N C_L] = [L:K]` for finite abelian `L/K` in the concrete
  extension carrier (`card_ideleClassNormQuotient`);
- **admissible moduli and ray-class reciprocity.** `IsAdmissibleModulus K L 𝔪` says that the ray
  subgroup of `𝔪` lies in the idele-class norm subgroup of `L/K`; for abelian Galois `L/K` this
  says the conductor divides `𝔪`; `abelianConductor` is the smallest admissible modulus and
  `isAdmissibleModulus_iff_abelianConductor_dvd` its characterization. The ray-class factorization
  of the global Artin map, `rayClassArtinMap`, takes the admissibility proof as an argument, and its
  splitting law (`rayClassArtinMap_idealClass`) and surjectivity (`rayClassArtinMap_surjective`) are
  stated for admissible moduli. ⚠ For `ℚ(i)/ℚ` and the trivial modulus the ray class group is
  trivial while the unramified prime `3` has nontrivial Artin symbol, so no such map exists
  (`not_isAdmissibleModulus_one_Qi`); requiring only that the ramified primes divide `𝔪` is not
  enough either, since `(4)` without the real place has trivial ray class group and the conductor is
  `(4)·∞`;
- **composita and intersections**: `globalNormSubgroup_inf_of_isAbelian` and
  `globalNormSubgroup_sup`, the lattice statements carried by the order isomorphism. ⚠ The meet
  formula needs abelian layers: two `D₄`-extensions with a common biquadratic subfield have a
  compositum whose maximal abelian subextension, of degree `8`, is larger than the compositum of
  their maximal abelian subextensions, of degree `4`, and norm limitation then gives the two sides
  different indices.

As in the local case there is no abstract existence theorem: this layer verifies its own
idele-theoretic inputs, and existence never appears as a hypothesis in a structure used to prove
reciprocity. Nor is `globalAbelianExistence` a single summit-sized target: it is proved by
induction on the index from three named inputs, along Milne VII §9, which is Artin–Tate's route:

- **upward closure**, `exists_abelianLayer_globalNormSubgroup_eq_of_le` (Milne VII, Lemma 9.1): a
  subgroup containing a norm subgroup is the norm subgroup of an abelian layer, by reciprocity;
- **descent along a finite extension**,
  `exists_abelianLayer_globalNormSubgroup_eq_of_comap_ideleClassNorm` (Lemma 9.4): if the preimage
  of `N` under the idele-class norm of `L/K` is a norm subgroup over `L`, then `N` is a norm
  subgroup over `K`, by composing norms and using norm limitation; applied to `K(ζ_p)/K` this is
  the roots-of-unity adjunction;
- **the Kummer case**, `exists_abelianLayer_globalNormSubgroup_eq_of_pow_mem` (Lemma 9.3): for
  `K ∋ ζ_p` every open subgroup containing the `p`-th powers is a norm subgroup. Its inputs are,
  for a finite set `S` of primes containing those above `p` and generating the class group, the
  Kummer layer `kummerLayer p` of the `S`-units, cutting out `K(U(S)^{1/p})`, abelian of degree
  `p^{|S|+r}`; the index of the idele subgroup `E_S`, computed from the local indices `p²/‖p‖_v`
  and the product formula; and the equality `globalNormSubgroup_kummerLayer_sUnits` of two
  subgroups of the same index. The quotient
  equivalence `globalAbelianGaloisEquiv` and `index_globalNormSubgroup` are consequences of
  Layer 11 for an already given abelian layer and precede this Kummer construction.

The induction (Theorem 9.5) chooses a prime `p` dividing the index, adjoins `ζ_p` by descent,
realizes a subgroup of index `p` containing `N` by the Kummer case as a cyclic layer of degree `p`,
and passes to that layer's field, where the index of the preimage has dropped. The Grunwald–Wang
theorem is not used and is outside this roadmap.

**Exit criterion.** `globalClassFieldCorrespondence` is a theorem — an order isomorphism between
the open finite-index subgroups of `C_K` and the abelian layers of `G_K`, order-reversing when
read on fields — together with `globalAbelianGaloisEquiv` and `globalClassField_index`.

### Examples

- For abelian `ℚ(i)/ℚ`, an admissible modulus contains `(2)` and the real place; `(4)·∞`
  is its conductor (Milne V §3, Example 3.11, p. 159).
- For the splitting field `ℚ(∛2, ζ_3)/ℚ`, norm limitation identifies its idele-class norm
  subgroup with that of its maximal abelian subfield `ℚ(ζ_3)`. Thus `(3)·∞` is norm-admissible
  although `2` ramifies in the splitting field. The ramified-support theorem
  `IsAdmissibleModulus.mem_support_of_ramified` requires abelian Galois `L/K`.
- At Kummer exponent `1`, the generated field is `K`. At exponent `2`, finitely many generators
  of the `S`-units give a finite extension. Exponent `0` is excluded from `kummerLayer`, whose
  exponent carries `NeZero`: already `a = 1` would admit every element of `Kˢ` as a root. The nonzero-exponent construction uses Kummer theory
  after adjoining `μ_p` (Milne VII, Appendix A, Theorem A.3).
- For `ℚ(i)/ℚ` the norm index is `[C_ℚ : N C_{ℚ(i)}] = 2`, and for `L = K` it is `1`.

### Dependencies

Layers 4, 10 and 11; `GlobalNumberFields` (moduli and ray classes).

## Layer 13: norm theorems and class fields

Layer 10's S-idele and S-unit Herbrand calculations, fixed-point and arithmetic norm comparisons,
and `herbrandQuotient_ideleClassRep_eq_finrank` prove the cyclic Hasse norm theorem `cyclicHasseNorm`: for
cyclic `L/K`, `x : Kˣ` is a global norm exactly when its principal idele is an idele norm. The
placewise predicates `IsFiniteLocalNorm` and `IsInfiniteLocalNorm` are genuine, on the canonical
local étale algebras `K_v ⊗_K L` and `K_w ⊗_K L`, where finite places use `v.adicCompletion K` and
infinite places use Mathlib's `w.Completion`. Complex infinite places remain quantified and have a
named theorem saying that their norm condition is automatic. `IsLocalNormEverywhere` is the
conjunction of the finite and infinite families; it is not an alias for an idelic range predicate.
The bridge `unitEmbedding_mem_range_ideleNormMap_iff` is proved by projecting an idelic norm to
all local norm equations and, conversely, choosing a preimage in every local étale algebra, in the
local unit subgroup outside a finite set (norm-surjectivity on units for unramified extensions),
and assembling those choices in the restricted product, real and complex factors explicitly. The
consumer-facing composite is `isGlobalNorm_iff_isLocalNormEverywhere`. The global half is the
vanishing of `Ĥ^{-1}(Γ, C_L)`, a consequence of the Layer 10 computation of the Herbrand quotient
of the idele classes; the cyclic hypothesis is essential. All of this is Tau Ceti's
(Global/HasseNorm/), and this roadmap exports `cyclicHasseNorm`,
`isGlobalNorm_iff_isLocalNormEverywhere`, the carriers `principalIdele` (Mathlib's
`NumberField.IdeleGroup.unitEmbedding`), `ideleNormMap` and `ideleClassNorm`, and the predicates
under its own names.

Every named class field of this layer is an **application** of the Layer 12 correspondence, never a
substitute for it: each one names its own norm subgroup and is then `classField` of
`globalClassField` at that subgroup. The ray subgroup of a modulus is open (`isOpen_raySubgroup`)
and of finite index (`finiteIndex_raySubgroup`), packaged as `rayNormSubgroup`, and
`rayClassField 𝔪` is its class field; `hilbertClassField` is `rayClassField` at
`GlobalNumberFields.Modulus.one` and `narrowHilbertClassField` is `rayClassField` at
`GlobalNumberFields.narrowModulus`. The ray class field of `𝔪` is the largest abelian extension of
conductor dividing `𝔪`: `isAdmissibleModulus_iff_le_rayClassField` says that `L` embeds in it
exactly when `𝔪` is admissible for `L/K`. The Galois/class-group isomorphisms
(`gal_rayClassField_equiv_rayClassGroup`, `gal_hilbertClassField_equiv_classGroup`) are the
composite of `galClassFieldEquiv`, `globalClassFieldGaloisEquiv` and
`GlobalNumberFields.ker_rayClassQuotient`, not independent computations; the maximal unramified
properties and the splitting criteria are Tau Ceti's (ClassFields/RayClassField.lean).

**The principal ideal theorem** (`isPrincipal_map_hilbertClassField`): for a number field `K` with
Hilbert class field `H = hilbertClassField K`, every ideal `𝔞` of `𝒪_K` becomes principal in `𝒪_H`,
that is, `𝔞𝒪_H` is principal. Through reciprocity for the layer `H′/K`, `H′` the Hilbert class
field of `H`, the extension of ideals `Cl(K) → Cl(H)` is the transfer from `Gal(H′/K)` to its
commutator subgroup `Gal(H′/H)`, which is trivial; the abstract form is Tau Ceti's
`ClassFormation.groundInclusion_mem_normSubgroup_of_range_eq_commutator`, and the arithmetic
form adds the identification of the ground-level inclusion of idele classes with extension of
ideals through `gal_hilbertClassField_equiv_classGroup` at `K` and at `H`. (Furtwängler; Artin–Tate,
*Class Field Theory*, XIII §4.)

Kronecker–Weber is `kroneckerWeber`, from global existence; the least cyclotomic level of an
abelian extension of `ℚ` equals the finite part of `abelianConductor`, with the `n ≢ 2 mod 4`
normalization; and conductors are compatible with ramification
(`IsAdmissibleModulus.mem_support_of_ramified`).

**The conductor–discriminant formula** (`relDiscr_eq_finprod_abelianConductor`): for a finite
abelian extension `L/K` of number fields, the relative discriminant `relDiscr (𝓞 K) (𝓞 L)` is the
product, over the characters `χ` of `Gal(L/K)`, of the finite parts of `abelianConductor` of the
fixed fields of `ker χ`, the cyclic extensions the characters cut out. At a prime `𝔭` of `K`, with
`g` primes above it and decomposition group `D`, the exponent of `𝔭` in `relDiscr` is `g` times the
local discriminant exponent of `L_𝔓/K_𝔭`, every character of `D` extends in `g` ways, and the
exponent of `𝔭` in the conductor of the fixed field of `ker χ` is the local conductor exponent of
`χ` restricted to `D`; Tau Ceti's local formula
`LocalFieldsRamification.finsum_artinConductorExponent_eq_discriminantExponent`, the sum of the
Artin conductor exponents of the characters of `D` being the local discriminant exponent, then
gives the formula. (Neukirch, *Algebraic Number Theory*, VII §11; Serre, *Local Fields*, VI §3.)

For an order `O` of a number field `K`, the arithmetic input is Tau Ceti's idelic ring-class
quotient `ringClassIdeleQuotient O : C_K → Pic O` (ClassFields/RingClass/Quotient.lean), on Tau
Ceti's `NumberFieldOrder` and `Pic`: the composite of the idelic ray-class quotient at the conductor
of `O` with the arithmetic ray-to-Picard map, which sends an ideal prime to the conductor to the
Picard class of its contraction to `O` and is surjective. Its kernel is open of finite index
(`isOpen_ker_ringClassIdeleQuotient`, `finiteIndex_ker_ringClassIdeleQuotient`); as an element of
the source of the correspondence it is `ringClassNormSubgroup`, and `ringClassField` is the class
field of that subgroup, for every order of every number field. So the ring class field, like the
Hilbert and ray class fields, is an application of the Layer 12 correspondence, and
`gal_ringClassField_equiv_pic` follows from it rather than being assumed. Raw proper ideals,
including noninvertible ideals in `IdealClassMonoid O`, never enter this construction. The
canonical equivalence `Pic O ≃ Gal(H_O/K)` is Tau Ceti's `ringClassArtinEquiv`, the inverse of the
quotient-kernel equivalence followed by global reciprocity, and `gal_ringClassField_equiv_pic` is
its inverse; the ideal-form Artin map `I ↦ ringClassArtinEquiv (O.mkPic I)` on invertible ideals is
Tau Ceti's `ringClassArtinMap`, exported under that name, with its principal-kernel criterion
`ringClassArtinMap_eq_one_iff`. The conductor bound on the ramification of `H_O/K` and the
splitting criterion are Tau Ceti's (`isAdmissibleModulus_ringClassField`,
`ncard_primesOver_ringClassField_eq_finrank_iff`). At Tau Ceti's maximal order
`maximalNumberFieldOrder K` the kernel of `ringClassIdeleQuotient` is the ray subgroup of the
trivial modulus (`ker_ringClassIdeleQuotient_maximalNumberFieldOrder`), so the two norm subgroups
agree and `H_O = hilbertClassField K` (the first Check below). Orders and Picard
groups remain owned by `GlobalNumberFields`.

The description of `Pic O` as the ray-class quotient `I_K(𝔣)/P_{K,ℤ}(𝔣)` uses `O = ℤ + 𝔣𝒪_K`,
which holds for every order of a quadratic field and fails in higher degree: in a cubic field
`ℤ + f𝒪_K` has index `f²`, so an order of index `f` is not of that form. That description is the
quadratic specialization of the construction, not a hypothesis of it: the kernel of
`ringClassIdeleQuotient` is cut out by the order itself, not by its conductor alone.

*Source:* Kopp–Lagarias, [*Ray class groups and ray class fields for orders of number
fields*](https://arxiv.org/abs/2212.09177), Theorems 1.1–1.3, at modulus `(O, ∅)`, for every order
of every number field: the ring class field, its conductor bound, its splitting criterion and the
canonical Artin isomorphism. Cox, *Primes of the Form x² + ny²*, §7, Proposition 7.22, supplies the
congruence description for imaginary quadratic orders.

**Checks.**

- At the maximal order, the conductor is the unit ideal and the ring class field equals the
  Hilbert class field: both are the class field of the ray subgroup of the trivial modulus, which
  at the maximal order is the kernel of the ring-class quotient.
- For the maximal order of `ℚ(√3)`, the ordinary class group is trivial and the narrow class
  group has order `2`, the fundamental unit `2 + √3` having norm `1`; the ring class field is `K`,
  and its trivial infinite modulus does not produce the narrow Hilbert class field.
- In degree three, `K = ℚ(ζ_7 + ζ_7⁻¹)` has discriminant `49` and Minkowski bound `14/9 < 2`, so at
  the maximal order `Pic O` and `Gal(H_O/K)` are trivial and `H_O = K`.
- For an ideal prime to the conductor, its contracted ideal's Picard class is the image of its
  ray class; the ideal Artin map sends that class through the canonical reciprocity equivalence.
- Postcomposing with a nontrivial automorphism of the Galois group preserves the kernel and
  surjectivity but changes the Picard-to-Galois formula, so it is excluded by the definition.

**Exit criterion.** `cyclicHasseNorm`, `rayClassField`, `hilbertClassField`,
`narrowHilbertClassField`, `ringClassField` for every order, and `kroneckerWeber` are all
stated against the imported carriers, every class field among them is a value of `classField`
at a value of `globalClassField`, and `isPrincipal_map_hilbertClassField` and
`relDiscr_eq_finprod_abelianConductor` are proved.

### Examples

- `25` is the standard failure of the Hasse norm principle in `ℚ(√13,√17)/ℚ`: it is a local norm
  everywhere but not a global norm, `(17/13) = (13/17) = 1`, `2` being inert in `ℚ(√13)` and split
  in `ℚ(√17)`, every decomposition group cyclic and the Galois group the Klein four group.
- The principal ideal theorem at `K = ℚ(√−5)`: the class group has order `2`, the Hilbert class
  field is `H = K(i)`, and for `I = (2, 1 + √−5)` one has `I² = (2)` and `2 = −i(1 + i)²` in `H`,
  so `I𝒪_H = (1 + i)`. At `K = ℚ` the Hilbert class field is `ℚ` and the statement is the
  principality of ideals of `ℤ`.
- For a nonmaximal imaginary-quadratic order, `Gal(H_O/K)` is `Pic O`; the order and its ideals
  are `GlobalNumberFields`' and are not reconstructed locally.
- For `ℚ(i)/ℚ`, the discriminant is `(4)` and the two characters have conductors `1` and `4`; for
  `ℚ(ζ₅)/ℚ` the discriminant is `5³` and the four characters have conductors `1, 5, 5, 5`.

### Dependencies

Layers 10, 11 and 12; `GlobalNumberFields` (orders and `Pic`); Tau Ceti's `relDiscr` and the local
conductor–discriminant formula.

## Layer 14: Hilbert reciprocity and quadratic reciprocity

The Hilbert invariants are Tau Ceti's (Global/Hilbert/), exported under this roadmap's names:

- `finiteHilbertInvariantAt` applies the local Hilbert symbol of Layer 5 at the completion `K_v`,
  with `ζ = −1`, to the images of `a, b ∈ Kˣ` in `K_vˣ`; at exponent two the arithmetic coordinate
  `h2MuEquivZMod` is the unique additive equivalence `H²(K_v, μ_2) ≃ ℤ/2`;
- `infiniteHilbertInvariantAt` is the invariant at a real place of the localized Kummer-cup
  Brauer class, and `0` at a complex place; it is `1` exactly when the place is real and both
  arguments are negative there, so at every real place `(−1, −1)` has invariant `1`. This agrees
  with Layer 10's archimedean invariant;
- `finiteHilbertSupport a b` is the support of the finite invariants: the finite set of finite
  places at which `finiteHilbertInvariantAt` is nonzero, so every finite invariant outside it
  vanishes (Tau Ceti's `finiteHilbertInvariantAt_eq_zero_of_notMem`). It is contained in the set of
  places at which `2`, `a` or `b` is not a unit, by `localSymbol_eq_zero_iff_mem_normGroup` and the
  norm surjectivity on units of unramified extensions.

Then freeze

```text
ClassFieldTheory.hilbertProductFormula
```

in additive cohomological form: the sum of the local `ZMod 2` invariants is zero. It is the
Layer 10 sum-of-invariants theorem `sumLocalInv_brLocalization_eq_zero` applied to the Brauer class
of the quaternion symbol, not an independent computation. The equivalent multiplicative statement
is `∏_v (a,b)_v = 1`. `QuadraticFormInvariants` proves that its norm-equation/quaternion symbol
agrees with this one and inherits the product formula.

*Source:* Milne, *Class Field Theory*, III §4, Steps 3–4 and Theorem 4.4 (Kummer cup and
invariant), V §5, Example 5.4, p. 179 (Hilbert reciprocity); Serre, *A Course in Arithmetic*, III
§§1–2 (real and dyadic symbols).
*Needs:* Layer 5's Kummer classes, named cup pairing and local invariant coordinate; Layer 10's
archimedean invariants and sum formula.

**Checks.**

- For `K = ℚ` and `a = b = −1`, the real invariant is `1`, as is the invariant at `2`;
  all odd-prime invariants vanish, so the sum is `0` in `ℤ/2`.
- For `K = ℚ` and `a = b = 5`, every invariant vanishes: at `2`, `(5,5)_2 = 1` because `5 ≡ 1
  mod 4` and `ε(5) = 2` is even; at `5`, `(5,5)_5 = (5,−1)_5 = (−1/5) = 1`; and `5 > 0`. The
  support is empty, although `5` is not a unit at `5`.
- A complex place contributes `0` for every pair, while a real place contributes `0` when at
  least one argument is positive.
- If either argument is a square in `Kˣ`, its finite Kummer class vanishes and every finite
  invariant is `0`; squares are positive at real places, so every infinite invariant also vanishes.

Quadratic reciprocity itself is Mathlib's; explicit power-reciprocity laws beyond it are outside
this roadmap.

**Exit criterion.** `hilbertProductFormula` is proved from `sumLocalInv_brLocalization_eq_zero`.

### Examples

- For distinct odd primes `p, q` and `K = ℚ`, `a = p`, `b = q`, the invariants vanish away from
  `2`, `p`, `q` and the real place, and `hilbertProductFormula` reduces to Mathlib's
  `legendreSym.quadratic_reciprocity`, real and dyadic factors included: at `p = 3`, `q = 7`,
  `(7/3) = 1`, `(3/7) = −1` and the product is `(−1)^((3−1)(7−1)/4) = −1`.
- For `K = ℚ`, `(3, 7)` has nonzero invariants exactly at `2` and `7`, and `1 + 1 = 0`.
- The Hilbert and narrow Hilbert class fields of small quadratic fields, with the principal ideal
  theorem of Layer 13, are the companion examples on the class-field side.

### Dependencies

Layers 5, 10, 11 and 13.

## Downstream consumers

- `LocalGaloisGroups` consumes the local-cohomological row of this roadmap without constructing
  private stand-ins: the coefficient objects and Kummer theory, `GalRep`, `H`, `muNRep` and
  `kummerEquiv_mixed`; degree two and local duality, `finite_H`, `h2MuEquivZMod_mixed`,
  `h2FpEquivZMod_of_mu`, `tateDual`, `tateDualityPairing`, `tateDualityPairing_perfect_mixed` and
  `eulerCharacteristic_finrank_fp`; the chosen-root comparison of the cup square with duality,
  `muNRepEquivZMod`, `muNRep_ρ_eq_self`, `kummerCupPairing`, `kummerCupPairing_bil`, `localSymbol`,
  `muNRepToTateDual`, `bijective_muNRepToTateDual` and `tateDualityPairing_muNRepToTateDual`;
  reciprocity and the orientation, `artinMap`, `restrictAbsolute`, `artinMap_restrict`,
  `absoluteGaloisGroupExtend`, `artinMap_norm`, `denseRange_artinMap`, `localArtinMap`,
  `normResidue`, `unramifiedCoordinate`, `unramifiedCoordinate_artinMap`,
  `cyclotomicCharacter_artinMap`, `cyclotomicCharacter_artinMap_padic` and
  `cyclotomicCharacter_artinMap_padic_uniformizer`; the class formation and Tate's theorem,
  `ClassFormation` (Tau Ceti's, re-exported), Tau Ceti's `ClassFormation.fundamentalClass` and
  `ClassFormation.fundamentalClass_generates`, and this roadmap's `tateTheorem` and
  `artinMap_conj`; the Nakayama–Rim theorem `projective_ker_of_isZero_res` and
  `primaryComponent_tateCohomology_eq_bot`; and `scd_p_absoluteGaloisGroup_eq_two`. The
  smoothness hypotheses of `finite_H`, `tateDualityPairing_perfect_mixed` and
  `eulerCharacteristic_finrank_fp` are instance arguments, found at `μ_p`, at its Tate dual and at
  the trivial module `𝔽_p`, the modules this consumer uses. The cyclotomic normalization is Tau
  Ceti's at the pin and is proved from the explicit local symbols of the cyclotomic fields over
  `ℚ` (Layer 7), so this consumer does not depend on the global layers.
- `GlobalQuadraticForms` owns Hasse–Minkowski and the global classification of quadratic
  forms, and consumes `hilbertProductFormula`, `cyclicHasseNorm`,
  `isGlobalNorm_iff_isLocalNormEverywhere` and `card_ideleClassNormQuotient`.
- `QuadraticFormInvariants` owns the norm-equation and quaternion presentations of local
  Hilbert symbols and proves that they agree with the cohomological `localSymbol` exported here.
- `IntegralLattices` consumes `ringClassField`, `ringClassArtinMap`,
  `gal_ringClassField_equiv_pic` and the Hilbert invariants.
- `FunctionFieldArithmetic` consumes Layer 7's unit-filtration reciprocity in equal
  characteristic, `map_unitFiltration_normResidue` and its absolute form
  `closure_map_artinMap_unitFiltration`, and extends Layer 8's local existence, injectivity of
  `artinMap` and the local correspondence to every nonarchimedean local field.
- `PadicPeriodRings` consumes Layer 7's unit-filtration reciprocity,
  `map_unitFiltration_normResidue` with its absolute form, and the conductor consequence
  `conductorExponent_eq_sInf_upperRamificationGroup`.
- `RamificationOfCompleteDiscretelyValuedFields` §4a.1 consumes Layer 7's absolute upper
  ramification groups `localAbsoluteUpperRamificationGroup` of a nonarchimedean local field: it
  proves that its filtration relative to a valuation subring, over every complete discretely
  valued field with perfect residue field, agrees with them on such a field.
- `ArithmeticGaloisRepresentations` consumes Layer 7's absolute `artinMap` and character conductor
  `characterConductorExp`, and `FiniteFlatGroupsAndIntegralPadicHodgeTheory` consumes the
  cyclotomic normalization `cyclotomicCharacter_artinMap` of Layer 7.

## References

- E. Artin and J. Tate, *Class Field Theory*, AMS Chelsea, 2009: Chapter XIV, §§1–5 (formations,
  field formations and Brauer groups, class formations, the Main Theorem, the reciprocity-law
  isomorphism) and §6, p. 163 (the abstract existence theorem under the additional axioms
  IIIa–IIId); Chapters V–VIII for the fundamental inequalities, the global reciprocity law and the
  existence theorem; Chapter XI §5 for conductors; Chapter XII for explicit reciprocity laws;
  Chapter XIII §4 for the principal ideal theorem; Chapter XV for Weil groups.
- J. Tate, *Global class field theory*, in Cassels–Fröhlich, *Algebraic Number Theory*: global
  class formations and cohomological class field theory.
- J.-P. Serre, *Local Fields*, Graduate Texts in Mathematics 67, Springer, 1979, Chapters XI–XV:
  local class formations, the character formula for the reciprocity map, the local invariant,
  normalization conventions, and (XV §2) unit-filtration reciprocity; V §§3, 6 for filtered norms;
  VI §3 for the conductor–discriminant formula; IX §§3–5 for cohomological triviality; *Galois
  Cohomology* for local duality and Euler characteristics.
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed.: finite and
  profinite cohomology, local duality, and global formations; (3.3.4) and (3.3.6) for strict and
  ordinary cohomological dimension, (7.1.8) and (7.2.5) for `cd` and `scd` of a local field,
  (7.2.6) for local duality, and (7.3.1)–(7.3.4) for the Euler characteristic.
- J. S. Milne, *Arithmetic Duality Theorems*, 2nd ed., I §2 (Theorem 2.8, the Euler
  characteristic, and Lemmas 2.10 and 2.12).
- J.-P. Serre, *Local class field theory*, in Cassels–Fröhlich, *Algebraic Number Theory*: the
  cohomologically trivial open subgroup of local units in every characteristic.
- J. Neukirch, *Algebraic Number Theory*, Ch. VI–VII: local and global class field theory; VII §11,
  the Artin conductor and the conductor–discriminant formula.
- J. S. Milne, *Class Field Theory* (course notes, v4.03): II 3.11 (Tate's theorem); III,
  Lemmas 2.3–2.6 (cohomologically trivial open subgroups of local units, `h(U_L) = 1`, and the
  order of `H²(L/K)`); VII §§4–5 (the fundamental inequalities, Theorem 5.1), Proposition 7.2 and
  Lemma 7.3 (splitting by cyclic cyclotomic extensions), Example 8.2 and Theorem 8.1 (the
  reciprocity law), Lemmas 9.1–9.4 and Theorem 9.5 (the existence theorem through Kummer theory and
  descent); VIII §4, Theorems 4.2 and 4.7 (the Brauer sequence, and `H²` of the idele classes cyclic
  of order `[L:K]`); the Hasse norm theorem and examples.
- G. S. Kopp and J. C. Lagarias, [*Ray class groups and ray class fields for orders of number
  fields*](https://arxiv.org/abs/2212.09177), Theorems 1.1–1.3: at modulus `(O, ∅)`, the ring
  class field, conductor bound, splitting criterion and canonical Artin isomorphism for orders
  in number fields; Layer 13 uses them for every order.
- D. A. Cox, *Primes of the Form x² + ny²*, §7, Proposition 7.22: the ray-class quotient for
  imaginary quadratic orders. Theorem 9.18, p. 191, concerns the generalized-dihedral
  characterization of extensions contained in imaginary quadratic ring class fields.
- A. Weil, *Sur la théorie du corps de classes*, J. Math. Soc. Japan 3 (1951); J. Tate,
  *Number theoretic background*, in *Automorphic Forms, Representations and L-functions* (Corvallis),
  Part 2, §1: the local Weil group, its topology, its functoriality and `Kˣ ≃ W_K^ab`.
- J. Tate, *The higher dimensional cohomology groups of class field theory*, Ann. of Math. 56
  (1952); T. Nakayama, *Cohomology of class field theory and tensor product modules I*, Ann. of
  Math. 65 (1957): Tate's theorem and the Tate–Nakayama theorem.
- D. S. Rim, *Modules over finite groups*, Ann. of Math. 69 (1959); K. S. Brown, *Cohomology of
  Groups*, VI §8; S. Lang, *Algebra*, III Theorem 7.1: cohomological triviality and projective
  dimension, and submodules of free modules over a principal ideal domain.
- A. J. Engler and A. Prestel, *Valued Fields*, Springer, 2005, §4.4: F. K. Schmidt's theorem that
  a field henselian for two independent nontrivial valuations is separably closed.
- `leanprover-community/mathlib4`, `Mathlib/RepresentationTheory/Homological/TateCohomology`,
  `Mathlib/RepresentationTheory/Homological/ContCohomology` and
  `Mathlib/FieldTheory/Galois/NormalBasis.lean`.

### Source: Serre, *Local Fields*

J.-P. Serre, *Local Fields*, Graduate Texts in Mathematics 67, Springer, 1979, located by chapter,
section and statement number.
