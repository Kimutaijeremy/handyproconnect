import React, { useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { authAPI } from '../services/api';
import { UserCircleIcon, EnvelopeIcon, LockClosedIcon, PhoneIcon } from '@heroicons/react/24/outline';

const Register = () => {
  const [searchParams] = useSearchParams();
  const defaultRole = searchParams.get('role') || 'customer';
  
  const [form, setForm] = useState({ 
    email: '', 
    full_name: '', 
    password: '', 
    phone: '',
    role: defaultRole
  });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    
    if (form.password.length < 8) {
      setError('Password must be at least 8 characters');
      return;
    }
    
    try {
      await authAPI.register(form);
      setSuccess(true);
      setTimeout(() => {
        navigate('/login');
      }, 2000);
    } catch (err) {
      // Handle all possible error formats
      let errorMessage = 'Registration failed';
      
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
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-6 py-12">
      <div className="w-full max-w-md">
        <div className="text-center mb-12">
          <h1 className="font-display text-4xl mb-3 text-white">
            Join as {form.role === 'professional' ? 'Professional' : 'Homeowner'}
          </h1>
          <p className="text-white/60">Create your HandyPro Connect account</p>
        </div>
        
        {error && (
          <div className="mb-6 p-4 rounded-xl bg-red-500/20 border border-red-500/30 text-red-300">
            {error}
          </div>
        )}
        
        {success && (
          <div className="mb-6 p-4 rounded-xl bg-green-500/20 border border-green-500/30 text-green-300">
            Account created successfully! Redirecting to login...
          </div>
        )}
        
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="flex gap-4 mb-6">
            <button
              type="button"
              onClick={() => setForm({...form, role: 'customer'})}
              className={`flex-1 py-3 rounded-xl text-center transition-all ${
                form.role === 'customer' 
                  ? 'bg-gradient-to-r from-pink-500 to-purple-600 text-white' 
                  : 'bg-white/10 text-white/60 hover:bg-white/20'
              }`}
            >
              Homeowner
            </button>
            <button
              type="button"
              onClick={() => setForm({...form, role: 'professional'})}
              className={`flex-1 py-3 rounded-xl text-center transition-all ${
                form.role === 'professional' 
                  ? 'bg-gradient-to-r from-pink-500 to-purple-600 text-white' 
                  : 'bg-white/10 text-white/60 hover:bg-white/20'
              }`}
            >
              Professional
            </button>
          </div>
          
          <div>
            <div className="flex items-center gap-3 mb-3">
              <UserCircleIcon className="h-5 w-5 text-purple-400" />
              <label className="text-sm tracking-widest text-white/70">FULL NAME</label>
            </div>
            <input
              type="text"
              value={form.full_name}
              onChange={(e) => setForm({...form, full_name: e.target.value})}
              className="w-full bg-white/10 border-0 border-b-2 border-white/30 text-white focus:border-purple-500 focus:ring-0 px-0 py-3 text-lg"
              placeholder="John Doe"
              required
            />
          </div>
          
          <div>
            <div className="flex items-center gap-3 mb-3">
              <EnvelopeIcon className="h-5 w-5 text-purple-400" />
              <label className="text-sm tracking-widest text-white/70">EMAIL</label>
            </div>
            <input
              type="email"
              value={form.email}
              onChange={(e) => setForm({...form, email: e.target.value})}
              className="w-full bg-white/10 border-0 border-b-2 border-white/30 text-white focus:border-purple-500 focus:ring-0 px-0 py-3 text-lg"
              placeholder="hello@example.com"
              required
            />
          </div>
          
          <div>
            <div className="flex items-center gap-3 mb-3">
              <PhoneIcon className="h-5 w-5 text-purple-400" />
              <label className="text-sm tracking-widest text-white/70">PHONE</label>
            </div>
            <input
              type="tel"
              value={form.phone}
              onChange={(e) => setForm({...form, phone: e.target.value})}
              className="w-full bg-white/10 border-0 border-b-2 border-white/30 text-white focus:border-purple-500 focus:ring-0 px-0 py-3 text-lg"
              placeholder="+1234567890"
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
              value={form.password}
              onChange={(e) => setForm({...form, password: e.target.value})}
              className="w-full bg-white/10 border-0 border-b-2 border-white/30 text-white focus:border-purple-500 focus:ring-0 px-0 py-3 text-lg"
              placeholder="••••••••"
              required
              minLength="8"
            />
            <p className="text-xs text-white/50 mt-2">Must be at least 8 characters</p>
          </div>
          
          <button 
            type="submit" 
            className="w-full py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-lg hover:shadow-xl transition-all"
          >
            Create Account
          </button>
        </form>
        
        <div className="mt-10 pt-8 border-t border-white/10 text-center space-y-4">
          <Link to="/login" className="block text-purple-400 hover:text-purple-300">
            Already have an account? Sign in
          </Link>
          <Link to="/" className="block text-white/60 hover:text-white">
            ← Back to home
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Register;
