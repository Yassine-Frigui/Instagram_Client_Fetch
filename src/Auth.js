import React, { useState } from 'react';
import './Auth.css';

const Auth = ({ onLogin }) => {
  const [name, setName] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const allowedNames = process.env.REACT_APP_ALLOWED_NAMES?.toLowerCase().split(',').map(n => n.trim()) || [];

  const handleLogin = () => {
    if (!name.trim()) {
      setError('Please enter your name');
      return;
    }

    const normalizedName = name.trim().toLowerCase();
    
    if (!allowedNames.includes(normalizedName)) {
      setError(`Access denied. `);
      return;
    }

    setLoading(true);
    // Simulate loading for UX
    setTimeout(() => {
      onLogin(name.trim());
      setLoading(false);
    }, 500);
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      handleLogin();
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        <h1>Instagram Link Manager</h1>
        <p>Please authenticate to access the application</p>
        
        <div className="auth-form">
          <input
            type="text"
            placeholder="Enter your name"
            value={name}
            onChange={(e) => {
              setName(e.target.value);
              setError('');
            }}
            onKeyPress={handleKeyPress}
            className="auth-input"
            disabled={loading}
          />
          
          <button 
            onClick={handleLogin}
            disabled={loading || !name.trim()}
            className="auth-button"
          >
            {loading ? 'Authenticating...' : 'Enter'}
          </button>
          
          {error && (
            <div className="auth-error">
              {error}
            </div>
          )}
          
          <div className="auth-info">
            <small>Doesn't matter if you write your name in caps or not 
              Example: "John", "john", "JOHN" are all valid
            </small>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Auth;
