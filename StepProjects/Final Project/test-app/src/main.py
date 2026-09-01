import http.server
import socketserver
import os
import json

PORT = 8000
POD_IP = os.environ.get("POD_IP", "unknown")

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        body = json.dumps({"code": 200, "pod_ip": POD_IP}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(body)

with socketserver.TCPServer(("0.0.0.0", PORT), Handler) as httpd:
    print(f"http://localhost:{PORT}")
    httpd.serve_forever()
#docker run -p 8000:8000 test-app:latest