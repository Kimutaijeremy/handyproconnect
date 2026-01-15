#!/bin/bash
echo "=== FIXING REGISTER PAGE ==="

cat > src/pages/Register.tsx << 'REGISTEREOF'
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import api from '../services/api';
import { 
  UserCircleIcon, 
  EnvelopeIcon, 
  LockClosedIcon, 
  PhoneIcon,
  ArrowRightIcon,
  SparklesIcon
} from '@heroicons/react/24/outline';

const Register = () => {
  const [form, setForm] = useState({ 
    email: '', 
    full_name: '', 
    password: '', 
    phone: '', 
    role: 'customer' 
  });
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await api.post('/auth/register', form);
      navigate('/login');
    } catch (error) {
      console.error('Registration failed:', error);
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-6 py-12 relative overflow-hidden">
      {/* Background */}
      <div className="absolute inset-0 z-0">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-gradient-to-r from-coral/20 to-pink-500/20 rounded-full blur-3xl"></div>
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-gradient-to-r from-mint/20 to-cyan-500/20 rounded-full blur-3xl"></div>
      </div>

      <div className="relative z-10 w-full max-w-md">
        {/* Header */}
        <div className="text-center mb-12">
          <div className="inline-flex p-3 rounded-2xl bg-white/10 border border-white/20 mb-6">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-coral to-mint flex items-center justify-center">
              <UserCircleIcon className="h-6 w-6 text-white" />
            </div>
          </div>
          <div className="inline-flex items-center gap-2 mb-4 px-4 py-2 rounded-full bg-white/5">
            <SparklesIcon className="h-4 w-4 text-mint" />
            <span className="font-accent text-xs tracking-widest text-mint">JOIN OUR COMMUNITY</span>
          </div>
          <h1 className="font-display text-4xl mb-3">Create your account</h1>
          <p className="text-white/60">Start your home repair journey today</p>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-8">
          <div className="space-y-6">
            {/* Email */}
            <div>
              <div className="flex items-center gap-3 mb-3">
                <EnvelopeIcon className="h-5 w-5 text-mint" />
                <label className="font-medium text-sm tracking-widest text-white/70">EMAIL</label>
              </div>
              <input
                type="email"
                value={form.email}
                onChange={(e) => setForm({...form, email: e.target.value})}
                className="minimal-input w-full"
                placeholder="hello@example.com"
                required
              />
            </div>
            
            {/* Full Name */}
            <div>
              <div className="flex items-center gap-3 mb-3">
                <UserCircleIcon className="h-5 w-5 text-mint" />
                <label className="font-medium text-sm tracking-widest text-white/70">FULL NAME</label>
              </div>
              <input
                type="text"
                value={form.full_name}
                onChange={(e) => setForm({...form, full_name: e.target.value})}
                className="minimal-input w-full"
                placeholder="John Smith"
                required
              />
            </div>
            
            {/* Password */}
            <div>
              <div className="flex items-center gap-3 mb-3">
                <LockClosedIcon className="h-5 w-5 text-mint" />
                <label className="font-medium text-sm tracking-widest text-white/70">PASSWORD</label>
              </div>
              <input
                type="password"
                value={form.password}
                onChange={(e) => setForm({...form, password: e.target.value})}
                className="minimal-input w-full"
                placeholder="••••••••"
                required
              />
              <p className="text-xs text-white/40 mt-2">Minimum 8 characters</p>
            </div>
            
            {/* Phone */}
            <div>
              <div className="flex items-center gap-3 mb-3">
                <PhoneIcon className="h-5 w-5 text-mint" />
                <label className="font-medium text-sm tracking-widest text-white/70">PHONE (OPTIONAL)</label>
              </div>
              <input
                type="tel"
                value={form.phone}
                onChange={(e) => setForm({...form, phone: e.target.value})}
                className="minimal-input w-full"
                placeholder="+254 700 000 000"
              />
            </div>
            
            {/* Role Selection */}
            <div>
              <label className="block font-medium text-sm mb-3 text-white/70">I AM A</label>
              <div className="flex gap-4">
                <button
                  type="button"
                  onClick={() => setForm({...form, role: 'customer'})}
                  className={`flex-1 py-3 rounded-xl text-center transition-all ${
                    form.role === 'customer' 
                      ? 'bg-gradient-to-r from-coral to-mint text-white shadow-lg' 
                      : 'bg-white/5 text-white/60 hover:bg-white/10'
                  }`}
                >
                  Homeowner
                </button>
                <button
                  type="button"
                  onClick={() => setForm({...form, role: 'professional'})}
                  className={`flex-1 py-3 rounded-xl text-center transition-all ${
                    form.role === 'professional' 
                      ? 'bg-gradient-to-r from-coral to-mint text-white shadow-lg' 
                      : 'bg-white/5 text-white/60 hover:bg-white/10'
                  }`}
                >
                  Professional
                </button>
              </div>
            </div>
          </div>

          {/* Submit Button */}
          <button 
            type="submit" 
            disabled={loading}
            className="btn-playful w-full group"
          >
            {loading ? (
              <span>Creating account...</span>
            ) : (
              <span className="flex items-center justify-center gap-2">
                Create Account
                <ArrowRightIcon className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
              </span>
            )}
          </button>
        </form>

        {/* Links */}
        <div className="mt-10 pt-8 border-t border-white/10 text-center space-y-4">
          <p className="text-white/50">
            Already have an account?{' '}
            <Link to="/login" className="text-link font-medium">
              Sign in here
            </Link>
          </p>
          <p className="text-xs text-white/30">
            By creating an account, you agree to our Terms and Privacy Policy
          </p>
          <Link to="/" className="btn-ghost !px-4 !py-2 text-sm inline-block">
            ← Back to home
          </Link>
        </div>

        {/* Benefits */}
        <div className="mt-12 glass-card p-6">
          <h4 className="font-display text-lg mb-4">Why join HandyPro?</h4>
          <ul className="space-y-3 text-sm">
            <li className="flex items-center">
              <div className="w-2 h-2 rounded-full bg-mint mr-3"></div>
              Instant quotes from verified pros
            </li>
            <li className="flex items-center">
              <div className="w-2 h-2 rounded-full bg-mint mr-3"></div>
              Secure payments with escrow protection
            </li>
            <li className="flex items-center">
              <div className="w-2 h-2 rounded-full bg-mint mr-3"></div>
              Green certified eco-friendly options
            </li>
            <li className="flex items-center">
              <div className="w-2 h-2 rounded-full bg-mint mr-3"></div>
              24/7 customer support
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default Register;
REGISTEREOF

echo "✅ Register page fixed!"
echo "🚀 App is now complete with all pages designed"
