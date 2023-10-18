(:Par Xavier-L. Salvador:)
(:4: Sauver dans un fichier la cartographie des mots composés:)
(:On part du corpus étiqueté et on va commencer à intégrer la liste des mots composés:)
(: et des expressions polylexicales:)
(:On va repérer un index par phrases et par mots:)
(:Puis on revient vers le corpus pour marquer les unités:)
(:Ressources LDI ex UMR 7187:)

declare option output:indent "yes";
declare option ft-option "diacritics sensitive";  
declare variable $corpus := db:get("terreLuneEtiquete")/db/phrase;
declare variable $corpusJoin := string-join($corpus//text(),' ');
declare variable $bddMotsComp := db:get('motsComposes')/db/mc;
declare variable $motscomp := file:read-text-lines('listeOccurrenceMCcandidats.txt');
(:148000 ms en partant du fichier qui se produit en une seconde, soit 2 minutes:)

file:write(
  "resMcMapTest.xml"
  ,
   <res>{
    for $m in $motscomp
    let $nb := count(ft:tokenize($m))
    let $motif:= ft:tokenize($m)
     where $nb gt 1
      for $p in $corpus
       return
       if (string-join($p//text(),' ') contains text {$motif} all window ($nb + 1) words)
       then
       <p src="{$m}" 
          pos="{if ($bddMotsComp[./@src=$m]/@pos) then distinct-values($bddMotsComp[./@src=$m]/@pos) else 'XXX'}" 
          index="{$p/@index}">
        {
         for sliding window $w in $p/mot
         start $a at $n when ft:tokenize($a) = $motif[1]
         end $z at $o when (ft:tokenize($z) = $motif[$nb])
          where $o - $n le $nb+1
          return
           <w>{data($w/@n)}</w>
         }</p>
      }</res>
)

