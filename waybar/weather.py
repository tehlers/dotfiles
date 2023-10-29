#! /usr/bin/env python

from datetime import datetime
import json
import os
import requests
from textwrap import dedent

API_URL = "https://api.openweathermap.org/data/2.5/weather"

API_PARAMETERS = dict(
    appid = os.getenv("OPENWEATHER_API_KEY"),
    id = os.getenv("OPENWEATHER_CITY"),
    lang = "de",
    units = "metric"
)

SYMBOL = "°C"
WEATHER_ICONS = {
    "01d": "󰖙",
    "01n": "",
    "02d": "󰖕",
    "02n": "󰼱",
    "03d": "󰖐",
    "03n": "󰖐",
    "04d": "",
    "04n": "",
    "09d": "",
    "09n": "",
    "10d": "",
    "10n": "",
    "11d": "",
    "11n": "",
    "13d": "",
    "13n": "",
    "50d": "",
    "50n": "",
}

WIND_DIRECTIONS = {
    0: "N",
    1: "NO",
    2: "NO",
    3: "O",
    4: "O",
    5: "SO",
    6: "SO",
    7: "S",
    8: "S",
    9: "SW",
    10: "SW",
    11: "W",
    12: "W",
    13: "NW",
    14: "NW",
    15: "N",
    16: "N",
}

def get_icon(icon):
    try:
        return WEATHER_ICONS[icon]
    except KeyError:
        return ""

def get_direction(degree):
    try:
        return WIND_DIRECTIONS[int((degree % 360) / 22.5)]
    except KeyError:
        return "?"

def generate_text(weather_data):
    temperature = weather_data["main"]["temp"]
    icon = get_icon(weather_data["weather"][0]["icon"])
    
    return f"{icon} {temperature:.0f}{SYMBOL}"

def generate_tooltip(weather_data):
    temperature_exact = weather_data["main"]["temp"]
    temperature_felt = weather_data["main"]["feels_like"]
    icon = get_icon(weather_data["weather"][0]["icon"])
    location = weather_data["name"]
    description = weather_data["weather"][0]["description"]
    wind_speed = weather_data["wind"]["speed"]
    wind_direction = get_direction(weather_data["wind"]["deg"])
    sunrise = datetime.fromtimestamp(weather_data["sys"]["sunrise"]).strftime("%H:%M")
    sunset = datetime.fromtimestamp(weather_data["sys"]["sunset"]).strftime("%H:%M")

    return dedent(f"""
        {location}
        {description} {icon}
        
        🌡 {temperature_exact}{SYMBOL} (gefühlt: {temperature_felt}{SYMBOL})
        Wind: {wind_speed * 3.6:.2f} km/h aus {wind_direction}

         {sunrise} -  {sunset}
    """).strip()

def main():
    response = requests.get(url = API_URL, params = API_PARAMETERS)
    try:
        weather_data = response.json()
        weather = json.dumps({"text": generate_text(weather_data), "tooltip": generate_tooltip(weather_data)}, ensure_ascii=False)
    except:
        weather = json.dumps({"text": f'⚠ ?{SYMBOL}', "tooltip": "Fehler beim Abruf der Wetterinformationen"}, ensure_ascii=False)

    print(weather.encode("utf-8").decode())

if __name__ == "__main__":
    main()
