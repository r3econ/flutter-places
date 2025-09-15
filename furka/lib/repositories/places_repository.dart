import '/models/place.dart';

class PlacesRepository {
  var places = [
    Place(
      "Galenstock",
      46.61263,
      8.41712,
      3586,
      'The Galenstock is one of the most recognizable peaks of the Urner Alps, rising proudly above the Rhone Glacier. '
          'First climbed in 1845, it quickly became a milestone in the history of Swiss mountaineering. '
          'Today, its varied routes attract both ambitious climbers and glacier trekkers, offering challenges on ice and rock alike. '
          'From its summit, the panoramic views sweep across the Furka Pass and into the vast expanses of the Bernese Alps. '
          'Its prominent position makes it a natural landmark for anyone traveling through the region, blending rugged alpine beauty with rich climbing tradition.',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Galenstock%2C_west_side_2.jpg/960px-Galenstock%2C_west_side_2.jpg',
      'Stan45 / Wikimedia Commons – Public Domain',
    ),
    Place(
      "Klein Furkahorn",
      46.58573,
      8.40629,
      3026,
      'Klein Furkahorn, literally "Little Furka Peak," stands as the graceful sibling to the Gross Furkahorn. '
          'Perched above the scenic Furka Pass, it offers relatively easy ascents that reward hikers with astonishingly wide-ranging views. '
          'On clear days, visitors can admire not only the nearby Uri Alps but also far-reaching vistas toward the Matterhorn and even the Bernina massif. '
          'Its accessibility makes it a favorite for less technical adventurers, who enjoy the balance between effort and reward. '
          'The mountain is often combined with neighboring peaks, creating a memorable day out for mountaineers and nature lovers alike.',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Furka_54.JPG/960px-Furka_54.JPG',
      'Norbert Aepli / Wikimedia Commons – CC-BY-2.5',
    ),
    Place(
      "Gross Furkahorn",
      46.59661,
      8.41030,
      3169,
      'The Gross Furkahorn towers proudly over the Furka Pass and is celebrated as a premier climbing destination. '
          'Its granite faces are home to over fifty established climbing routes, making it a natural playground for alpine rock enthusiasts. '
          'One of its most famous routes, the ESE Ridge, offers classic alpine climbing with magnificent exposure and breathtaking scenery. '
          'Beyond climbing, the mountain’s summit rewards adventurers with sweeping views across the Gotthard and Grimsel regions. '
          'The Gross Furkahorn represents the spirit of alpine exploration: challenging yet inviting, dramatic yet accessible to those with determination.',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Sidelenhorn_%26_Gross_Furkahorn_from_Grimselpass%2C_2010_07.jpg/960px-Sidelenhorn_%26_Gross_Furkahorn_from_Grimselpass%2C_2010_07.jpg',
      'Simo Räsänen / Wikimedia Commons – CC-BY-2.5',
    ),
    Place(
      "Sidelenhorn",
      46.60085,
      8.40974,
      3215,
      'The Sidelenhorn stands on the great European watershed, marking the divide between the Aar and the Rhone river basins. '
          'This geographical importance adds to its allure as a hiking destination, with trails that are steep yet rewarding. '
          'Hikers who reach its summit are treated to extraordinary views of the Furka region and distant Alpine giants. '
          'Its proximity to both Grimsel and Furka passes makes it an accessible yet impressive goal for day trips. '
          'In local lore, it symbolizes the connection between north and south, a mountain bridging valleys and cultures.',
      null,
      null,
    ),
    Place(
      "Chli Bielenhorn",
      46.59891,
      8.43489,
      2940,
      'Chli Bielenhorn may be small in stature compared to its neighbors, but it is renowned among climbers for its immaculate granite. '
          'Its sunny south face features some of the best rock climbing routes in the Furka region, drawing enthusiasts from across Switzerland. '
          'The peak’s name, meaning "Little Horn," belies the grandeur of the climbing opportunities it offers. '
          'Its approachable altitude makes it an excellent training ground for alpine rock climbing, while still offering commanding views. '
          'For many, Chli Bielenhorn serves as both a stepping stone to larger summits and a rewarding destination in its own right.',
      null,
      null,
    ),
    Place(
      "Gross Bielenhorn",
      46.60360,
      8.42859,
      3210,
      'The Gross Bielenhorn is the mighty counterpart to the Chli Bielenhorn, boasting sheer granite walls and an imposing presence. '
          'Its southwest face is particularly famed, with long multi-pitch climbs that test skill and stamina. '
          'The mountain sits at the heart of a cluster of granite peaks that define the character of the Furka climbing area. '
          'From its summit, climbers enjoy a commanding panorama of glaciers, valleys, and distant Alpine ranges. '
          'The Gross Bielenhorn embodies the raw granite beauty of this corner of the Alps, challenging climbers while rewarding them with unforgettable views.',
      null,
      null,
    ),
    Place(
      "Gletschhorn",
      46.62064,
      8.43878,
      3305,
      'The Gletschhorn rises above the Furka Pass like a sentinel, its name reflecting its glacial surroundings. '
          'It is particularly popular among climbers for its varied routes, ranging from moderate ascents to demanding alpine climbs. '
          'The peak offers spectacular vantage points over the Rhone Glacier, which has been retreating dramatically in recent decades. '
          'Climbers and hikers alike are drawn to its rugged charm and the sense of remoteness it conveys. '
          'For those seeking a classic alpine adventure, Gletschhorn delivers the perfect blend of challenge and natural grandeur.',
      null,
      null,
    ),
    Place(
      "Winterstock",
      46.62151,
      8.45444,
      3203,
      'Winterstock, standing west of the village of Realp, is part of the rugged backbone of the Urner Alps. '
          'Its position on the ridge separating the Göschenertal from the Urseren valley gives it striking prominence. '
          'The mountain offers a range of climbing and ski touring opportunities, making it attractive across all seasons. '
          'In winter, its slopes are coated in snow that appeals to ski mountaineers, while in summer, its rocky ridges challenge alpinists. '
          'True to its name, Winterstock embodies the alpine spirit of resilience against the elements, drawing adventurers year-round.',
      null,
      null,
    ),
    Place(
      "Tiefenstock",
      46.62761,
      8.42233,
      3516,
      'The Tiefenstock is an elegant peak with steep, commanding flanks that rise dramatically above surrounding glaciers. '
          'It offers a range of challenging ascents, rewarding climbers with breathtaking solitude and spectacular alpine views. '
          'Its position makes it an excellent vantage point to observe both the Dammastock and the sprawling glacier systems nearby. '
          'The mountain is less frequented than its famous neighbors, adding to its allure for those who prefer untrodden paths. '
          'Standing on the summit, one is immersed in a sea of peaks, a truly humbling Alpine experience.',
      null,
      null,
    ),
    Place(
      "Dammastock",
      46.64390,
      8.42104,
      3630,
      'Dammastock, the highest peak of the Urner Alps, is a commanding presence that dominates the skyline. '
          'Its summit offers unparalleled views that stretch from the Bernese Oberland to the Valais and beyond. '
          'The mountain is often climbed via the Rhone Glacier, a route that combines glacier travel with alpine ascent. '
          'As a high peak, it demands respect and preparation, but the reward is one of the finest panoramas in Switzerland. '
          'Its stature as the roof of the Urner Alps has cemented its reputation as a classic objective for ambitious alpinists.',
      null,
      null,
    ),
    Place(
      "Schafberg",
      46.60654,
      8.46929,
      2590,
      'The Schafberg is a gentler summit compared to its neighbors, but it offers no less charm. '
          'Its grassy slopes make it a favorite destination for hikers seeking tranquility and scenic views. '
          'From the top, one can gaze over the Furka region, with the rugged granite peaks forming a dramatic backdrop. '
          'Its name, meaning "Sheep Mountain," hints at its pastoral character, where alpine meadows host grazing animals in summer. '
          'Schafberg is proof that not all Alpine beauty lies in difficulty—sometimes, the simplest routes yield the most serene rewards.',
      null,
      null,
    ),
    Place(
      "Lochberg",
      46.62443,
      8.46979,
      3078,
      'Lochberg rises prominently above the Göscheneralp and is often admired for its striking shape. '
          'Its trails attract hikers who are rewarded with expansive views of surrounding peaks and lakes. '
          'The mountain is especially beloved for its solitude, offering a quieter alternative to busier summits nearby. '
          'Its location makes it an ideal vantage point to observe the interplay of valleys, glaciers, and high ridges. '
          'Lochberg stands as a symbol of rugged beauty, inviting those who venture there to experience the Alps in their purest form.',
      null,
      null,
    ),
  ];
}
