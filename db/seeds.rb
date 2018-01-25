# require 'faker'

p "Destroying users..."
User.destroy_all

p "Creating users..."
user_admin = User.create!(email: "admin@gmail.com", password: "123456")
user_test_1 = User.create!(email: "test1@gmail.com", password: "123456")
user_test_2 = User.create!(email: "test2@gmail.com", password: "123456")

p "Destroying flats..."
Flat.destroy_all

p "Creating flats..."
flat_1 = Flat.create!(title: "Appartement T3 Roy d'Espagne 64m2",
         description: "Particulier vend appartement T3 lumineux au 2ème et dernière étage d'un charmant immeuble situé au parc du Roy d'Espagne. Résidence calme et arborée, au pied du massif de Marseilleveyre et de ses calanques, à 15 min de la plage à pied. 56 m2 loi Carrez. 64 m2 au sol (travaux d'aménagement effectués: séjour et cuisine ouvert sur anciens balcons.) Un grand séjour de 25m2, sans vis à vis, avec baie vitrée sur pinède. Deux chambres, une grande cuisine équipée, une salle d'eau, toilette séparé et une cave. Parking facile, proximité toute commodité (écoles, commerces, bus). Double vitrage, chauffage collectif. Aucuns travaux à prévoir. Taxe foncière 770eur/an Charge de copropriété 150eur/mois. Pas d'agence merci.",
         address: "1 avenue André Zénatti, Marseille", floor: 2, rooms: 3, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 170000, average_price: 2800, size: 64,
         average_size: 45,
         image_url: "https://img4.leboncoin.fr/ad-image/9143094e8e65fb8c274f451f4074f12f8882cc78.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1355561133.htm")
flat_2 = Flat.create!(title: "T3 Parc Borély",
         description: "Secteur Parc Borély / Les plages. Dans résidence fermé et sécurisé, beau T3 rénové au 2e étage sur 3. Cuisine équipée ouverte sur séjour. Salle de bain récente. Deux chambres. Un grand dressing. Serrure 3 points. Une cave en sous-sol. Chauffage individuel Gaz (chaudière entretenue). Faible charge et taxe foncière. A saisir rapidement.", address: "2 avenue Elsa Triolet, Marseille",
         floor: 2, rooms: 3, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 7, 1, 0, 0, 0, 0), price: 169000, average_price: 3100, size: 50,
         average_size: 45,
         image_url: "https://img2.leboncoin.fr/ad-image/4801cf0b27526b101ba4dda7bd77adcbcb6604ab.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1370061049.htm")
flat_3 = Flat.create!(title: "Appartement 4 pièces avec 245 m2 de jardin",
         description: "magnifique appartement 4 pièces neuf de 78 m2 et 245 m2 de jardin Marseille 8e, face au parc Borély en triple exposition, 3 chambres, très beau salon cuisine. Prestations soignées et un garage dans un cadre privilégié au coeur d'une petite résidence de standing et sécurisée. 493 000 € avec garage et frais d'agence inclus", address: "20 rue Oberkampf, Paris",
         floor: 4, rooms: 4, average_rooms: 3, bedrooms: 3, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 49300, average_price: 1200, size: 78, average_size: 45,
         image_url: "https://img1.leboncoin.fr/ad-image/0a0c4e369eed9d50e8bacb06f054eae236a26ce7.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1349944274.htm")
flat_4 = Flat.create!(title: "Appartement 2 pièces 66 m²",
         description: "Bel Appartement 5 etage avec ascenseur, avenue du Prado/ Boulevard Perrier. Cet appartement se situe à proximité dans une petite Copropriété non loin des transports et commerces, lumineux, au 5 ème étage avec ascenseur, traversant. Composé d'un grand séjour , donnant sur une cuisine ouverte, 1 salle de bains, 1 chambre, 1 balcon,1 wc séparé, 1 cave.Le bien comprend 1 lot, et il est situé dans une copropriété de 10 lots (les charges courantes annuelles moyennes de copropriété sont de 2400€). Contactez votre conseiller SAFTI : Edouard LORTHIOIS, Tél. : 06 28 81 27 03, E-mail : edouard.lorthiois@safti.fr - Agent commercial immatriculé au RSAC de MARSEILLE sous le numéro 828 023 333. Référence annonce : 214310. Les honoraires sont à la charge du vendeur",
         address: "2 avenue du Prado, Marseille",
         floor: 2, rooms: 1, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 221704,
         average_price: 4000, size: 66, average_size: 45,
         image_url: "https://img1.leboncoin.fr/ad-image/419a924f972bc73d935abcb0eec1685011f78035.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1342379562.htm")
flat_5 = Flat.create!(title: "ROND POINT PRADO T3 95m2 Marseille 8ème",
         description: "A 2 pas du Rond Point du Prado, superbe T3 de 95m² au 4ème étage avec ascenseur dans un immeuble de standing sur l'Avenue du Prado. Appartement traversant et lumineux, entièrement rénové et équipé avec goût, composé d'une très belle pièce à vivre avec un coin salle à manger et un coin salon, d'une cuisine américaine toute équipée avec des équipements de qualité, d'un coin buanderie sur la loggia équipé de lave-linge et sèche-linge, de 2 belles chambres avec rangements, d'une salle de bains moderne et d'un wc séparé. Petit balcon côté Prado, double vitrage partout, climatisation réversible. Proche de toutes commodités. Disponible immédiatement. Exposition EST / OUEST. 1 cave en sous-sol. Façade de l'immeuble rénovée récemment. Charges mensuelles de 130 EURO par mois. Taxe foncière de 1400 EURO.",
         address: "12 avenue du Prado, Marseille",
         floor: 4, rooms: 3, average_rooms: 3, bedrooms: 2, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 380000,
         average_price: 3900, size: 95, average_size: 45,
         image_url: "https://img2.leboncoin.fr/ad-image/934c90829fef799de95b16bf672b20d909e9c554.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1369898754.htm")
flat_6 = Flat.create!(title: "GRAND Type 1 ST VICTOR 7ème",
         description: "Particulier vends grand type 1 de 33 m2 au 1er étage surélevé dans une copropriété de 45 petits logements. Idéalement placé et à proximité de tous commerces et transport. Bonne rentabilité pour location saisonnière ou étudiante. Ce logement est composé : d'un hall d'entrée desservant une salle d'eau entièrement carrelée, un WC indépendant et suspendu. Une grande pièce avec une cuisine américaine (frigo-congélateur, plaque induction, four traditionnel et lave-linge), grand salon avec canapé cuir et BZ en 160 et placards de rangement. Les fenêtres sont en PVC double vitrage. Le tout en excellent état. Charges mensuelles 35 €.",
         address: "12 boulevard de la Corderie, Marseille",
         floor: 1, rooms: 1, average_rooms: 3, bedrooms: 1, average_bedrooms: 1.4,
         date: DateTime.new(2017, 6, 1, 0, 0, 0, 0), price: 125000,
         average_price: 4200, size: 33, average_size: 45,
         image_url: "https://img3.leboncoin.fr/ad-image/cc160779711addc660d556124e385ef8f3ba5288.jpg",
         url: "https://www.leboncoin.fr/ventes_immobilieres/1370138189.htm?ca=12_s")


# puts 'Creating 100 fake restaurants...'
# 20.times do
#   flat = Flat.new(
#     title:    Faker::Company.name,
#     description: Faker::Lorem.sentence,
#     address:  "#{Faker::Address.city}",
#     floor:  (0..6).to_a.sample,
#     rooms:  (1..7).to_a.sample,
#     average_rooms:  (1..7).to_a.sample,
#     bedrooms:  (0..5).to_a.sample,
#     average_bedrooms:  (0..5).to_a.sample,
#     date:  DateTime.new(2017, 6, 1, 0, 0, 0, 0),
#     price:  (100000..500000).to_a.sample,
#     average_price:  (100000..500000).to_a.sample,
#     size:  (10..500).to_a.sample,
#     average_size:  (10..500).to_a.sample,
#     image_url: Faker::Image.city,
#     url: Faker::Internet.url,
#   )
#   flat.save!
# end
# puts 'Finished!'

p "Destroying wishes..."
Wish.destroy_all

p "Creating wishes..."
wish_1 = Wish.create(flat: flat_1, user: user_test_1)
wish_2 = Wish.create(flat: flat_2, user: user_test_1)
wish_3 = Wish.create(flat: flat_6, user: user_test_1)
wish_4 = Wish.create(flat: flat_3, user: user_test_2)
wish_5 = Wish.create(flat: flat_4, user: user_test_2)
