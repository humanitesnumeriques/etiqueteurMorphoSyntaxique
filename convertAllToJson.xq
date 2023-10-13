(:declare option output:method "json";:)
declare option output:indent "yes";

declare function local:cherche($f){
  map:merge(for $entry at $n in db:get("Morphalou3.1_TEI")/TEI/text/body/entry[./form[@type="inflected"]/orth=$f]
    let $pos := distinct-values($entry/form[@type="lemma"]/gramGrp/pos/text())
    let $lemme := distinct-values($entry/form[@type="lemma"]/orth)
    let $genre := distinct-values($entry/form[@type="lemma"]/gramGrp/gen)
    let $id := data($entry/@id)
    let $mood := $entry/form[@type="inflected" and ./orth=$f]/gramGrp/mood/text()
    let $number:= $entry/form[@type="inflected" and ./orth=$f]/gramGrp/number/text()
     return 
      map {$f : map{"pos" : $pos, "lemme" : $lemme, "genre" : $genre, "id" : $id, "mode" : $mood, "nombre" : $number}},map{"duplicates":"combine"})
    };
    
    
    
    let $glossaire := distinct-values(db:get("Morphalou3.1_TEI")/TEI/text/body/entry/form[@type="inflected"]/orth)
    
    return

    map:merge(
     
    for $mot in $glossaire,
     $x in (local:cherche($mot))
     return 
     
      map {
        $mot : 
        map{
          "pos": string-join(distinct-values($x?$mot?pos),' '),
          "lemme" : string-join(distinct-values($x?$mot?lemme),' '), 
          "genre" : string-join(distinct-values($x?$mot?genre),' '), 
          "id" : string-join(distinct-values($x?$mot?id),' '), 
          "mode" : string-join(distinct-values($x?$mot?mode),' '), 
          "nombre" : string-join(distinct-values($x?$mot?nombre),' ')
         }
        })
