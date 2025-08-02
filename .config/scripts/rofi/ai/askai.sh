#!/bin/bash

# source the environment variables
source "$HOME/.askai-env"

# Get user input from rofi
content=$(echo "" | rofi -dmenu -config ~/.config/rofi/ai.rasi -p ">" -theme-str 'window { width: 40em; } listview { lines: 0; } entry { placeholder: "Ask AI..."; }')

# Make sure content is not empty
if [ -z "$content" ]; then
  echo "No input provided. Exiting..."
  exit 1
fi


# Start Response Display
rm /tmp/askai-resp.md
kitty --detach --class "askai" --override="font_size 14" ~/.config/scripts/rofi/ai/display-resp.sh

# Send request to Gemini API
response=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent" \
  -H 'Content-Type: application/json' \
  -H "X-goog-api-key: $GEMINI_API_KEY" \
  -X POST \
  -d "{
    \"contents\": [
      {
        \"parts\": [
          {
            \"text\": \"$content\"
          }
        ]
      }
    ]
  }")

# Extract the AI response from the JSON output (assuming the response structure is something like "choices[0].message.content")
echo "$response"
ai_response=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text')

# Display the result in rofi
echo "$ai_response" > /tmp/askai-resp.md
