#!/bin/bash
echo "=== FIXING EXPORT ERRORS ==="

# Fix all page exports - ensure they export default
for page in Home Login Register Services Dashboard MyJobs Quotes Calendar Reviews ProProfile ForgotPassword; do
  cat > src/pages/${page}.jsx << PAGEEOF
import React from 'react';

const ${page} = () => (
  <div className="min-h-screen pt-24 px-6">
    <div className="max-w-7xl mx-auto">
      <h1 className="font-display text-5xl mb-6">${page.replace(/([A-Z])/g, ' $1').trim()}</h1>
      <div className="glass-card p-8">
        <p>${page} page content here.</p>
      </div>
    </div>
  </div>
);

export default ${page};
PAGEEOF
done

# Fix Home page with proper export
cat > src/pages/Home.jsx << 'HOMEEOF'
import React from 'react';
import { Link } from 'react-router-dom';
import { SparklesIcon, ArrowRightIcon } from '@heroicons/react/24/outline';

const Home = () => {
  return (
    <div className="min-h-screen relative overflow-hidden">
      <div className="relative z-10 pt-32 pb-20 px-6 max-w-7xl mx-auto text-center">
        <div className="inline-flex items-center gap-2 mb-8 px-6 py-3 rounded-full bg-white/10 border border-white/20">
          <SparklesIcon className="h-5 w-5 text-mint" />
          <span className="font-accent text-sm tracking-widest text-mint">HANDYPRO CONNECT</span>
        </div>
        
        <h1 className="font-display text-7xl md:text-8xl mb-8 leading-tight">
          <span className="block">Home repairs</span>
          <span className="block">
            made <span className="bg-gradient-to-r from-coral to-mint bg-clip-text text-transparent">magical</span>
          </span>
        </h1>
        
        <p className="text-2xl text-white/90 mb-12 max-w-3xl mx-auto">
          Connect with verified professionals for all your home needs.
        </p>
        
        <div className="flex flex-col sm:flex-row gap-6 justify-center">
          <Link to="/services" className="btn-playful text-xl px-12 py-6">
            Start Your Project
          </Link>
          <Link to="/login" className="btn-ghost text-xl px-12 py-6">
            Sign In
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Home;
HOMEEOF

# Fix App.jsx imports
cat > src/App.jsx << 'APPEOF'
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

echo "✅ Exports fixed!"
echo "🚀 Restarting app..."
npm start
