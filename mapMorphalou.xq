(:Programme réalisé par Xavier-Laurent Salvador :)
(:pour le Master TILDE et ses étudiants:)
(: Transformation de Morphalou en Map :)

let $nomBaseCorpus := "terrelune2" (:Le nom de la base textuelle créée:)
let $baseMorphalou := "Morphalou3.1_TEI" (:Le nom de votre base mrophalou:)


declare variable $morphalou := 
let $glossaire := distinct-values(db:get($baseMorphalou)/TEI/text/body/entry/form[@type="lemma"]/orth/text())
return
map:merge(
for $formes in $glossaire, $entry at $n in db:get("Morphalou3.1_TEI")/TEI/text/body/entry[./form[@type="lemma"]/orth=$formes]
   let $pos := $entry/form[@type="lemma"]/gramGrp/pos/text()
   let $lemme := $entry/form[@type="lemma"]/orth
   let $genre := $entry/form[@type="lemma"]/gramGrp/gen
   let $id := data($entry/@id)
   
   return 
   for $y in $entry/form[@type="inflected"]/orth/text()
   return
   map{
     $y :
     map {
       "pos":$pos,
       "lemme":$lemme/text(),
       "id":$id,
       "mood":$y/../../gramGrp/mood/text(),
       "number":$y/../../gramGrp/number/text(),
       "genre":$genre/text()
     }
   },map { 'duplicates': 'combine' }
);

$morphalou
