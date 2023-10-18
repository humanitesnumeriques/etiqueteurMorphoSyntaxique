(:3 On crée le fichier des occurrences de mots composés:)
(:contenues dans le texte lui-même:)
(:10 seconde au lieu de 261639 ms:)
(:On produit trop de candidats mais ce n'est pas grave:)
(:puisqu'on va les trier dans l'étape d'après:)
(:Ressources LDI ex UMR 7187:)


file:write
('/Users/xavier-laurentsalvador/basex/listeOccurrenceMCcandidats.txt'
,
let $index:= index:texts("terreLuneEtiquete")
let $corpus := db:get('terreLune2')//text()

for $y in db:get('motsComposes')/db/mc/@src
 
 where every $yy in ft:tokenize($y) satisfies $yy = $index
 
  return
   $y/data()
   ,
    map {"method" : "basex"}
    (:sinon, on a des retours à la ligne qui sautent:)
) 
  
  