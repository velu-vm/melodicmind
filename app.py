import streamlit as st
from melodic import refine_lyrics_with_llm, search_song_on_spotify, search_song_on_youtube

st.set_page_config(page_title="MelodicMind 🎶", layout="centered")
st.title("🎵 MelodicMind AI")
st.write("Paste your lyrics and get song suggestions powered by AI.")

lyrics = st.text_area("🎤 Enter your lyrics or mood:")
language = st.selectbox("🌐 Choose Language:", ["English", "Hindi", "Tamil", "Other"])

if st.button("🔍 Find Songs"):
    if lyrics:
        st.info("Generating song recommendations...")
        result = refine_lyrics_with_llm(lyrics, language)

        st.subheader("🎧 Suggested Songs")
        for song in result.split("\n"):
            st.markdown(f"**{song}**")
            spot = search_song_on_spotify(song)
            yt = search_song_on_youtube(song)
            st.write(f"🔗 [Spotify]({spot}) | 📺 [YouTube]({yt})")
    else:
        st.warning("Please enter some lyrics.")
