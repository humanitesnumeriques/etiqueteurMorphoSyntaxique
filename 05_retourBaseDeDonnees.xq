(:par XLS:)
(: 6_ Reconstruction du corpus dans la base de données:)
(:à partir de rsMcMap.xml:)
(:produit par mcIdenitifer.xq :)

declare variable $fichierMap := 'resMcMapTest.xml';
declare variable $corpus:=db:get('terreLuneEtiquete')/db;

let $phrases := (

for $idPhrases in  distinct-values(doc($fichierMap)//p[w]/@index)
  order by xs:integer($idPhrases) ascending
   
   return
   
   <phrase index="{$idPhrases}">{
let $map := 
map:merge(
 for $m in doc($fichierMap)//p[w][@index=$idPhrases]
 let $src := $m/@src/data()
 let $size := count(ft:tokenize($m/@src/data())) 
  for $w in $m/w
   return map {
      $src: map{
         "size":$size, 
         "index":(ft:tokenize($w) ! xs:integer(.),',')[1],
         "w":tokenize($w),
         "pos" : distinct-values(tokenize($m/@pos)[1])
       }}
 , map {"duplicates":"combine"})

return

for $m in $corpus/phrase[@index=$idPhrases]/mot 
let $indice := xs:integer($map?*?index=$m/@n)
let $size := xs:integer($map?*[?index=$m/@n]?size)
 return 
 if ($indice)
   then 
     let $size := (for $x in $map?*[?index=$m/@n]?size order by $x descending return $x)[1]
     let $forme := string-join(for $a in (xs:integer($m/@n) to xs:integer($m/@n)+$size - 1) 
                      return $corpus/phrase[@index=$idPhrases]/mot[@n=$a]/text(),' ')
     return 
      <mot type="polylex" 
           n="{$m/@n}" 
           pos="{string-join($map?*[?index=$m/@n]?pos[1])}" 
           mot="{$forme}" 
           lemme="{$forme}">
            {$forme}
    </mot>
     
    else if ($map?*?w=$m/@n)
      then ()
      
       else 
     $m
  
 }</phrase>  
      
)

 return 
 
  for $id in db:get('terreLuneEtiqueteBis')/db/phrase/@index
  return
   if ($phrases[@index=$id])
    then replace node db:get('terreLuneEtiqueteBis')/db/phrase[@index=$id] with $phrases[@index=$id] 
    else () 


      
   


