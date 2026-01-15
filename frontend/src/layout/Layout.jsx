import React from 'react';
import Navbar from '../components/Navbar';

const Layout = ({ children }) => {
  return (
    <div className="min-h-screen bg-gray-900">
      <Navbar />
      <main className="pt-20">
        {children}
      </main>
      <footer className="border-t border-white/10 py-12 text-center">
        <p className="text-white/60">HandyPro Connect © 2024 - Premium Home Services Platform</p>
      </footer>
    </div>
  );
};

export default Layout;
