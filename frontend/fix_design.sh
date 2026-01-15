#!/bin/bash
echo "=== FIXING DESIGN & ADDING BACKGROUNDS ==="

# 1. Fix index.css with proper backgrounds
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
    @apply bg-slate-900 text-cream font-body antialiased;
    background-image: 
      radial-gradient(at 40% 20%, rgba(255, 107, 107, 0.1) 0px, transparent 50%),
      radial-gradient(at 80% 0%, rgba(78, 205, 196, 0.1) 0px, transparent 50%),
      radial-gradient(at 0% 50%, rgba(30, 41, 59, 0.3) 0px, transparent 50%);
    min-height: 100vh;
  }
  
  ::selection {
    @apply bg-coral text-white;
  }
  
  /* Force text to pop */
  h1, h2, h3, h4 {
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  }
}

@layer components {
  /* Premium Text Links */
  .text-link {
    @apply relative inline-block text-white hover:text-mint transition-colors duration-300 font-medium;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
  }
  
  .text-link::after {
    content: '';
    @apply absolute left-0 -bottom-1 w-0 h-0.5 bg-mint transition-all duration-300;
  }
  
  .text-link:hover::after {
    @apply w-full;
  }
  
  /* Glass Cards with depth */
  .glass-card {
    @apply bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl shadow-2xl;
    box-shadow: 
      inset 0 1px 0 0 rgba(255, 255, 255, 0.1),
      0 20px 40px rgba(0, 0, 0, 0.3);
  }
  
  .hover-lift {
    @apply transition-all duration-500 hover:-translate-y-2 hover:shadow-3xl;
  }
  
  /* Inputs that pop */
  .minimal-input {
    @apply bg-white/10 backdrop-blur-sm border-0 border-b-2 border-white/30 text-white placeholder-white/50 
           focus:outline-none focus:border-mint focus:ring-0 transition-colors duration-300
           px-6 py-4 text-lg rounded-t-xl;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
  }
  
  /* Vibrant Buttons */
  .btn-playful {
    @apply relative overflow-hidden bg-gradient-to-r from-coral to-mint text-white 
           font-accent tracking-wider px-8 py-4 rounded-full shadow-2xl
           hover:shadow-3xl hover:scale-105 transition-all duration-300
           before:absolute before:inset-0 before:bg-white/20 before:translate-x-full
           hover:before:translate-x-0 before:transition-transform before:duration-700;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
  }
  
  .btn-ghost {
    @apply text-white hover:text-mint border-2 border-white/30 hover:border-mint/50 
           px-6 py-3 rounded-full backdrop-blur-sm
           transition-all duration-300 font-accent tracking-wide;
  }
  
  /* Section Titles with glow */
  .section-title {
    @apply font-display text-5xl md:text-6xl mb-8 relative inline-block;
  }
  
  .section-title::before {
    content: '';
    @apply absolute -bottom-4 left-1/2 transform -translate-x-1/2 w-24 h-1.5 bg-gradient-to-r from-coral to-mint rounded-full blur-sm;
  }
  
  /* Force text contrast */
  .text-pop {
    @apply text-white;
    text-shadow: 
      0 1px 0 rgba(0, 0, 0, 0.3),
      0 2px 10px rgba(0, 0, 0, 0.5);
  }
}

/* Custom Scrollbar */
::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  @apply bg-slate-800;
}

::-webkit-scrollbar-thumb {
  @apply bg-gradient-to-b from-coral to-mint rounded-full;
}

/* Floating animations */
@keyframes float {
  0%, 100% { transform: translateY(0px) rotate(0deg); }
  50% { transform: translateY(-20px) rotate(5deg); }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}

/* Pulse glow */
@keyframes pulse-glow {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

.animate-pulse-glow {
  animation: pulse-glow 4s ease-in-out infinite;
}
CSSEOF

# 2. Create a new Home page with vivid design
cat > src/pages/Home.tsx << 'HOMEEOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { 
  SparklesIcon, 
  ArrowRightIcon, 
  WrenchScrewdriverIcon,
  BoltIcon,
  HomeIcon,
  CheckCircleIcon
} from '@heroicons/react/24/outline';

const Home = () => {
  const features = [
    {
      icon: <BoltIcon className="h-10 w-10" />,
      title: 'Lightning Fast',
      desc: 'Get quotes in minutes, not days',
      color: 'from-coral to-orange-400'
    },
    {
      icon: <CheckCircleIcon className="h-10 w-10" />,
      title: 'Verified Excellence',
      desc: 'Every pro is background-checked',
      color: 'from-mint to-emerald-400'
    },
    {
      icon: <WrenchScrewdriverIcon className="h-10 w-10" />,
      title: 'Any Job, Big or Small',
      desc: 'From leaky faucets to full renovations',
      color: 'from-purple-400 to-coral'
    }
  ];

  const steps = [
    { number: '01', title: 'Describe', desc: 'Tell us what you need fixed' },
    { number: '02', title: 'Match', desc: 'We find the perfect pro' },
    { number: '03', title: 'Approve', desc: 'Review quotes and choose' },
    { number: '04', title: 'Relax', desc: 'Watch the magic happen' }
  ];

  return (
    <div className="min-h-screen relative overflow-hidden">
      {/* Animated Background Elements */}
      <div className="fixed inset-0 z-0">
        {/* Gradient Orbs */}
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-gradient-to-r from-coral/20 to-pink-500/20 rounded-full blur-3xl animate-pulse-glow"></div>
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-gradient-to-r from-mint/20 to-cyan-500/20 rounded-full blur-3xl animate-pulse-glow" style={{animationDelay: '2s'}}></div>
        
        {/* Grid Pattern */}
        <div className="absolute inset-0 opacity-10" style={{
          backgroundImage: `linear-gradient(to right, #ffffff 1px, transparent 1px),
                           linear-gradient(to bottom, #ffffff 1px, transparent 1px)`,
          backgroundSize: '50px 50px'
        }}></div>
      </div>

      <div className="relative z-10">
        {/* Hero Section */}
        <div className="pt-32 pb-20 px-6 max-w-7xl mx-auto">
          <div className="text-center">
            {/* Badge */}
            <div className="inline-flex items-center gap-2 mb-8 px-6 py-3 rounded-full bg-white/10 backdrop-blur-sm border border-white/20">
              <SparklesIcon className="h-5 w-5 text-mint animate-pulse" />
              <span className="font-accent text-sm tracking-widest text-mint">TRUSTED BY 10,000+ HOMES</span>
            </div>
            
            {/* Main Headline */}
            <h1 className="font-display text-7xl md:text-8xl lg:text-9xl mb-8 leading-tight">
              <span className="block text-pop">Home repairs</span>
              <span className="block">
                made <span className="bg-gradient-to-r from-coral via-mint to-cyan-400 bg-clip-text text-transparent animate-pulse-glow">magical</span>
              </span>
            </h1>
            
            <p className="text-2xl text-white/90 mb-12 max-w-3xl mx-auto leading-relaxed">
              Stop stressing about home repairs. Connect with verified professionals, 
              get instant quotes, and enjoy peace of mind. <span className="text-mint font-medium">It's that simple.</span>
            </p>
            
            {/* CTA Buttons */}
            <div className="flex flex-col sm:flex-row gap-6 justify-center mb-20">
              <Link to="/services" className="btn-playful text-xl px-12 py-6">
                <span className="flex items-center gap-3">
                  Start Your Project
                  <ArrowRightIcon className="h-6 w-6 group-hover:translate-x-2 transition-transform" />
                </span>
              </Link>
              <Link to="/login" className="btn-ghost text-xl px-12 py-6">
                Sign In to Continue
              </Link>
            </div>
            
            {/* Search Bar */}
            <div className="max-w-2xl mx-auto mb-16">
              <div className="glass-card p-2">
                <div className="flex flex-col md:flex-row gap-2">
                  <input 
                    type="text" 
                    placeholder="What needs fixing? e.g., 'leaky kitchen sink'" 
                    className="minimal-input flex-1"
                  />
                  <button className="btn-playful !px-10">
                    Find Pros
                  </button>
                </div>
                <div className="flex flex-wrap justify-center gap-3 mt-4">
                  {['plumbing', 'electrical', 'painting', 'cleaning', 'assembly', 'repair'].map((tag) => (
                    <span 
                      key={tag}
                      className="px-4 py-2 rounded-full bg-white/5 hover:bg-white/10 border border-white/10 text-sm transition-colors cursor-pointer hover:border-mint/30"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          </div>

          {/* Features Grid */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-32">
            {features.map((feature, index) => (
              <div 
                key={index}
                className="glass-card p-8 hover-lift group animate-float"
                style={{ animationDelay: `${index * 1}s` }}
              >
                <div className={`inline-flex p-4 rounded-2xl bg-gradient-to-br ${feature.color} mb-6 group-hover:scale-110 transition-transform duration-300`}>
                  <div className="text-white">{feature.icon}</div>
                </div>
                <h3 className="text-2xl font-display mb-4 text-pop">{feature.title}</h3>
                <p className="text-white/80 mb-6 text-lg">{feature.desc}</p>
                <div className="h-1 w-12 bg-gradient-to-r from-coral to-mint rounded-full"></div>
              </div>
            ))}
          </div>

          {/* How It Works */}
          <div className="mb-32">
            <h2 className="section-title text-center mb-16">How it works</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
              {steps.map((step, index) => (
                <div key={index} className="text-center group">
                  <div className="relative mb-6">
                    <div className="w-24 h-24 mx-auto rounded-full bg-gradient-to-br from-coral/20 to-mint/20 flex items-center justify-center group-hover:from-coral/30 group-hover:to-mint/30 transition-all duration-300">
                      <div className="w-20 h-20 rounded-full bg-gradient-to-br from-coral to-mint flex items-center justify-center">
                        <span className="text-2xl font-accent font-bold">{step.number}</span>
                      </div>
                    </div>
                    <div className="absolute top-1/2 left-full hidden lg:block w-16 h-1 bg-gradient-to-r from-mint to-coral transform -translate-y-1/2"></div>
                  </div>
                  <h3 className="text-2xl font-display mb-3 text-pop">{step.title}</h3>
                  <p className="text-white/70">{step.desc}</p>
                </div>
              ))}
            </div>
          </div>

          {/* Final CTA */}
          <div className="glass-card p-12 text-center">
            <h2 className="text-5xl font-display mb-6 text-pop">
              Ready to experience <span className="bg-gradient-to-r from-coral to-mint bg-clip-text text-transparent">magic</span>?
            </h2>
            <p className="text-xl text-white/80 mb-8 max-w-2xl mx-auto">
              Join thousands of homeowners who've transformed their repair experiences.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Link to="/register" className="btn-playful text-xl px-12 py-5">
                Start Free Today
              </Link>
              <Link to="/services" className="btn-ghost text-xl px-12 py-5">
                Browse Services
              </Link>
            </div>
          </div>
        </div>

        {/* Floating Tool Decorations */}
        <div className="fixed bottom-0 left-0 right-0 h-32 pointer-events-none">
          {[10, 25, 40, 60, 75, 90].map((pos) => (
            <div 
              key={pos}
              className="absolute bottom-0 text-white/10 animate-float"
              style={{ 
                left: `${pos}%`, 
                animationDelay: `${pos/10}s`,
                fontSize: `${40 + pos/2}px`
              }}
            >
              <WrenchScrewdriverIcon className="h-16 w-16" />
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Home;
HOMEEOF

# 3. Create a minimal layout wrapper
cat > src/layout/Layout.tsx << 'LAYOUTEOF'
import React from 'react';
import { Outlet } from 'react-router-dom';
import Navbar from '../components/Navbar';

const Layout = () => {
  return (
    <div className="relative min-h-screen overflow-x-hidden">
      {/* Background overlay for content readability */}
      <div className="fixed inset-0 z-0 bg-gradient-to-b from-slate-900/30 via-slate-900/60 to-slate-900"></div>
      
      <Navbar />
      <div className="relative z-10">
        <Outlet />
      </div>
      
      {/* Footer */}
      <footer className="relative z-10 border-t border-white/10 bg-slate-900/50 backdrop-blur-sm">
        <div className="max-w-7xl mx-auto px-6 py-12">
          <div className="text-center">
            <div className="flex items-center justify-center gap-3 mb-6">
              <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-coral to-mint"></div>
              <span className="font-display text-xl">HandyPro Connect</span>
            </div>
            <p className="text-white/60 mb-6">
              Making home repairs simple, fast, and magical since 2024
            </p>
            <div className="flex justify-center gap-6 text-sm">
              <a href="#" className="text-link">Privacy</a>
              <a href="#" className="text-link">Terms</a>
              <a href="#" className="text-link">Contact</a>
              <a href="#" className="text-link">Careers</a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Layout;
LAYOUTEOF

# 4. Update App.tsx to use Layout
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
            {/* Public routes */}
            <Route path="/" element={<Home />} />
            <Route path="/services" element={<Services />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/forgot-password" element={<ForgotPassword />} />
            
            {/* Protected routes */}
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

echo "✅ DESIGN FIXED!"
echo "🚀 Restart: npm start"
echo ""
echo "NOW YOU'LL GET:"
echo "• Vivid background gradients"
echo "• Text that POPS with shadows"
echo "• Glass-morphism effects"
echo "• Floating animations"
echo "• Professional layout"
echo "• Everything looks COMPLETE"
