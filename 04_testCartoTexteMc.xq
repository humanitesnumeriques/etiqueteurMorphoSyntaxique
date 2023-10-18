(:Par Xavier-L. Salvador:)
(: 5_ Reconstruction du corpus:)
(:à partir de rsMcMap.xml:)
(:produit par mcIdenitifer.xq:)
(:Juste parce que c'est beau:)

declare variable $fichierMap := 'resMcMapTest.xml';
declare variable $corpus:=db:get('terreLuneEtiquete')/db;

for $idPhrases in  distinct-values(doc($fichierMap)//p[w]/@index)
  order by xs:integer($idPhrases) ascending
   return
   <p index="{$idPhrases}">{

    let $map := 
    map:merge(
     for $m in doc($fichierMap)//p[w][@index=$idPhrases]
      let $src := $m/@src/data()
      let $size := count(ft:tokenize($m/@src/data())) 
       for $w in $m/w
        return 
         map {
           $src: map{
            "size":$size, 
            "index":(ft:tokenize($w) ! xs:integer(.),',')[1],
            "w":tokenize($w),
            "pos" : distinct-values(tokenize($m/@pos)[1])
            } 
           }
           , map {"duplicates":"combine"})

       return
        string-join(
         for $m in $corpus/phrase[@index=$idPhrases]/mot 
         let $indice := xs:integer($map?*?index=$m/@n)
         let $size := xs:integer($map?*[?index=$m/@n]?size)
          return 
            (
           if ($indice)
            then 
             let $size := (
              for $x in $map?*[?index=$m/@n]?size order by $x descending return $x)[1]
                return 
                  "["||
                   "("||
                    string-join($map?*[?index=$m/@n]?pos)||
                    ") - "||
                    string-join(
                     for $a in (xs:integer($m/@n) to xs:integer($m/@n)+$size - 1)
                         return
                            $corpus/phrase[@index=$idPhrases]/mot[@n=$a]/text(),' ')||"]"
               else if ($map?*?w=$m/@n)
                 then ()
               else
                ("[("||
                  (distinct-values(if ($m/@pos) then $m/@pos else $m/@posMorphalou))||
                  ") - ",$m/@mot/data()||"]")   
               ,' ')
)
 }</p>  
      
   


      
   


