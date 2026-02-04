const Map<String, dynamic> tripSchema = {
  "type": "object",
  "properties": {
    "title": {"type": "string"},
    "description": {"type": "string"},
    "startDate": {"type": "string", "format": "date"},
    "endDate": {"type": "string", "format": "date"},
    "destinations": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name": {"type": "string"},
          "description": {"type": "string"},
          "latitude": {"type": "number"},
          "longitude": {"type": "number"},
        },
        "required": ["name", "latitude", "longitude"],
      },
    },
  },
  "required": ["title", "startDate", "endDate", "destinations"],
};
