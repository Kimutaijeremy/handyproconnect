#!/bin/bash
echo "=== APPLYING PREMIUM PLAYFUL DESIGN ==="

# 1. Update Tailwind config with premium color palette and fonts
cat > tailwind.config.js << 'TAILWINDEOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
    "./public/index.html"
  ],
  theme: {
    extend: {
      colors: {
        // Premium Color Palette
        slate: {
          dark: '#0f172a',
          DEFAULT: '#1e293b',
          light: '#334155',
        },
        coral: {
          DEFAULT: '#ff6b6b',
          light: '#ff8e8e',
          dark: '#e05555',
        },
        mint: {
          DEFAULT: '#4ecdc4',
          light: '#7dd8d1',
          dark: '#3db4ac',
        },
        cream: '#f8f9fa',
      },
      fontFamily: {
        'display': ['"Playfair Display"', 'serif'],
        'body': ['"Inter"', 'sans-serif'],
        'accent': ['"Space Grotesk"', 'monospace'],
      },
      backgroundImage: {
        'hero-tools': "url('https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80')",
        'services-bg': "url('https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80')",
        'dashboard-bg': "url('https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80')",
        'auth-bg': "url('https://images.unsplash.com/photo-1581094794329-c8112a89af12?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80')",
        'tool-pattern': "url('data:image/svg+xml,%3Csvg width=\"60\" height=\"60\" xmlns=\"http://www.w3.org/2000/svg\"%3E%3Cg fill=\"none\" fill-rule=\"evenodd\"%3E%3Cg fill=\"%23ff6b6b\" fill-opacity=\"0.05\"%3E%3Cpath d=\"M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z\"/%3E%3C/g%3E%3C/g%3E%3C/svg%3E')",
      },
      animation: {
        'float': 'float 6s ease-in-out infinite',
        'pulse-gentle': 'pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'slide-in': 'slideIn 0.3s ease-out',
      },
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-10px)' },
        },
        slideIn: {
          '0%': { transform: 'translateX(-10px)', opacity: '0' },
          '100%': { transform: 'translateX(0)', opacity: '1' },
        }
      }
    },
  },
  plugins: [],
}
TAILWINDEOF

# 2. Update index.css with premium styles
cat > src/index.css << 'CSSEOF'
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&family=Space+Grotesk:wght@300;400;500&display=swap');

@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  html {
    scroll-behavior: smooth;
  }
  
  body {
    @apply bg-slate-dark text-cream font-body;
    background-image: url('data:image/svg+xml,%3Csvg width="60" height="60" xmlns="http://www.w3.org/2000/svg"%3E%3Cg fill="none" fill-rule="evenodd"%3E%3Cg fill="%23ff6b6b" fill-opacity="0.05"%3E%3Cpath d="M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z"/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');
  }
  
  ::selection {
    @apply bg-coral text-white;
  }
}

@layer components {
  /* Premium Text Links (No Boxes) */
  .text-link {
    @apply relative inline-block text-cream hover:text-mint transition-colors duration-300;
  }
  
  .text-link::after {
    content: '';
    @apply absolute left-0 -bottom-1 w-0 h-0.5 bg-mint transition-all duration-300;
  }
  
  .text-link:hover::after {
    @apply w-full;
  }
  
  /* Elegant Cards */
  .glass-card {
    @apply bg-white/5 backdrop-blur-sm border border-white/10 rounded-2xl;
  }
  
  .hover-lift {
    @apply transition-all duration-300 hover:-translate-y-1 hover:shadow-2xl;
  }
  
  /* Minimal Inputs */
  .minimal-input {
    @apply bg-transparent border-0 border-b-2 border-white/20 text-cream placeholder-white/40 
           focus:outline-none focus:border-mint focus:ring-0 transition-colors duration-300
           px-0 py-3 text-lg;
  }
  
  /* Playful Buttons */
  .btn-playful {
    @apply relative overflow-hidden bg-gradient-to-r from-coral to-mint text-white 
           font-accent tracking-wider px-8 py-4 rounded-full
           hover:shadow-2xl hover:scale-105 transition-all duration-300
           before:absolute before:inset-0 before:bg-white/10 before:translate-x-full
           hover:before:translate-x-0 before:transition-transform before:duration-700;
  }
  
  .btn-ghost {
    @apply text-cream hover:text-mint border-2 border-transparent 
           hover:border-mint/30 px-6 py-3 rounded-full
           transition-all duration-300 font-accent tracking-wide;
  }
  
  /* Section Titles */
  .section-title {
    @apply font-display text-4xl md:text-5xl mb-6 relative inline-block;
  }
  
  .section-title::before {
    content: '';
    @apply absolute -bottom-2 left-0 w-12 h-1 bg-gradient-to-r from-coral to-mint rounded-full;
  }
}

/* Custom Scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  @apply bg-slate-dark;
}

::-webkit-scrollbar-thumb {
  @apply bg-coral/30 rounded-full hover:bg-coral/50 transition-colors;
}
CSSEOF

# 3. Create a modern Home page with playful design
cat > src/pages/Home.tsx << 'HOMEEOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { 
  SparklesIcon, 
  ArrowRightIcon, 
  WrenchScrewdriverIcon,
  BoltIcon,
  HomeIcon 
} from '@heroicons/react/24/outline';

const Home = () => {
  const features = [
    {
      icon: <BoltIcon className="h-8 w-8" />,
      title: 'Instant Quotes',
      desc: 'Real-time quotes from available pros',
      color: 'from-coral to-coral-light'
    },
    {
      icon: <WrenchScrewdriverIcon className="h-8 w-8" />,
      title: 'Verified Pros',
      desc: 'Background-checked professionals',
      color: 'from-mint to-mint-light'
    },
    {
      icon: <HomeIcon className="h-8 w-8" />,
      title: 'Eco Solutions',
      desc: 'Green-certified sustainable options',
      color: 'from-coral to-mint'
    }
  ];

  return (
    <div className="min-h-screen relative overflow-hidden">
      {/* Animated Background Elements */}
      <div className="absolute inset-0 z-0">
        <div className="absolute top-20 left-10 w-72 h-72 bg-coral/5 rounded-full blur-3xl animate-pulse-gentle"></div>
        <div className="absolute bottom-20 right-10 w-96 h-96 bg-mint/5 rounded-full blur-3xl animate-pulse-gentle animation-delay-2000"></div>
      </div>
      
      {/* Hero Section */}
      <div className="relative z-10 max-w-7xl mx-auto px-6 pt-24 pb-20">
        <div className="text-center mb-16 animate-slide-in">
          <div className="inline-flex items-center gap-2 mb-6 px-4 py-2 rounded-full bg-white/5 border border-white/10">
            <SparklesIcon className="h-5 w-5 text-mint" />
            <span className="font-accent text-sm tracking-widest text-mint">TRUSTED BY 10,000+ HOMES</span>
          </div>
          
          <h1 className="font-display text-6xl md:text-8xl mb-6 leading-tight">
            <span className="block">Home repairs</span>
            <span className="block">
              made <span className="bg-gradient-to-r from-coral to-mint bg-clip-text text-transparent">magical</span>
            </span>
          </h1>
          
          <p className="text-xl text-white/70 mb-10 max-w-2xl mx-auto">
            Connect with top-rated professionals for all your home needs. 
            Simple, fast, and completely stress-free.
          </p>
          
          {/* Playful Search */}
          <div className="max-w-2xl mx-auto mb-16">
            <div className="flex flex-col md:flex-row gap-4 items-center">
              <input 
                type="text" 
                placeholder="What needs fixing today?" 
                className="minimal-input flex-1 text-center md:text-left"
              />
              <button className="btn-playful group">
                <span className="flex items-center gap-2">
                  Find Help
                  <ArrowRightIcon className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
                </span>
              </button>
            </div>
            <div className="flex flex-wrap justify-center gap-4 mt-6">
              {['leaky pipe', 'broken light', 'painting', 'furniture assembly'].map((tag) => (
                <span 
                  key={tag}
                  className="text-sm px-4 py-2 rounded-full bg-white/5 hover:bg-white/10 transition-colors cursor-pointer"
                >
                  {tag}
                </span>
              ))}
            </div>
          </div>
        </div>

        {/* Features Grid with Playful Layout */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-24">
          {features.map((feature, index) => (
            <div 
              key={index}
              className="glass-card p-8 hover-lift group animate-float"
              style={{ animationDelay: `${index * 1}s` }}
            >
              <div className={`inline-flex p-4 rounded-2xl bg-gradient-to-br ${feature.color} mb-6 group-hover:scale-110 transition-transform`}>
                <div className="text-white">{feature.icon}</div>
              </div>
              <h3 className="text-2xl font-display mb-3">{feature.title}</h3>
              <p className="text-white/60 mb-6">{feature.desc}</p>
              <Link to="/services" className="text-link group-hover:text-mint">
                Explore →
              </Link>
            </div>
          ))}
        </div>

        {/* How It Works - Playful Timeline */}
        <div className="mb-24">
          <h2 className="section-title text-center">How it works</h2>
          <div className="flex flex-col md:flex-row justify-center items-start gap-12 md:gap-0">
            {[
              { step: '01', title: 'Describe', desc: 'Tell us what you need' },
              { step: '02', title: 'Match', desc: 'We find perfect pros' },
              { step: '03', title: 'Relax', desc: 'Job gets done magically' },
              { step: '04', title: 'Enjoy', desc: 'Love your fixed space' }
            ].map((item, index) => (
              <div key={index} className="flex flex-col items-center text-center md:w-48 relative">
                <div className="w-16 h-16 rounded-full bg-gradient-to-br from-coral to-mint flex items-center justify-center text-2xl font-accent mb-4">
                  {item.step}
                </div>
                <h4 className="text-xl font-display mb-2">{item.title}</h4>
                <p className="text-white/60">{item.desc}</p>
                {index < 3 && (
                  <div className="hidden md:block absolute top-8 left-full w-24 h-0.5 bg-gradient-to-r from-mint to-coral"></div>
                )}
              </div>
            ))}
          </div>
        </div>

        {/* CTA Section */}
        <div className="glass-card p-12 text-center">
          <h2 className="text-4xl font-display mb-6">Ready to transform your home?</h2>
          <p className="text-xl text-white/70 mb-8 max-w-2xl mx-auto">
            Join thousands of happy homeowners who trust HandyPro Connect
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/register" className="btn-playful">
              Get Started Free
            </Link>
            <Link to="/services" className="btn-ghost">
              Browse Services
            </Link>
          </div>
        </div>
      </div>

      {/* Floating Tool Silhouettes */}
      <div className="fixed bottom-0 left-0 right-0 h-20 pointer-events-none">
        {[20, 40, 60, 80].map((pos) => (
          <div 
            key={pos}
            className="absolute bottom-0 text-white/10 animate-float"
            style={{ left: `${pos}%`, animationDelay: `${pos/10}s` }}
          >
            <WrenchScrewdriverIcon className="h-12 w-12" />
          </div>
        ))}
      </div>
    </div>
  );
};

export default Home;
HOMEEOF

# 4. Update Navbar with minimalist design
cat > src/components/Navbar.tsx << 'NAVBAREOF'
import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { logout } from '../store/slices/authSlice';
import { 
  SparklesIcon, 
  UserCircleIcon,
  ArrowRightOnRectangleIcon 
} from '@heroicons/react/24/outline';

const Navbar = () => {
  const { isAuthenticated, user } = useSelector((state: RootState) => state.auth);
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const handleLogout = () => {
    dispatch(logout());
    navigate('/login');
  };

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-slate-dark/80 backdrop-blur-md border-b border-white/10">
      <div className="max-w-7xl mx-auto px-6">
        <div className="flex items-center justify-between h-20">
          {/* Logo - Playful */}
          <Link to="/" className="flex items-center gap-3 group">
            <div className="relative">
              <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-coral to-mint rotate-45 group-hover:rotate-90 transition-transform"></div>
              <SparklesIcon className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 h-5 w-5 text-white rotate-[-45deg]" />
            </div>
            <div className="flex flex-col">
              <span className="font-display text-xl tracking-tight">HandyPro</span>
              <span className="font-accent text-xs tracking-widest text-mint">Connect</span>
            </div>
          </Link>

          {/* Navigation Links - Minimalist */}
          <div className="hidden md:flex items-center gap-8">
            <Link to="/" className="text-link text-lg">Home</Link>
            <Link to="/services" className="text-link text-lg">Services</Link>
            <Link to="/dashboard" className="text-link text-lg">Dashboard</Link>
            <Link to="/profile" className="text-link text-lg">Profile</Link>
          </div>

          {/* Auth Section */}
          <div className="flex items-center gap-4">
            {isAuthenticated ? (
              <>
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-gradient-to-br from-coral to-mint flex items-center justify-center">
                    <UserCircleIcon className="h-5 w-5 text-white" />
                  </div>
                  <span className="font-accent text-sm">{user?.email?.split('@')[0]}</span>
                </div>
                <button 
                  onClick={handleLogout}
                  className="btn-ghost !px-4 !py-2 text-sm flex items-center gap-2"
                >
                  <ArrowRightOnRectangleIcon className="h-4 w-4" />
                  Logout
                </button>
              </>
            ) : (
              <>
                <Link to="/login" className="text-link text-lg">Login</Link>
                <Link to="/register" className="btn-playful !px-6 !py-3 text-sm">
                  Join Free
                </Link>
              </>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
NAVBAREOF

# 5. Update Login page with premium design
cat > src/pages/Login.tsx << 'LOGINEOF'
import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { setCredentials } from '../store/slices/authSlice';
import api from '../services/api';
import { EnvelopeIcon, LockClosedIcon, ArrowRightIcon } from '@heroicons/react/24/outline';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const formData = new FormData();
      formData.append('username', email);
      formData.append('password', password);
      const { data } = await api.post('/auth/login', formData);
      dispatch(setCredentials({ user: { email, role: 'customer' }, token: data.access_token }));
      navigate('/dashboard');
    } catch (error) {
      console.error('Login failed:', error);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-6 py-12 relative overflow-hidden">
      {/* Background Pattern */}
      <div className="absolute inset-0 z-0 opacity-10">
        <div className="absolute top-1/4 left-1/4 w-64 h-64 bg-coral rounded-full blur-3xl"></div>
        <div className="absolute bottom-1/4 right-1/4 w-64 h-64 bg-mint rounded-full blur-3xl"></div>
      </div>

      <div className="relative z-10 w-full max-w-md">
        {/* Header */}
        <div className="text-center mb-12">
          <div className="inline-flex p-3 rounded-2xl bg-white/5 border border-white/10 mb-6">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-coral to-mint flex items-center justify-center">
              <LockClosedIcon className="h-6 w-6 text-white" />
            </div>
          </div>
          <h1 className="font-display text-4xl mb-3">Welcome back</h1>
          <p className="text-white/60">Sign in to continue your home journey</p>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-8">
          <div className="space-y-6">
            <div>
              <div className="flex items-center gap-3 mb-3">
                <EnvelopeIcon className="h-5 w-5 text-mint" />
                <label className="font-accent text-sm tracking-widest text-white/70">EMAIL</label>
              </div>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="minimal-input w-full"
                placeholder="hello@example.com"
                required
              />
            </div>
            
            <div>
              <div className="flex items-center gap-3 mb-3">
                <LockClosedIcon className="h-5 w-5 text-mint" />
                <label className="font-accent text-sm tracking-widest text-white/70">PASSWORD</label>
              </div>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="minimal-input w-full"
                placeholder="••••••••"
                required
              />
            </div>
          </div>

          <button type="submit" className="btn-playful w-full group">
            <span className="flex items-center justify-center gap-2">
              Sign In
              <ArrowRightIcon className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
            </span>
          </button>
        </form>

        {/* Links */}
        <div className="mt-10 pt-8 border-t border-white/10 text-center space-y-4">
          <Link to="/forgot-password" className="text-link block">
            Forgot your password?
          </Link>
          <p className="text-white/50">
            New here?{' '}
            <Link to="/register" className="text-link font-accent">
              Create an account
            </Link>
          </p>
          <Link to="/" className="btn-ghost !px-4 !py-2 text-sm inline-block">
            ← Back to home
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Login;
LOGINEOF

echo "✅ Premium playful design applied!"
echo "🚀 Restart: npm start"
echo "🎨 Features:"
echo "   • Premium 3-color palette (Slate, Coral, Mint)"
echo "   • Playful animations & hover effects"
echo "   • No boxes - minimalist text links"
echo "   • Glass-morphism cards"
echo "   • Custom fonts (Playfair Display, Inter, Space Grotesk)"
echo "   • Tool silhouette backgrounds"
