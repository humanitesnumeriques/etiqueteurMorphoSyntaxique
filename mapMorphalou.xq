let $corpus := ft:tokenize(db:get-pre("terrelune2",0)//text())

let $m:= map:merge(
  for $x at $n in db:get("Morphalou3.1_TEI")/TEI/text/body/entry 
   return
    map{$x/form[@type="lemma"]/orth/text() : $x/form[@type="inflected"]/orth/text()}
)

let $n := map:merge(
  for $x at $n in db:get("Morphalou3.1_TEI")/TEI/text/body/entry 
   return
    map{$x/form[@type="lemma"]/orth/text() : $x/form[@type="lemma"]/gramGrp/pos/text()}
)

return
file:write(
  "res.xml"
  ,
for $i in ($corpus)
return
<l mot='{$i}' pos="{
distinct-values(for $x score $score in ((map:for-each($m,
    function($key,$values){<l lem="{$key}" i="{$values}" pos="{map:get($n,$key)}"/>}
))[@i contains text {$i}]/@pos)
 
  return $x)
}"/>
)