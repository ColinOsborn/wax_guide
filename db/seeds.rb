# User creation for testing purposes

# Ski Brands Creation
SkiBrand.create!(
  name: 'Salomon',
  subtitle: 'Now, it’s time to play.',
  body: 'Salomon has been playing in the French alps since 1947.',
  main_image: 'app/assets/images/logos/salomon.png',
  thumb_image: 'app/assets/images/logos/salomon.png',
)
puts 'Salomon ski brand has been created!'

SkiBrand.create!(
  name: 'Fischer',
  subtitle: "Skiing is not a lifestyle - it's life",
  body: "The company was founded in 1924 by Josef Fischer Sr., a cartwright, in Ried im Innkreis, northeast of Salzburg, Austria. In addition to making wagons, he made an occasional pair of skis. By 1938,[1] the company had significantly expanded its ski manufacturing, with 30 employees, and was selling 2,000 pairs of handmade skis in the United States alone. Following the conclusion of World War II, Josef Fischer Jr. became involved in the reconstruction of the company.",
  main_image: 'app/assets/images/logos/fischer_logo.png',
  thumb_image: 'app/assets/images/logos/fischer_logo.png',
)
puts 'Fischer ski brand has been created!'

SkiBrand.create!(
  name: 'Madshus',
  subtitle: 'Attention to detail has defined Madshus skis for over 100 years.',
  body: "The ambition was born in 1906 in a barn on the Vardal farm belonging to Martin Madshus’ father. Crafting his first wooden skis with hand-made tools, the obsession was cemented. Martin’s keen eye for materials focused intently on his core material, the raw wood purchased for shaping skis.",
  main_image: 'app/assets/images/logos/madshus_logo.png',
  thumb_image: 'app/assets/images/logos/madshus_logo.png',
)
puts 'Madshus ski brand has been created!'
