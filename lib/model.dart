class Model {
  var applicable_date;
  var min_temp;
  var max_temp;
  var weather_state_abbr;

  Model({this.max_temp, this.min_temp, this.applicable_date , this.weather_state_abbr});

  factory Model.fromjson(Map<String, dynamic> JsonData) {
    return Model(
        applicable_date: JsonData["applicable_date"],
        max_temp: JsonData["max_temp"],
        min_temp: JsonData["min_temp"],
        weather_state_abbr: JsonData["weather_state_abbr"]
    );
  }
}