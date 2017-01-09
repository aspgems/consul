puts "Creating Geozones"
["Nucleo Urbano","Urbanizaciones","Poligonos Industriales"].each{|zone| Geozone.find_or_create_by(name: zone)}

puts "Creating Categories Tags"

ActsAsTaggableOn::Tag.find_or_create_by(name:  "Asociaciones", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Cultura", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Deportes", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Derechos Sociales", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Economía", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Empleo", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Equidad", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Sostenibilidad", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Participación", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Movilidad", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Medios", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Salud", featured: true , kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Transparencia", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Seguridad y Emergencias", featured: true, kind: "category")
ActsAsTaggableOn::Tag.find_or_create_by(name:  "Medio Ambiente", featured: true, kind: "category")
