#!/bin/bash

echo "Fixing HandyPro Connect frontend..."

# 1. Create missing authSlice
echo "Creating authSlice.js..."
mkdir -p src/store/slices
cat > src/store/slices/authSlice.js << 'AUTHSLICE_EOF'
import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  user: null,
  token: localStorage.getItem('token'),
  isAuthenticated: !!localStorage.getItem('token'),
  loading: false,
  error: null,
};

const authSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {
    loginStart: (state) => {
      state.loading = true;
      state.error = null;
    },
    loginSuccess: (state, action) => {
      state.loading = false;
      state.isAuthenticated = true;
      state.user = action.payload.user;
      state.token = action.payload.token;
      localStorage.setItem('token', action.payload.token);
    },
    loginFailure: (state, action) => {
      state.loading = false;
      state.error = action.payload;
    },
    registerSuccess: (state, action) => {
      state.loading = false;
    },
    logout: (state) => {
      state.user = null;
      state.token = null;
      state.isAuthenticated = false;
      localStorage.removeItem('token');
    },
    setUser: (state, action) => {
      state.user = action.payload;
    },
  },
});

export const { loginStart, loginSuccess, loginFailure, registerSuccess, logout, setUser } = authSlice.actions;
export default authSlice.reducer;
AUTHSLICE_EOF

# 2. Fix store.js
echo "Updating store.js..."
cat > src/store/store.js << 'STORE_EOF'
import { configureStore } from '@reduxjs/toolkit';
import authReducer from './slices/authSlice';

export const store = configureStore({
  reducer: {
    auth: authReducer,
  },
});
STORE_EOF

# 3. Update api.js with proper endpoints
echo "Updating api.js..."
cat > src/services/api.js << 'API_EOF'
import axios from 'axios';

const API_URL = 'http://localhost:8000/api/v1';

const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = \`Bearer \${token}\`;
  }
  return config;
});

api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

export const authAPI = {
  login: async (email, password) => {
    const formData = new FormData();
    formData.append('username', email);
    formData.append('password', password);
    const response = await api.post('/auth/login', formData);
    return response.data;
  },
  register: async (userData) => {
    const response = await api.post('/auth/register', userData);
    return response.data;
  },
  getProfile: async () => {
    const response = await api.get('/auth/me');
    return response.data;
  },
};

export const jobsAPI = {
  getJobs: async () => {
    const response = await api.get('/jobs/');
    return response.data;
  },
  createJob: async (jobData) => {
    const response = await api.post('/jobs/', jobData);
    return response.data;
  },
  getOpenJobs: async () => {
    const response = await api.get('/jobs/open');
    return response.data;
  },
};

export const quotesAPI = {
  getQuotes: async () => {
    const response = await api.get('/quotes/');
    return response.data;
  },
  createQuote: async (jobId, amount, notes) => {
    const response = await api.post(\`/quotes/\${jobId}?amount=\${amount}&notes=\${notes}\`);
    return response.data;
  },
};

export const servicesAPI = {
  getServices: async () => {
    const response = await api.get('/services/');
    return response.data;
  },
};

export default api;
API_EOF

# 4. Check if App.jsx needs Redux Provider
echo "Checking App.jsx..."
if ! grep -q "Provider" src/App.jsx; then
  echo "App.jsx might need Redux Provider wrapper. Creating backup and updating..."
  cp src/App.jsx src/App.jsx.backup
  echo "Please ensure App.jsx wraps content with <Provider store={store}>"
fi

# 5. Check index.js for Redux setup
echo "Checking index.js..."
if ! grep -q "Provider" src/index.js; then
  echo "Updating index.js to include Redux Provider..."
  cat > src/index.js << 'INDEX_EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import { Provider } from 'react-redux';
import { store } from './store/store';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>
);
INDEX_EOF
fi

# 6. Fix any import issues in existing components
echo "Checking component imports..."

# Fix ProtectedRoute.jsx if needed
if grep -q "useSelector" src/components/ProtectedRoute.jsx; then
  echo "ProtectedRoute.jsx already uses Redux - good!"
else
  echo "Updating ProtectedRoute.jsx..."
  cat > src/components/ProtectedRoute.jsx << 'PROTECTED_EOF'
import React from 'react';
import { Navigate } from 'react-router-dom';
import { useSelector } from 'react-redux';

const ProtectedRoute = ({ children, requireProfessional = false }) => {
  const { isAuthenticated, user } = useSelector((state) => state.auth);
  
  if (!isAuthenticated) {
    return <Navigate to="/login" />;
  }
  
  if (requireProfessional && user?.role !== 'professional') {
    return <Navigate to="/dashboard" />;
  }
  
  return children;
};

export default ProtectedRoute;
PROTECTED_EOF
fi

echo "Done! Files updated:"
echo "1. src/store/slices/authSlice.js (created)"
echo "2. src/store/store.js (updated)"
echo "3. src/services/api.js (updated)"
echo "4. src/index.js (updated if needed)"
echo "5. src/components/ProtectedRoute.jsx (checked)"

echo ""
echo "Next steps:"
echo "1. Run: chmod +x fix_all_issues.sh"
echo "2. Run: ./fix_all_issues.sh"
echo "3. Start your app: npm start"
