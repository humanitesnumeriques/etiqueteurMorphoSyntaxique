(:par X-L Salvador:)
(:Etiquetage à partir de la ressource JSON produite par le script convertAllToJson.xq:)
(:On descend en dessous de 2 secondes:)

let $doc := (json:doc("/Users/xavier-laurentsalvador/morphaloiu.json", map{"format":"xquery"}))
 for $x in ft:tokenize(db:get("terrelune2")//text(), map{"diacritics":"sensitive"})
  return
   <m mot="{$x}" pos="{$doc?$x?pos}"/>
