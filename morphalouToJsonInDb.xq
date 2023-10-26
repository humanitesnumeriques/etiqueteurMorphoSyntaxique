(:Progreamme réalisé par XLS:)
(:On va utiliser les fonctions db:put-value:)
(:pour stocker une version optimisée de la ressource en base de données:)
(:Attention, un ebase appelée morphalouJson doit exister sur la machine au préalable:)
(:Pour interroger la ressource c'est très simple:)
(:-----------------------------------------------:)
(:exemple: db:get-value('morphaloujson')?desc?mangeait:)


declare option output:method "json";
declare option output:indent "yes";

declare function local:cherche($f,$entry){
  map:merge(
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
    
db:put-value(
  "morphalouJson"
  ,
    map:merge(
     
    for $mot in $glossaire
     let $entry := db:get("Morphalou3.1_TEI")/TEI/text/body/entry[./form[@type="inflected"]/orth=$mot]
     for $x in (local:cherche($mot,$entry))
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
        }
      )
      ,
      'desc'
      
    )
(:db:get-value('morphaloujson')?*?mangeait?mode:)
    
