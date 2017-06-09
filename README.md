# Introduction

Henry Poitier est l'exercice utilisé pour les entretiens mobiles iOS et Android.

## Configuration Initiale

Le projet est déjà preconfiguré afin de simplifier le bootstrapping de l'exercice.

Les éléments suivants ont été mis en place préalablement :

### Dépendances

- CocoaPods (gestionnaire de dépendances)
- Alamofire (helper pour interaction avec le réseau)
- Unbox (déserialisation JSON)
- Kingfisher (helper pour téléchargement / caching des image)

### Interface

Une interface avec un UICollectionViewController, permettant la visualisation de données en grilles, est déjà en place.

## Pour commencer

Ouvrez le projet `HenryPoitierXKE.xcworkspace`.

# Snippets

Afin de réussir dans le déroulement de l'exercice, voici quelques morceaux de code utiles.

## Basiques de la syntaxe Swift

**Variables**
```swift
let cat: Cat // Immuable
var cat: Cat // Muable
var cat: Cat? // Optional (peut être null)
```

**Fonctions**
```swift
func doSomething() -> Int {
	
}
```

## Objets

```swift
struct Cat {
	let name: String
	let age: Int
}

// ou

class Cat {
	let name: String
	let age: Int
}

```

## Déserialisation

À partir du JSON suivant :

```json
{
	"name": "Kiko",
	"age": 1
}
```

```swift
import Unbox

// ... Declaration du modèle

init(unboxer: Unboxer) throws {
    self.name = try unboxer.unbox(key: "name")
    self.age = try unboxer.unbox(key: "age")
}
```

## Appels réseau + Création de modèles

```swift
import Unbox

// ...

Alamofire.request("https://my.awesome/cats")
    .responseArray { (response: DataResponse<[Cat]>) in
        let cats = response.result.value
    }
```

## Configurer une collection

```swift
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return // Number of results
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? TypeDeMaCell else {
        fatalError()
    }
    // Configurez la cellule
    return cell
}
```



