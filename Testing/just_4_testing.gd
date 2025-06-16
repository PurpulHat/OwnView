extends Node


var json_data = {
	"chocolat": {
		"pasfou": {
			"perimé": ["DeHier", "DeAujourd'Hui"]
			}
		},
		"meilleur": ["lait", "chocolat"],

	"entreprise": {
		"nom": "Tech Innovators",
		"adresse": {
			"rue": "123 Rue de l'Innovation",
			"ville": "Paris",
			"codePostal": "75001"
			},
		"departements": [
		{
				"nom": "Développement",
					"employes": [
					{
						"id": 1,
						"nom": "Alice Dupont",
						"poste": "Développeuse",
						"competences": ["JavaScript", "React", "Node.js"],
						"projets": [
							{
								"id": 101,
								"nom": "Application Mobile",
								"dateDebut": "2023-01-15",
								"dateFin": "2023-06-30"
							},
							{
								"id": 102,
								"nom": "Site Web",
								"dateDebut": "2023-02-01",
								"dateFin": "2023-05-15"
							}
						]
					},
					{
						"id": 2,
						"nom": "Bob Martin",
						"poste": "Développeur Backend",
						"competences": ["Node.js", "Python"],
						"projets": [
							{
								"id": 103,
								"nom": "API de Gestion",
								"dateDebut": "2023-03-01",
								"dateFin": "2023-08-15"
							}
						]
					}
				]
			},
			{
				"nom": "Design",
				"employes": [
					{
						"id": 3,
						"nom": "Claire Bernard",
						"poste": "Designer UI/UX",
						"competences": ["Photoshop", "Figma"],
						"projets": [
							{
								"id": 102,
								"nom": "Site Web",
								"dateDebut": "2023-02-01",
								"dateFin": "2023-05-15"
							}
						]
					}
				]
			}
		]
	}
}
