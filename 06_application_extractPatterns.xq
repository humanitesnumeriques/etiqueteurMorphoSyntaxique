(: Extraction de patterns syntaxiques:)

(:groupes prépositionnels:)
for sliding window $w in //phrase/mot
 start $a at $n when $a/@pos contains text {'prép.'} and not($a/preceding-sibling::*[1]/@posMorphalou contains text {'verb','pronoun','P'})
 only end $b at $m when ($b/@posMorphalou,$b/@pos) contains text {"commonNoun","pronoun","P"} and not(($b/@posMorphalou,$b/@pos) contains text {"verb"})
 where $m - $n gt 4 and $m - $n lt 15
return <w>{string-join($w/@mot/data(),' ')}</w>
,
(:relatives:)
for sliding window $w in //phrase/mot
 start $a at $n when $a/@mot contains text {"qui, que, quoi, dont, où"} any word using case sensitive using language "fr"
 only end $b at $m when ($b/@posMorphalou) contains text {"verb"} 
 where $m - $n gt 10
 return <w>{string-join($w/@mot/data(),' ')}</w>
