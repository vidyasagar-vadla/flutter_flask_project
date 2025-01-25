from flask import Flask, Response
from flask_cors import CORS
import yt_dlp
import requests

app = Flask(__name__)
CORS(app)
@app.route('/')
def home():
    return "Go to Stream"

def get_browser_cookies():
    try:
        # Fetch cookies from Chrome or Firefox dynamically
        cookies = browser_cookie3.load()
        return cookies
    except Exception as e:
        raise RuntimeError(f"Failed to load browser cookies: {str(e)}")
        
@app.route('/stream')    
def stream_video():
    try:
        # Set up yt-dlp options
        cookies = get_browser_cookies()
        ydl_opts = {
            'format': 'best',
            'quiet': True,
            'noplaylist': True,
            'extract_flat': True,  # Extract only the URL without downloading
            'cookiefile': None,
            'cookiefile_content': cookies.output(header='', sep='; ') 
        }

        # Use yt-dlp to fetch the video stream URL
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            video_url = f'https://www.youtube.com/watch?v=LNYm40RmRzs'
            info_dict = ydl.extract_info(video_url, download=False)
            video_url = info_dict['url']  # Get the direct video URL

            # Stream the video content
            response = requests.get(video_url, stream=True)
            return Response(response.iter_content(chunk_size=1024), mimetype='video/mp4')
    except Exception as e:
        return str(e), 404

if __name__ == '__main__':
    app.run(debug=True)
