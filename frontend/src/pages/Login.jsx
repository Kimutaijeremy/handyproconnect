import React, { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { loginStart, loginSuccess, loginFailure } from '../store/slices/authSlice';
import { authAPI } from '../services/api';
import { EnvelopeIcon, LockClosedIcon } from '@heroicons/react/24/outline';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const location = useLocation();
  
  const from = location.state?.from?.pathname || '/dashboard';

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    dispatch(loginStart());
    
    try {
      const response = await authAPI.login(email, password);
      dispatch(loginSuccess({ 
        user: { email, role: 'user' },
        token: response.access_token 
      }));
      
      // Get user profile
      const profile = await authAPI.getProfile();
      dispatch(loginSuccess({ 
        user: profile,
        token: response.access_token 
      }));
      
      navigate(from, { replace: true });
    } catch (err) {
      // Handle all possible error formats
      let errorMessage = 'Login failed';
      
      if (err.response && err.response.data) {
        const errorData = err.response.data;
        
        // Debug: Log the error to see its structure
        console.log('Error response:', errorData);
        
        // Handle Pydantic validation errors (array format)
        if (Array.isArray(errorData)) {
          errorMessage = errorData.map(item => {
            if (typeof item === 'object' && item.msg) {
              return item.msg;
            }
            return JSON.stringify(item);
          }).join(', ');
        }
        // Handle object with detail property
        else if (typeof errorData === 'object' && errorData.detail) {
          errorMessage = errorData.detail;
        }
        // Handle any other object
        else if (typeof errorData === 'object') {
          errorMessage = JSON.stringify(errorData);
        }
        // Handle string
        else {
          errorMessage = String(errorData);
        }
      } else if (err.message) {
        errorMessage = err.message;
      }
      
      setError(errorMessage);
      dispatch(loginFailure(errorMessage));
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-6 py-12">
      <div className="w-full max-w-md">
        <div className="text-center mb-12">
          <h1 className="font-display text-4xl mb-3 text-white">Welcome back</h1>
          <p className="text-white/60">Sign in to your account</p>
        </div>
        
        {error && (
          <div className="mb-6 p-4 rounded-xl bg-red-500/20 border border-red-500/30 text-red-300">
            {error}
          </div>
        )}
        
        <form onSubmit={handleSubmit} className="space-y-8">
          <div>
            <div className="flex items-center gap-3 mb-3">
              <EnvelopeIcon className="h-5 w-5 text-purple-400" />
              <label className="text-sm tracking-widest text-white/70">EMAIL</label>
            </div>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full bg-white/10 border-0 border-b-2 border-white/30 text-white focus:border-purple-500 focus:ring-0 px-0 py-3 text-lg"
              placeholder="hello@example.com"
              required
            />
          </div>
          
          <div>
            <div className="flex items-center gap-3 mb-3">
              <LockClosedIcon className="h-5 w-5 text-purple-400" />
              <label className="text-sm tracking-widest text-white/70">PASSWORD</label>
            </div>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full bg-white/10 border-0 border-b-2 border-white/30 text-white focus:border-purple-500 focus:ring-0 px-0 py-3 text-lg"
              placeholder="••••••••"
              required
            />
          </div>
          
          <button 
            type="submit" 
            className="w-full py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-lg hover:shadow-xl transition-all"
          >
            Sign In
          </button>
        </form>
        
        <div className="mt-10 pt-8 border-t border-white/10 text-center space-y-4">
          <Link to="/register" className="block text-purple-400 hover:text-purple-300">
            Don't have an account? Sign up
          </Link>
          <Link to="/" className="block text-white/60 hover:text-white">
            ← Back to home
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Login;
