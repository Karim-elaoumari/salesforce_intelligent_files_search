Documentation du Composant LWC "Intelligent Files Search"

Table de Matieres :

1-Aperçu du Composant LWC "Intelligent Files Search":
Le composant LWC "Intelligent Files Search" est une solution puissante et flexible qui permet aux utilisateurs de rechercher des fichiers dans Salesforce en utilisant des critères avancés de recherche. Il prend en charge la recherche par contenu et par titre de fichier, la recherche par extension de fichier, et offre des fonctionnalités de filtrage et d'affichage de résultats personnalisables.

2- Objectif et fonctionnalités:
a-Objectif:
Le principal objectif du composant "Intelligent Files Search" est de fournir aux utilisateurs une interface conviviale pour rechercher rapidement et efficacement des fichiers dans Salesforce, quels que soient leur contenu, leur extension ou leur taille. Il offre des fonctionnalités avancées de recherche et de filtrage pour répondre aux besoins de recherche les plus complexes.

b-Fonctionnalités:
Recherche par Contenu et par Titre : Les utilisateurs peuvent rechercher des fichiers en spécifiant des termes de recherche dans le contenu du fichier ou dans son titre.
Recherche par Extension : Les utilisateurs peuvent filtrer leur recherche en fonction de l'extension du fichier, par exemple : PDF, Excel, Word, etc.
Résultats en Temps Réel : Les résultats de la recherche sont affichés en temps réel au fur et à mesure que l'utilisateur tape sa requête et clique sur ‘search’.
Interface Conviviale : L'interface utilisateur est intuitive et conviviale, permettant une expérience de recherche fluide.
Personnalisation : Les utilisateurs peuvent personnaliser les options de recherche et les filtres selon leurs besoins.
Prévisualisation de Fichier : Les utilisateurs peuvent prévisualiser les fichiers trouvés et effectuer des actions telles que le téléchargement et la suppression.
Gestion des Langues : Le composant prend en charge la détection de la langue du contenu et fournit des options pour personnaliser les langues prises en charge.
Utilisation Recommandée
Le composant "Intelligent Files Search" est recommandé pour les organisations qui gèrent un grand nombre de fichiers dans Salesforce et ont besoin d'une solution de recherche avancée pour localiser rapidement des fichiers spécifiques. Il est particulièrement utile pour les entreprises multilingues et celles qui travaillent avec différents types de fichiers.


3-Installation et Configuration:
	a-Prérequis:
	Cette solution est accessible sous n’importe quelle licence Salesforce et par n’importe quel utilisateur, sauf si l'administrateur a restreint l'accès (ou si l'option “all users” n'a pas été choisie lors de l'installation du package).

	b-Installation dans une organisation Salesforce:
		Pour installer le package comprenant le composant vous pouvez utiliser l’id: 

04t8d000000Eom7
	
	Utiliser cet Id au niveau de l’élément “INSTALL A PACKAGE” sur votre organisation où vous souhaitez avoir le composant de recherche comme dans la figure suivante, ensuite cliquez sur ‘INSTALL’:


	
Comme vous pouvez aussi cliquer directement sur le lien suivant : 

https://login.salesforce.com/packaging/installPackage.apexp?p0=04t8d000000Eom7

Qui ensuite vous rédigerez directement à la page d'authentification afin de choisir sur quelle organisation vous souhaitez installer le package:


Dans les deux scénarios vous serez redirigés vers la page d’installation, dans laquelle vous choisissez pour qui vous voulez installer le package (choisissez ‘All Users’ pour que tous les utilisateurs auront l'accès à cette solution où un autre choix selon votre besoin).

Cochez en suite l’option: ‘I acknowledge that I’m installing a Non-Salesforce Application that is not authorized for distribution as part of Salesforce’s AppExchange Partner Program..’ (vous n’aurez plus besoin de la cocher dès que le package sera disponible sur AppExchange de Salesforce et c’est très proche).

Puis cliquez sur ‘INSTALL’ .


Ensuite, vous approuvez l'accès aux applications tierces. Cette approbation est nécessaire pour une installation correcte de la solution. Ensuite, cliquez sur "Continuer".

Ensuite, vous attendez un certain temps pour que l'installation soit terminée, puis un message de confirmation s'affiche :


Maintenant vous aurez votre composant à votre disposition.

	
	c-Configuration de l'accès aux données et des autorisations:
En général, l'utilisateur n'aura accès qu'à ces fichiers, à moins que l'administrateur ait une opinion différente concernant l'ajout ou la restriction des permissions des utilisateurs



4-Utilisation de base:
a-Accéder au composant dans Salesforce
Apres avoir accès à son organisation ,et pour utiliser le composant on procède comme suit:

Sur le lanceur d’applications Salesforce tapez ‘Intelligent’ puis choisissez l’option:”Intelligent Files Search” comme présenté dans la figure suivante:

Vous aurez comme résultat une nouvelle fenêtre contenant le composant suivant: