from waitress import serve
import flasky
serve(flasky.app, host='0.0.0.0', port=5000)