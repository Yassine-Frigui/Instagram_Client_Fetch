# Instagram Link Manager

A lightweight React application that uses Google Sheets as a backend to manage and share Instagram links collaboratively.

## Features

- ✅ Add Instagram links with duplicate prevention
- ✅ Real-time list of all shared links
- ✅ Track who added each link and when
- ✅ URL normalization and validation
- ✅ Responsive design for mobile and desktop
- ✅ Serverless architecture using Google Sheets API
- ✅ Ready for Netlify deployment

## Setup Instructions

### 1. Google Sheets Setup

1. Create a new Google Sheet
2. Add headers in the first row: `instagram_url | added_by | date_added`
3. Get your Google Sheets API key from Google Cloud Console
4. Make sure the sheet is publicly readable

### 2. Environment Configuration

The application reads configuration from the `.env` file:

```
api_key=YOUR_GOOGLE_SHEETS_API_KEY
sheets_url=YOUR_GOOGLE_SHEETS_URL
```

### 3. Local Development

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm start
   ```

3. Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

### 4. Deployment on Netlify

1. Build the project:
   ```bash
   npm run build
   ```

2. Deploy the `build` folder to Netlify, or connect your Git repository for automatic deployments.

## How It Works

1. **Data Storage**: Uses Google Sheets as a simple database with columns for Instagram URL, who added it, and the date added.

2. **Duplicate Prevention**: The app normalizes Instagram URLs and checks against existing entries before adding new ones.

3. **Real-time Updates**: Fetches the latest data from Google Sheets and provides a refresh button for manual updates.

4. **URL Validation**: Ensures only valid Instagram URLs are accepted and normalizes them for consistency.

## API Usage

The application uses the Google Sheets API v4 with the following endpoints:

- **GET**: `https://sheets.googleapis.com/v4/spreadsheets/{SPREADSHEET_ID}/values/{RANGE}?key={API_KEY}`
- **POST**: `https://sheets.googleapis.com/v4/spreadsheets/{SPREADSHEET_ID}/values/{RANGE}:append?valueInputOption=RAW&key={API_KEY}`

## File Structure

```
src/
├── App.js          # Main React component
├── App.css         # Styling for the application
├── index.js        # React DOM rendering
└── index.css       # Global styles

public/
└── index.html      # HTML template

netlify.toml        # Netlify deployment configuration
package.json        # Dependencies and scripts
.env               # Environment variables
```

## Technologies Used

- **React 18**: Frontend framework
- **Google Sheets API**: Backend data storage
- **CSS3**: Styling with responsive design
- **Netlify**: Hosting platform

## Browser Support

This application works in all modern browsers that support ES6+ features.
"# client-refresh" 
