import 'package:limen_app/domain/models/category.dart';
import 'package:limen_app/domain/models/verse.dart';

const List<Category> kCategories = [
  Category(id: 'joy', name: 'Joy'),
  Category(id: 'sadness_comfort', name: 'Sadness / Comfort'),
  Category(id: 'motivation', name: 'Motivation'),
  Category(id: 'empowerment', name: 'Empowerment'),
  Category(id: 'stillness', name: 'Stillness'),
  Category(id: 'gratitude', name: 'Gratitude'),
  Category(id: 'guidance', name: 'Guidance'),
];

const List<Verse> kVerses = [
  Verse(
    id: 'joy_1',
    text: 'You have put more joy in my heart than they have when their grain and wine abound.',
    reference: 'Psalm 4:7',
    categoryId: 'joy',
  ),
  Verse(
    id: 'joy_2',
    text: 'The joy of the Lord is your strength.',
    reference: 'Nehemiah 8:10',
    categoryId: 'joy',
  ),
  Verse(
    id: 'sadness_1',
    text: 'He heals the brokenhearted and binds up their wounds.',
    reference: 'Psalm 147:3',
    categoryId: 'sadness_comfort',
  ),
  Verse(
    id: 'sadness_2',
    text: 'Come to me, all who labor and are heavy laden, and I will give you rest.',
    reference: 'Matthew 11:28',
    categoryId: 'sadness_comfort',
  ),
  Verse(
    id: 'motivation_1',
    text: 'Whatever you do, work heartily, as for the Lord and not for men.',
    reference: 'Colossians 3:23',
    categoryId: 'motivation',
  ),
  Verse(
    id: 'motivation_2',
    text: 'Let us not grow weary of doing good, for in due season we will reap.',
    reference: 'Galatians 6:9',
    categoryId: 'motivation',
  ),
  Verse(
    id: 'empowerment_1',
    text: 'I can do all things through him who strengthens me.',
    reference: 'Philippians 4:13',
    categoryId: 'empowerment',
  ),
  Verse(
    id: 'empowerment_2',
    text: 'God gave us a spirit not of fear but of power and love and self-control.',
    reference: '2 Timothy 1:7',
    categoryId: 'empowerment',
  ),
  Verse(
    id: 'stillness_1',
    text: 'Be still, and know that I am God.',
    reference: 'Psalm 46:10',
    categoryId: 'stillness',
  ),
  Verse(
    id: 'stillness_2',
    text: 'In returning and rest you shall be saved; in quietness and trust shall be your strength.',
    reference: 'Isaiah 30:15',
    categoryId: 'stillness',
  ),
  Verse(
    id: 'gratitude_1',
    text: 'Give thanks in all circumstances; for this is the will of God in Christ Jesus for you.',
    reference: '1 Thessalonians 5:18',
    categoryId: 'gratitude',
  ),
  Verse(
    id: 'gratitude_2',
    text: 'Enter his gates with thanksgiving, and his courts with praise.',
    reference: 'Psalm 100:4',
    categoryId: 'gratitude',
  ),
  Verse(
    id: 'guidance_1',
    text: 'Trust in the Lord with all your heart, and he will make straight your paths.',
    reference: 'Proverbs 3:5-6',
    categoryId: 'guidance',
  ),
  Verse(
    id: 'guidance_2',
    text: 'Your word is a lamp to my feet and a light to my path.',
    reference: 'Psalm 119:105',
    categoryId: 'guidance',
  ),
];
