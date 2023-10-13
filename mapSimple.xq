
map:merge(
 for $x in ft:tokenize(db:get("terrelune2")//text(), 
  map{"diacritics":"sensitive"})
   let $entry :=  db:get("Morphalou3.1_TEI")/TEI/text/body/entry[./form[@type="inflected"]/orth=$x] 
   let $pos := distinct-values($entry/form[@type="lemma"]/gramGrp/pos/text())
   return 
    map{
     $x : $pos
   }
)
