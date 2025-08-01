import openai
import urllib.parse
import os

def refine_lyrics_with_llm(prompt):
    openai.api_key = os.getenv("OPENAI_API_KEY")
    
    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {
                    "role": "system",
                    "content": "You're a helpful assistant that transforms raw song ideas into polished lyrical themes."
                },
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            temperature=0.7,
            max_tokens=150
        )
        return response['choices'][0]['message']['content'].strip()
    except Exception as e:
        return f"Error from OpenAI: {str(e)}"

def search_song_on_spotify(query):
    base_url = "https://open.spotify.com/search/"
    encoded_query = urllib.parse.quote(query)
    return f"{base_url}{encoded_query}"

def search_song_on_youtube(query):
    base_url = "https://www.youtube.com/results?search_query="
    encoded_query = urllib.parse.quote(query)
    return f"{base_url}{encoded_query}"
