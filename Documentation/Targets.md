# CityOS LED application targets

- Cache:
	RealmLamp - Lamp definition
	RealmZone - Zone definition
	Cache class - Cache helper functions

	Notes:
		Should be linked only to the `RealmSwift` and `Realm` frameworks

- Cache Tests
	
	Notes:
		Implements tests for Cache framework

- LightFactory:
	LampDataCollection - Data collection used for lamp (`LiveDataCollectionType`)
	Lamp - Lamp definition (`DeviceType`)
	LampZone - Zone definition (`ZoneType`)
	Serializer - JSON serializer
	LightFactory - Retrieving data from server

- Flowthings:
	FlowType - Enum Flow definition
	FlowRequest - Flowthings request builder
	Flowthings - server logic