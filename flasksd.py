from flask import Flask, Response, jsonify, request  # Ensure request is imported
from flask_cors import CORS
import yt_dlp
import requests

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return "Go to /stream to stream a video or /check to check the video status."

def check_video_status(url):
    options = {
        'quiet': True,
        'noplaylist': True,
    }

    try:
        with yt_dlp.YoutubeDL(options) as ydl:
            info = ydl.extract_info(url, download=False)
            if info.get('is_private'):
                return {"status": "private", "message": "The video is private."}
            elif info.get('age_limit') and info['age_limit'] > 0:
                return {"status": "age_restricted", "message": f"Age limit: {info['age_limit']}+"}
            elif info.get('availability') == 'unlisted':
                return {"status": "unlisted", "message": "The video is unlisted."}
            else:
                return {"status": "public", "message": "The video is public."}
    except yt_dlp.utils.DownloadError as e:
        return {"status": "error", "message": str(e)}

@app.route('/check', methods=['GET'])
def check():
    url = request.args.get('url')  # Request object is now imported
    if not url:
        return jsonify({"status": "error", "message": "Missing 'url' parameter"}), 400

    result = check_video_status(url)
    return jsonify(result)
    
@app.route('/stream', methods=['GET'])
def stream_video():
    try:
        # Set the hardcoded video URL here
        video_url = 'https://www.youtube.com/watch?v=LNYm40RmRzs'  # Example YouTube URL

        # Set up yt-dlp options
        ydl_opts = {
            'format': 'best',
            'quiet': True,
            'noplaylist': True,
            'extract_flat': True,  # Extract only the URL without downloading
        }

        # Use yt-dlp to fetch the video stream URL
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info_dict = ydl.extract_info(video_url, download=False)
            video_url = info_dict['url']  # Get the direct video URL

            # Stream the video content
            response = requests.get(video_url, stream=True)
            return Response(response.iter_content(chunk_size=1024), mimetype='video/mp4')
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 404

if __name__ == '__main__':
    app.run(debug=True)
