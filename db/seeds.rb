Photographer.delete_all

Photographer.create!(
 name: 'Ansel Adams',
 description: 'I do some landscapes. Not really in Britain, though.',
 phone: '+1 123-234-3456',
 email: 'ansel@anseladams.com',
 image: 'img08.jpg',
 istock_name: 'mountainman',
 istock_userid: 123123123,
 city: 'San Francisco',
 country: 'USA')
 
Photographer.create!(
 name: 'Henri Cartier-Bresson',
 description: 'J\'aime prendre des photos de scènes de rue à travers le monde. Bien que, si je suis honnête, je ne fais pas vraiment beaucoup la photographie au Royaume-Uni.',
 website: 'www.henri.fr',
 phone: '+33 44-55-22-88',
 email: 'henri@henri.fr',
 image: 'henri-cartier-bresson.jpg',
 istock_name: 'Cartier-Bresson',
 istock_userid: 43214321,
 city: 'Paris',
 country: 'France')
 
Photographer.create!(
 name: 'Martin McCarthy',
 description: 'I am a Glasgow-based photographer who takes photographs in and around the Greater Glasgow area. I have a particular emphasis on the <i>Glaswegian</i> and <i>Photographic</i> aspects of my Glasgow-based, photography-based Glasgow photographs and like to make use of geo-photographic techniques to take photographs of particular geographic areas such as, for example, Glasgow. I live in Glasgow. I\'m a photographer.',
 website: 'www.theasis.co.uk',
 email: 'theasis@gmail.com',
 image: 'mm.jpg',
 istock_name: 'theasis',
 istock_userid: 1615935,
 city: 'Glasgow',
 country: 'UK')
Photographer.create!(
 name: 'Broken McTesty',
 description: 'I like to break and test things.',
 email: 'test@test.test',
 istock_name: 'mctesty',
 istock_userid: 55555555,
 city: 'Sheboygan',
 country: 'USA')
 
Lightbox.delete_all
