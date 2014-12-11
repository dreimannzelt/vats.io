# VATS.io

The rates and names are taken from Wikipedia:
http://en.wikipedia.org/wiki/Value-added_tax


## Rates

URLs:
```
GET /rates.json
GET /rates/:code.json
```

The variable `:code` is based on ISO 3166.

### Response

JSON:
```json
{
  "at": {
    "standard": 20,
    "reduced": [12, 10]
  },
  ...
}
```

Standard rates are always single values while reduced rates are always wrapped as array and sorted in descending order.


## Conversion

URL:
```
GET /rates/:origin_code/:target_code/:amount
```

The variables `:origin_code` and `:target_code` are based on ISO 3166.

### Response

JSON:
```json
{
  "net": 100.0,
  "gross": 120.0,
  "amount": 120.0,
  "vat_amount": 20.0,
  "vats": {
    "from": {
      "code": "de",
      "abbr": "MwSt.",
      "name": "Mehrwertsteuer",
      "rate": 19.0
    },
    "to": {
      "code": "at",
      "abbr": "MwSt.",
      "name": "Mehrwertsteuer",
      "rate": 20.0
    }
  },
  "_parameters": {
    "origin_code": "de",
    "target_code": "at",
    "amount": "100",
    "is_net": true,
    "needs_net": false
  }
}
```

### Parameters

| Parameter | Description | Values | Default |
| ---- | ---- | ---- | ---- |
| net | Set to false if given amount is gross | true/false | true |
| needs_net | Set to true if VAT should be excluded from amount field in response | true/false | false |


## Names

URLs:
```
GET /names.json
GET /names/:locale.json
```

### Response

JSON:
```json
{
  "bg": [["ДДС", "Данък върху добавената стойност"]],
  ...
}
```

The variable `:locale` is based on ISO 639-1.

Names are always returned as an array with one or many nested array(s). The first entry of the inner array is the abbreviation and the last entry is the complete name/description of the VAT for this locale.


# Contribution

Please feel free to change, add or remove rates and or names. Fork it and open pull requests. We will review and merge it as soon as possible.


# Authors

@we5, @benediktdeicke and the rest of @dreimannzelt
