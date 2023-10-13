(:Programme réalisé par Xavier-Laurent Salvador :)
(:pour le Master TILDE et ses étudiants:)

let $baseCorpus := "terrelune2"
let $baseMorphalou := "Morphalou3.1_TEI"

map:merge(
 for $x in ft:tokenize(db:get($baseCorpus)//text(), 
  map{"diacritics":"sensitive"})
   let $entry :=  db:get($baseMorphalou)/TEI/text/body/entry[./form[@type="inflected"]/orth=$x] 
   let $pos := distinct-values($entry/form[@type="lemma"]/gramGrp/pos/text())
   return 
    map{
     $x : $pos
   }
)
