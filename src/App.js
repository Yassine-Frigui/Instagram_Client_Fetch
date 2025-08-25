import React, { useState, useEffect, useCallback } from 'react';
import './App.css';
import Auth from './Auth';

const App = () => {
  const [links, setLinks] = useState([]);
  const [inputUrl, setInputUrl] = useState('');
  const [bulkUrls, setBulkUrls] = useState('');
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [user, setUser] = useState(null);
  const [bulkMode, setBulkMode] = useState(false);
  const [bulkProgress, setBulkProgress] = useState({ current: 0, total: 0 });

  // Extract spreadsheet ID from environment variables
  const SPREADSHEET_ID = process.env.REACT_APP_SPREADSHEET_ID || '1eH3JlZBnmysQ0iGKwso4jir002s8E-ZvJmnim9p_ZKo';
  const API_KEY = process.env.REACT_APP_GOOGLE_API_KEY || 'AIzaSyA2NCwQONP2ceQyl-suUve-U44gkE2Tvtk';
  const GOOGLE_APPS_SCRIPT_URL = process.env.REACT_APP_GOOGLE_APPS_SCRIPT_URL;
  const SHEET_NAME = 'Sheet1';
  const RANGE = `${SHEET_NAME}!A:C`;

  // Check for existing auth on mount
  useEffect(() => {
    const savedUser = localStorage.getItem('instagram-manager-user');
    if (savedUser) {
      setUser(savedUser);
    }
  }, []);

  // Handle login
  const handleLogin = (name) => {
    setUser(name);
    localStorage.setItem('instagram-manager-user', name);
  };

  // Handle logout
  const handleLogout = () => {
    setUser(null);
    localStorage.removeItem('instagram-manager-user');
  };


  // Normalize Instagram URL
  const normalizeInstagramUrl = (url) => {
    if (!url) return '';
    
    // Remove trailing slashes and normalize
    let normalized = url.trim().toLowerCase();
    
    // Add https if missing
    if (!normalized.startsWith('http')) {
      normalized = 'https://' + normalized;
    }
    
    // Ensure it's an Instagram URL
    if (!normalized.includes('instagram.com')) {
      return null;
    }
    
    // Remove query parameters and fragments
    try {
      const urlObj = new URL(normalized);
      return `https://instagram.com${urlObj.pathname}`.replace(/\/$/, '');
    } catch (e) {
      return null;
    }
  };

  // Fetch existing links from Google Sheets
  const fetchLinks = useCallback(async () => {
    try {
      setLoading(true);
      
      // Try Google Apps Script first if URL is provided
      if (GOOGLE_APPS_SCRIPT_URL) {
        try {
          const response = await fetch(GOOGLE_APPS_SCRIPT_URL);
          const result = await response.json();
          
          if (result.success) {
            setLinks(result.data.map((item, index) => ({
              id: index,
              instagram_url: item.instagram_url || '',
              added_by: item.added_by || '',
              date_added: item.date_added || ''
            })));
            return;
          }
        } catch (error) {
          console.log('Google Apps Script failed, trying direct API...');
        }
      }
      
      // Fallback to direct Google Sheets API
      const response = await fetch(
        `https://sheets.googleapis.com/v4/spreadsheets/${SPREADSHEET_ID}/values/${RANGE}?key=${API_KEY}`
      );
      
      if (!response.ok) {
        throw new Error('Failed to fetch data from Google Sheets');
      }
      
      const data = await response.json();
      const rows = data.values || [];
      
      // Skip header row and format data
      const formattedLinks = rows.slice(1).map((row, index) => ({
        id: index,
        instagram_url: row[0] || '',
        added_by: row[1] || '',
        date_added: row[2] || ''
      }));
      
      setLinks(formattedLinks);
    } catch (error) {
      console.error('Error fetching links:', error);
      setMessage('Error loading links. Please try again.');
    } finally {
      setLoading(false);
    }
  }, [GOOGLE_APPS_SCRIPT_URL, SPREADSHEET_ID, API_KEY, RANGE]);

  // Add new link to Google Sheets
  const addLink = async () => {
    if (!inputUrl.trim()) {
      setMessage('Please enter an Instagram URL.');
      return;
    }

    const normalizedUrl = normalizeInstagramUrl(inputUrl);
    if (!normalizedUrl) {
      setMessage('Please enter a valid Instagram URL.');
      return;
    }

    // Check for duplicates
    const isDuplicate = links.some(link => 
      normalizeInstagramUrl(link.instagram_url) === normalizedUrl
    );

    if (isDuplicate) {
      setMessage('This Instagram link has already been added.');
      return;
    }

    await addSingleLink(normalizedUrl, user);
  };

  // Add bulk links
  const addBulkLinks = async () => {
    if (!bulkUrls.trim()) {
      setMessage('Please enter Instagram URLs (one per line).');
      return;
    }

    const urls = bulkUrls.split('\n')
      .map(url => url.trim())
      .filter(url => url.length > 0)
      .map(url => normalizeInstagramUrl(url))
      .filter(url => url !== null);

    if (urls.length === 0) {
      setMessage('No valid Instagram URLs found.');
      return;
    }

    // Filter out duplicates
    const newUrls = urls.filter(url => 
      !links.some(link => normalizeInstagramUrl(link.instagram_url) === url)
    );

    if (newUrls.length === 0) {
      setMessage('All URLs have already been added.');
      return;
    }

    setLoading(true);
    setBulkProgress({ current: 0, total: newUrls.length });
    
    let successCount = 0;
    let failCount = 0;

    for (let i = 0; i < newUrls.length; i++) {
      setBulkProgress({ current: i + 1, total: newUrls.length });
      
      try {
        await addSingleLink(newUrls[i], user, false); // Don't refresh after each
        successCount++;
        // Small delay to prevent overwhelming the API
        await new Promise(resolve => setTimeout(resolve, 200));
      } catch (error) {
        failCount++;
        console.error(`Failed to add ${newUrls[i]}:`, error);
      }
    }

    setBulkProgress({ current: 0, total: 0 });
    setLoading(false);
    setBulkUrls('');
    
    if (successCount > 0) {
      await fetchLinks(); // Refresh the list once at the end
    }
    
    setMessage(`Bulk add complete: ${successCount} added, ${failCount} failed.`);
  };

  // Helper function to add a single link
  const addSingleLink = async (normalizedUrl, addedBy, shouldRefresh = true) => {
    if (!GOOGLE_APPS_SCRIPT_URL) {
      throw new Error('Google Apps Script URL not configured.');
    }

    try {
      if (shouldRefresh) setLoading(true);
      
      const currentDate = new Date().toLocaleDateString();

      // Use GET request with URL parameters to bypass CORS completely
      const params = new URLSearchParams({
        action: 'add',
        instagram_url: normalizedUrl,
        added_by: addedBy,
        date_added: currentDate
      });

      const response = await fetch(`${GOOGLE_APPS_SCRIPT_URL}?${params.toString()}`);
      
      if (!response.ok) {
        throw new Error('Failed to add link');
      }

      const result = await response.json();
      
      if (result.success) {
        if (shouldRefresh) {
          setMessage('Link added successfully!');
          setInputUrl('');
          await fetchLinks(); // Refresh the list
        }
      } else {
        throw new Error(result.error || 'Failed to add link');
      }
    } finally {
      if (shouldRefresh) setLoading(false);
    }
  };

  useEffect(() => {
    if (user) {
      fetchLinks();
    }
  }, [user, fetchLinks]);

  // Clear message after 5 seconds
  useEffect(() => {
    if (message) {
      const timer = setTimeout(() => setMessage(''), 5000);
      return () => clearTimeout(timer);
    }
  }, [message]);

  // Show auth page if not logged in
  if (!user) {
    return <Auth onLogin={handleLogin} />;
  }

  return (
    <div className="app">
      <header className="app-header">
        <div className="header-content">
          <div>
            <h1>Instagram Link Manager</h1>
            <p>Share and organize Instagram links with your team</p>
          </div>
          <div className="user-info">
            <button onClick={handleLogout} className="logout-button">Logout</button>
          </div>
        </div>
      </header>

      <main className="app-main">
        <div className="add-link-section">
          <div className="mode-toggle">
            <button 
              onClick={() => setBulkMode(false)}
              className={`mode-button ${!bulkMode ? 'active' : ''}`}
            >
              Single Link
            </button>
            <button 
              onClick={() => setBulkMode(true)}
              className={`mode-button ${bulkMode ? 'active' : ''}`}
            >
              Bulk Add
            </button>
          </div>

          {!bulkMode ? (
            <div className="single-mode">
              <h2>Add Single Instagram Link</h2>
              <div className="input-group">
                <input
                  type="text"
                  placeholder="Enter Instagram URL"
                  value={inputUrl}
                  onChange={(e) => setInputUrl(e.target.value)}
                  className="url-input"
                  onKeyPress={(e) => e.key === 'Enter' && addLink()}
                />
                <button 
                  onClick={addLink} 
                  disabled={loading}
                  className="add-button"
                >
                  {loading ? 'Adding...' : 'Add Link'}
                </button>
              </div>
            </div>
          ) : (
            <div className="bulk-mode">
              <h2>Add Multiple Instagram Links</h2>
              <div className="bulk-input-group">
                <textarea
                  placeholder="Enter Instagram URLs (one per line)&#10;&#10;Example:&#10;https://instagram.com/user1&#10;https://instagram.com/user2&#10;instagram.com/user3"
                  value={bulkUrls}
                  onChange={(e) => setBulkUrls(e.target.value)}
                  className="bulk-textarea"
                  rows="6"
                />
                <button 
                  onClick={addBulkLinks} 
                  disabled={loading}
                  className="add-button bulk-add-button"
                >
                  {loading ? `Adding... (${bulkProgress.current}/${bulkProgress.total})` : 'Add All Links'}
                </button>
              </div>
              
              {loading && bulkProgress.total > 0 && (
                <div className="bulk-progress">
                  <div className="progress-bar">
                    <div 
                      className="progress-fill" 
                      style={{ width: `${(bulkProgress.current / bulkProgress.total) * 100}%` }}
                    ></div>
                  </div>
                  <span className="progress-text">
                    Processing {bulkProgress.current} of {bulkProgress.total} links...
                  </span>
                </div>
              )}
            </div>
          )}

          {message && (
            <div className={`message ${message.includes('Error') || message.includes('failed') ? 'error' : 'success'}`}>
              {message}
            </div>
          )}
        </div>

        <div className="links-section">
          <h2>Shared Instagram Links ({links.length})</h2>
          {loading && links.length === 0 ? (
            <div className="loading">Loading links...</div>
          ) : links.length === 0 ? (
            <div className="empty-state">
              No Instagram links have been added yet. Be the first to add one!
            </div>
          ) : (
            <div className="links-grid">
              {links.map((link) => (
                <div key={link.id} className="link-card">
                  <div className="link-url">
                    <a 
                      href={link.instagram_url} 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="instagram-link"
                    >
                      {link.instagram_url}
                    </a>
                  </div>
                  <div className="link-meta">
                    <span className="added-by">Added by: {link.added_by}</span>
                    <span className="date-added">Date: {link.date_added}</span>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="refresh-section">
          <button 
            onClick={fetchLinks} 
            disabled={loading}
            className="refresh-button"
          >
            {loading ? 'Refreshing...' : 'Refresh List'}
          </button>
        </div>
      </main>

      <footer className="app-footer">
        <p>Powered by Google Sheets API | Built with React</p>
      </footer>
    </div>
  );
};

export default App;
