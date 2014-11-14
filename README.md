# VATS.io

The rates and names are taken from Wikipedia:
http://en.wikipedia.org/wiki/Value-added_tax

## Rates

URLs:
````
GET /rates.json
GET /rates/:code.json
````

The variable `:code` is based on ISO 3166.

### Format

JSON:
````
{
  "at": {
    "standard": 20,
    "reduced": [12, 10]
  },
  ...
}
````

Standard rates are always single values while reduced rates are always wrapped as array and sorted in descending order.

## Names

URLs:
````
GET /names.json
GET /names/:locale.json
````

JSON:
````
{
  "bg": [["ДДС", "Данък върху добавената стойност"]],
  ....
}
````

The variable `:locale` is based on ISO 639-1.

Names are always returned as an array with one or many nested array(s). The first entry of the inner array is the abbreviation and the last entry is the complete name/description of the VAT for this locale.


# Contribution

Please feel free to change, add or remove rates and or names. Fork it and open pull requests. We will review and merge it as soon as possible.

# Authors

@we5, @benediktdeicke and the rest of @dreimannzelt
