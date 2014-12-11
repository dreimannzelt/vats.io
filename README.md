# VATS.io

The rates and names are taken from Wikipedia:
http://en.wikipedia.org/wiki/Value-added_tax

## Rates

URLs:
```
GET /rates.json
GET /rates/at.json
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

## Conversion

URL:
```
GET /rates/:locale/:locale_to/:amount
```

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
      "abbr": "MwSt.",
      "name": "Mehrwertsteuer",
      "rate": 19.0,
      "rates": {
        "standard": 19,
        "reduced": [
          7
        ]
      },
      "names": [
        [
          "MwSt.",
          "Mehrwertsteuer"
        ],
        [
          "USt.",
          "Umsatzsteuer"
        ]
      ]
    },
    "to": {
      "abbr": "MwSt.",
      "name": "Mehrwertsteuer",
      "rate": 20.0,
      "rates": {
        "standard": 20,
        "reduced": [
          12,
          10
        ]
      },
      "names": [
        [
          "MwSt.",
          "Mehrwertsteuer"
        ],
        [
          "USt.",
          "Umsatzsteuer"
        ]
      ]
    }
  }
}
```

### Parameters

| Parameter | Description | Values | Default |
| ---- | ---- | ---- | ---- |
| net | Set to false if given amount is gross | true/false | true |
| needs_net | Set to true if VAT should be excluded from amount field in response | true/false | false |


# Contribution

Please feel free to change, add or remove rates and or names. Fork it and open pull requests. We will review and merge it as soon as possible.

# Authors

@we5, @benediktdeicke and the rest of @dreimannzelt
