from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess
import tempfile

app = Flask(__name__)
CORS(app)   # ✅ VERY IMPORTANT

@app.route('/run', methods=['POST'])
def run_code():
    try:
        data = request.get_json()

        user_code = data.get("code", "")
        test_input = data.get("input", "")

        # Inject array
        full_code = f"""
arr = {test_input}

{user_code}
"""

        with tempfile.NamedTemporaryFile(delete=False, suffix=".py") as f:
            f.write(full_code.encode())
            file_name = f.name

        result = subprocess.run(
            ["python", file_name],
            capture_output=True,
            text=True,
            timeout=5
        )

        return jsonify({
            "output": result.stdout.strip(),
            "error": result.stderr.strip()
        })

    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)