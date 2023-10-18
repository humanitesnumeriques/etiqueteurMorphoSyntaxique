# etiqueteurMorphoSyntaxique


![etiqueteurProcess](https://github.com/humanitesnumeriques/etiqueteurMorphoSyntaxique/assets/28839416/74a52705-3628-41d8-b8c0-a9120f462e9a)

Ce répertoire est un cours en Humanités Numériques qui présente tous les éléments nécessaires à la programmation d'un étiqueteur morphosyntaxique à partir de la ressource Morphalou en XQuery via le logiciel Basex. Le cours présente toutes les problématiques. 
La Vidéo du cours est disponible ici (https://www.youtube.com/watch?v=JHtINEseALw) et présente : 

- la manipulation de fichiers pour la création automatique de bases de données indexées
- la création et la manipulation de la ressource Morphalou (Xpath et Adressage des données)
- la tokenization et la normalisation du corpus grâce aux outils de la biblitohèque Full-Text
- le croisement des données pour la production d'un étiquetage dans différents formats (XML, JSON)
- la logique des Hash Tables, Dictionnaires et map{} en Xquery
- la reconfiguration et l'optimisation des ressources de gros volumes en vue de leur projection
- enfin, le cours aborde quelques pistes en vue de la déssambiguïsation des résultats par le filtre statistique

Les fichiers de programmation du cours, enfin les deux plus importants, sont disponibles sur Github ici: 

Un prochain cours présentera l'utilisation de ces outils pour l'extraction automatique de "patterns syntaxiques".

- Basex est un outil incroyable disponible gratuitement ici: http://basex.org
- Morphalou est une remarquable ressource construite par le laboratoire ORTOLANG - Outils et Ressources pour un Traitement Optimisé de la LANGue - ANRu201311u2013EQPXu20130032: https://www.ortolang.fr/market/lexicons/morphalou
- TILDE est un Master Pro de l'Université Sorbonne Paris Nors (Paris 13) où on enseigne à faire ça : https://www.univ-spn.fr
- La ressource de fréquence statistique lexicale est disponible sur Eduscol disponible ici: https://eduscol.education.fr/186/liste-de-frequence-lexicale


Que chacun trouve ici l'expression de ma gratitude. 

Chaque fichier occupe une place dans la chaîne décrite par le schéma. Il s'agit de mettre en place un étiqueteur qui utilise trois ressources:
 - Morphalou
 - la base des unités polylexicales du LDI
 - la ressource statistique de fréquence d'Eduscol
et se projette sur un corpus: ici, il s'agit du roman de Jules Verne <i>De la Terre à la Lune</i> mais l'ensemble est facilement transposable.
Pour des soucis pédagogiques, chacune des 6 étapes est décrite de manière séquentielle par un script différent:
  - On transforme Morphalou en un map{} exploitable rapidement (3 secondes pour étiqueter tout le roman)
  - On projette la ressource sur le corpus
  - On récupère et ion intègre les données statistiques
  - On repère et on marque les unités polylexicales ("en fait de", "parce que", "d'abord", "en opposition") en intégran tla description mortphologique de la donnée repérée
  - On restructure la base d'étiquetage à partir de ces nouvelles informations
  - Enfin, quelques exemples d'applications dans le fichier 06: extraction des groupes prépositionnels, extraction des propositions subordonnées relatives.

L'ensemble du procédé prend environ deux minutes pour un corpus de 100 000 mots environ; 700 mégas de données de ressources; 50 000 unités poluylexicales repérables et 5000 données statistiques. L'ensemble n'a pas encore été évalué contre d'autres procédés.

    On pourrait aller encore plus loin évidemment, mais le travail de dégrossissage d'un corpus est complet. Il faut par exemple encore restructurer le jeu d'étiquettes final et appliquer quelques règles de désambigiuïsation extrêmement simples.

    La prochaine étape consistera à intégrer ce processus dans une chaîne de représentation graphique (SVG) des résultats et dans un logiciel Web.


