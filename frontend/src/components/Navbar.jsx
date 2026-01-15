import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { logout } from '../store/slices/authSlice';
import { SparklesIcon, UserCircleIcon } from '@heroicons/react/24/outline';

const Navbar = () => {
  const { isAuthenticated, user } = useSelector((state) => state.auth);
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const handleLogout = () => {
    dispatch(logout());
    navigate('/login');
  };

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-gray-900/80 backdrop-blur-md border-b border-white/10">
      <div className="max-w-7xl mx-auto px-6">
        <div className="flex items-center justify-between h-20">
          <Link to="/" className="flex items-center gap-3 group">
            <div className="relative">
              <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-pink-500 to-purple-600 rotate-45 group-hover:rotate-90 transition-transform"></div>
              <SparklesIcon className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 h-5 w-5 text-white rotate-[-45deg]" />
            </div>
            <div className="flex flex-col">
              <span className="font-display text-xl tracking-tight">HandyPro</span>
              <span className="text-xs tracking-widest text-purple-400">Connect</span>
            </div>
          </Link>

          <div className="hidden md:flex items-center gap-8">
            <Link to="/" className="text-white hover:text-purple-400 transition-colors">Home</Link>
            <Link to="/services" className="text-white hover:text-purple-400 transition-colors">Services</Link>
            {isAuthenticated && (
              <>
                <Link to="/dashboard" className="text-white hover:text-purple-400 transition-colors">Dashboard</Link>
                {user?.role === 'professional' && (
                  <Link to="/pro/jobs" className="text-white hover:text-purple-400 transition-colors">Find Jobs</Link>
                )}
              </>
            )}
          </div>

          <div className="flex items-center gap-4">
            {isAuthenticated ? (
              <>
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-full bg-gradient-to-br from-pink-500 to-purple-600 flex items-center justify-center">
                    <UserCircleIcon className="h-5 w-5 text-white" />
                  </div>
                  <span className="text-sm">{user?.full_name || user?.email?.split('@')[0]}</span>
                  <span className="px-2 py-1 text-xs rounded-full bg-purple-500/20 text-purple-300">
                    {user?.role}
                  </span>
                </div>
                <button 
                  onClick={handleLogout}
                  className="px-4 py-2 rounded-full border border-white/30 text-white hover:border-purple-500 transition-colors"
                >
                  Logout
                </button>
              </>
            ) : (
              <>
                <Link to="/login" className="text-white hover:text-purple-400 transition-colors">Login</Link>
                <Link to="/register" className="px-6 py-2 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white hover:shadow-xl transition-all">
                  Sign Up
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
