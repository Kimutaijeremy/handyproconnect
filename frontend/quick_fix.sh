#!/bin/bash
echo "=== QUICK FIX FOR ERRORS ==="

# 1. Fix the shadow class in index.css
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
    @apply bg-slate-900 text-white font-body antialiased;
    background-image: 
      radial-gradient(at 40% 20%, rgba(255, 107, 107, 0.1) 0px, transparent 50%),
      radial-gradient(at 80% 0%, rgba(78, 205, 196, 0.1) 0px, transparent 50%),
      radial-gradient(at 0% 50%, rgba(30, 41, 59, 0.3) 0px, transparent 50%);
    min-height: 100vh;
  }
  
  ::selection {
    @apply bg-coral text-white;
  }
  
  h1, h2, h3, h4 {
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  }
}

@layer components {
  .text-link {
    @apply relative inline-block text-white hover:text-mint transition-colors duration-300 font-medium;
  }
  
  .text-link::after {
    content: '';
    @apply absolute left-0 -bottom-1 w-0 h-0.5 bg-mint transition-all duration-300;
  }
  
  .text-link:hover::after {
    @apply w-full;
  }
  
  .glass-card {
    @apply bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl shadow-2xl;
  }
  
  .hover-lift {
    @apply transition-all duration-500 hover:-translate-y-2 hover:shadow-2xl;
  }
  
  .minimal-input {
    @apply bg-white/10 backdrop-blur-sm border-0 border-b-2 border-white/30 text-white placeholder-white/50 
           focus:outline-none focus:border-mint focus:ring-0 transition-colors duration-300
           px-6 py-4 text-lg rounded-t-xl;
  }
  
  .btn-playful {
    @apply relative overflow-hidden bg-gradient-to-r from-coral to-mint text-white 
           font-medium tracking-wider px-8 py-4 rounded-full shadow-2xl
           hover:shadow-xl hover:scale-105 transition-all duration-300;
  }
  
  .btn-ghost {
    @apply text-white hover:text-mint border-2 border-white/30 hover:border-mint/50 
           px-6 py-3 rounded-full backdrop-blur-sm
           transition-all duration-300 font-medium tracking-wide;
  }
  
  .section-title {
    @apply font-display text-5xl md:text-6xl mb-8 relative inline-block;
  }
  
  .text-pop {
    @apply text-white;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
  }
}

/* Animations */
@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}
CSSEOF

# 2. Fix Layout component props
cat > src/layout/Layout.tsx << 'LAYOUTEOF'
import React, { ReactNode } from 'react';
import Navbar from '../components/Navbar';

interface LayoutProps {
  children?: ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  return (
    <div className="relative min-h-screen overflow-x-hidden">
      <div className="fixed inset-0 z-0 bg-gradient-to-b from-slate-900/30 via-slate-900/60 to-slate-900"></div>
      
      <Navbar />
      <div className="relative z-10">
        {children}
      </div>
      
      <footer className="relative z-10 border-t border-white/10 bg-slate-900/50 backdrop-blur-sm">
        <div className="max-w-7xl mx-auto px-6 py-12">
          <div className="text-center">
            <div className="flex items-center justify-center gap-3 mb-6">
              <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-coral to-mint"></div>
              <span className="font-display text-xl">HandyPro Connect</span>
            </div>
            <p className="text-white/60 mb-6">
              Making home repairs simple, fast, and magical
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Layout;
LAYOUTEOF

# 3. Fix App.tsx to pass children to Layout
cat > src/App.tsx << 'APPEOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Provider } from 'react-redux';
import { store } from './store/store';
import Layout from './layout/Layout';

// Import all pages
import Home from './pages/Home';
import Services from './pages/Services';
import Login from './pages/Login';
import Register from './pages/Register';
import ForgotPassword from './pages/ForgotPassword';
import Dashboard from './pages/Dashboard';
import MyJobs from './pages/MyJobs';
import ProProfile from './pages/ProProfile';
import Quotes from './pages/Quotes';
import Reviews from './pages/Reviews';
import Calendar from './pages/Calendar';
import ProtectedRoute from './components/ProtectedRoute';

function App() {
  return (
    <Provider store={store}>
      <Router>
        <Layout>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/services" element={<Services />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/forgot-password" element={<ForgotPassword />} />
            
            <Route path="/dashboard" element={
              <ProtectedRoute>
                <Dashboard />
              </ProtectedRoute>
            } />
            <Route path="/my-jobs" element={
              <ProtectedRoute>
                <MyJobs />
              </ProtectedRoute>
            } />
            <Route path="/profile" element={
              <ProtectedRoute>
                <ProProfile />
              </ProtectedRoute>
            } />
            <Route path="/quotes" element={
              <ProtectedRoute>
                <Quotes />
              </ProtectedRoute>
            } />
            <Route path="/reviews" element={
              <ProtectedRoute>
                <Reviews />
              </ProtectedRoute>
            } />
            <Route path="/calendar" element={
              <ProtectedRoute>
                <Calendar />
              </ProtectedRoute>
            } />
          </Routes>
        </Layout>
      </Router>
    </Provider>
  );
}

export default App;
APPEOF

echo "✅ Errors fixed!"
echo "🚀 Starting app..."
npm start
