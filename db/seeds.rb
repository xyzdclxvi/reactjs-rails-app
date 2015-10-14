User.create(email: 'some@us.er', name: 'Some_user', password: 'passpass')
User.create(email: 'john@smi.th', name: 'John Smith', password: 'passpass')
User.create(email: '4he@a.d', name: '4head', password: 'passpass')
User.create(email: 'ke@ke.ke', name: 'He he hehe', password: 'passpass')
User.create(email: 'ss@ss.ss', name: 'sssssss', password: 'passpass')

u = User.all

u[0].announcements.create(title: 'Just do it', description: 'Do it, just do it! Don’t let your dreams be dreams. Yesterday you said tomorrow. So just do it! Make your dreams come true. Just do it. Some people dream of success, while you’re going to wake up and work hard at it. Nothing is impossible… you should get to the point where anyone else would quit and you’re not going to stop there. NO! What are you waiting for?! DO IT! JUST DO IT! YES YOU CAN! JUST DO IT! If you’re tired of starting over, stop giving up.')
u[2].announcements.create(title: 'WANTED: "DONUTS"', description: 'WANT DONUTS PLEZZZZZZ')
u[4].announcements.create(title: 'Eh haus', description: 'This luxurious hideaway that will awaken all of your senses has no concierge. As soon as the guest receives the key, he or she is the temporary owner of this miniature sanctuary. As you open the front door you will be overwhelmed by the symphony of light and color. Somewhere, hidden in the background, the music of Verdi\'s La Traviata fills the room. Close your eyes for a moment and you will understand why you don\'t need a concierge. You will have the feeling that you have arrived home! Such exquisite hospitality is something you have normally only dreamed about. ')
u[3].announcements.create(title: 'DUURZAAM WERKEN AAN WERK BLIJFT SUCCESVOL', description: 'Publiek-private samenwerking tussen gemeenten, UWV en de uitzendsector is een groot succes. Dat blijkt uit het actuele beeld van een aantal grote samenwerkingsprojecten, waarover de ABU en VNG twee jaar geleden schreven in de inspiratiegids Duurzaam werken aan werk. Vele honderden mensen zijn uit de uitkering aan het werk gekomen, werkgevers kunnen rekenen op een accurate service en de kruisbestuiving is nog lang niet uitgewerkt. Op de website van de ABU worden vijf projecten uitgelicht.')
u[0].announcements.create(title: 'This is empty', description: 'Nothing to see here.')

a = Announcement.all

Participant.create(announcement: a[0], user: u[1], status: 'accepted')
Participant.create(announcement: a[0], user: u[2], status: 'accepted')
Participant.create(announcement: a[0], user: u[4])

Participant.create(announcement: a[1], user: u[1], status: 'accepted')
Participant.create(announcement: a[1], user: u[0], status: 'rejected')
Participant.create(announcement: a[1], user: u[3], status: 'rejected')

Participant.create(announcement: a[2], user: u[0])

Participant.create(announcement: a[3], user: u[1], status: 'accepted')
Participant.create(announcement: a[3], user: u[2])
Participant.create(announcement: a[3], user: u[4], status: 'accepted')
