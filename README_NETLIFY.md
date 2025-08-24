# Netlify deployment instructions

1. Create a Netlify site (drag & drop or connect repo).
2. In Netlify site settings -> Build & deploy -> Environment, add:
   - GOOGLE_APPS_SCRIPT_URL = your Apps Script exec URL
3. Build command: `npm run build`
   Publish directory: `build`
4. Netlify automatically picks up functions from `netlify/functions`.

API endpoints after deploy:

- GET /.netlify/functions/getLinks
- POST /.netlify/functions/addLink

Local testing with Netlify Dev:

1. Install Netlify CLI: `npm i -g netlify-cli`
2. Run locally: `netlify dev`
3. The functions will be available at `/.netlify/functions/*` while `netlify dev` is running.

Client should call these instead of calling Apps Script directly to avoid CORS issues.
