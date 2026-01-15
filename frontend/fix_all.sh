#!/bin/bash
echo "=== Creating missing files ==="

# 1. Create store directory and files
mkdir -p src/store/slices
mkdir -p src/services

# 2. Create store files
cat > src/store/store.ts << 'STOREEOF'
import { configureStore } from '@reduxjs/toolkit';
import authReducer from './slices/authSlice';

export const store = configureStore({
  reducer: {
    auth: authReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
STOREEOF

# 3. Create auth slice
cat > src/store/slices/authSlice.ts << 'AUTHEOF'
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface User {
  email: string;
  role: string;
}

interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
}

const initialState: AuthState = {
  user: null,
  token: localStorage.getItem('token'),
  isAuthenticated: !!localStorage.getItem('token'),
};

const authSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {
    setCredentials: (state, action: PayloadAction<{ user: User; token: string }>) => {
      state.user = action.payload.user;
      state.token = action.payload.token;
      state.isAuthenticated = true;
      localStorage.setItem('token', action.payload.token);
    },
    logout: (state) => {
      state.user = null;
      state.token = null;
      state.isAuthenticated = false;
      localStorage.removeItem('token');
    },
  },
});

export const { setCredentials, logout } = authSlice.actions;
export default authSlice.reducer;
AUTHEOF

# 4. Create API service
cat > src/services/api.ts << 'APIEOF'
import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:8000/api/v1',
  headers: {
    'Content-Type': 'application/json',
  },
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

export default api;
APIEOF

# 5. Fix page modules by adding exports
for page in Services ForgotPassword MyJobs ProProfile Quotes Reviews Calendar; do
  cat > src/pages/${page}.tsx << PAGEEOF
import React from 'react';

const ${page} = () => (
  <div className="max-w-7xl mx-auto px-4 py-8">
    <h1 className="text-3xl font-bold mb-6">${page.replace(/([A-Z])/g, ' $1').trim()}</h1>
    <div className="card">
      <p>${page} page content will be implemented here.</p>
    </div>
  </div>
);

export default ${page};
PAGEEOF
done

# 6. Create types directory
mkdir -p src/types
cat > src/types/index.ts << 'TYPEEOF'
// Type definitions will go here
export interface Job {
  id: number;
  title: string;
  description: string;
  location: string;
  status: string;
}
TYPEEOF

echo "✅ All missing files created!"
echo "🚀 Restart with: npm start"
