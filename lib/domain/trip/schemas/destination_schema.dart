const Map<String, dynamic> destinationSchema = {
  "type": "object",
  "properties": {
    "name": {"type": "string"},
    "description": {"type": "string"},
    "latitude": {"type": "number"},
    "longitude": {"type": "number"},
    "photoUrl": {"type": "string", "format": "uri"},
  },
  "required": ["name", "latitude", "longitude"],
};
