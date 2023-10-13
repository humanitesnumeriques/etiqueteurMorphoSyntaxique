json:serialize(
  <db>{
for $x in ft:tokenize(db:get("terrelune2")//text(), map{"diacritics":"sensitive"})
 let $entry :=  db:get("Morphalou3.1_TEI")/TEI/text/body/entry[./form[@type="inflected"]/orth=$x] 
   let $pos := distinct-values($entry/form[@type="lemma"]/gramGrp/pos/text())
   let $lemme := distinct-values($entry/form[@type="lemma"]/orth)[1]
   let $genre := distinct-values($entry/form[@type="lemma"]/gramGrp/gen)
   let $id := distinct-values(data($entry/@id))
   let $mood := distinct-values($entry/form[./orth=$x]/gramGrp/mood/text())
   let $nombre := (distinct-values($entry/form[@type="inflected" and ./orth=$x]/gramGrp/number/text()),  if ($pos contains text {"preposition"}) then "invariable" else ())
   
 return 
  <f mot="{$x}" pos="{$pos}" lemma="{$lemme}" id="{$id}" genre="{$genre}" mood="{$mood}" nb="{$nombre}"/>
}</db>
, map{"format":"jsonml"})