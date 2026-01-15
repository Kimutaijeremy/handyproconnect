import React from 'react';
import { Link } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { SparklesIcon, ArrowRightIcon, BoltIcon, CheckCircleIcon, WrenchScrewdriverIcon } from '@heroicons/react/24/outline';

const Home = () => {
  const { isAuthenticated, user } = useSelector((state) => state.auth);
  
  const features = [
    {
      icon: <BoltIcon className="h-10 w-10" />,
      title: 'Instant Quotes',
      desc: 'Get real-time quotes from available professionals',
      color: 'from-pink-500 to-orange-400'
    },
    {
      icon: <CheckCircleIcon className="h-10 w-10" />,
      title: 'Verified Professionals',
      desc: 'Every pro is background-checked and certified',
      color: 'from-purple-500 to-indigo-400'
    },
    {
      icon: <WrenchScrewdriverIcon className="h-10 w-10" />,
      title: 'Any Home Service',
      desc: 'From small repairs to major renovations',
      color: 'from-blue-500 to-cyan-400'
    }
  ];

  return (
    <div className="min-h-screen relative overflow-hidden">
      <div className="absolute inset-0 z-0">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-gradient-to-r from-pink-500/20 to-purple-500/20 rounded-full blur-3xl"></div>
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-gradient-to-r from-blue-500/20 to-cyan-500/20 rounded-full blur-3xl"></div>
      </div>
      
      <div className="relative z-10 pt-32 pb-20 px-6 max-w-7xl mx-auto text-center">
        <div className="inline-flex items-center gap-2 mb-8 px-6 py-3 rounded-full bg-white/10 border border-white/20">
          <SparklesIcon className="h-5 w-5 text-purple-400" />
          <span className="text-sm tracking-widest text-purple-400">TRUSTED BY HOMEOWNERS & PROS</span>
        </div>
        
        <h1 className="font-display text-7xl md:text-8xl mb-8 leading-tight">
          <span className="block text-white">Home repairs</span>
          <span className="block">
            made <span className="bg-gradient-to-r from-pink-500 to-purple-600 bg-clip-text text-transparent">simple</span>
          </span>
        </h1>
        
        <p className="text-2xl text-white/70 mb-12 max-w-3xl mx-auto">
          Connect with verified professionals or find quality work. Whether you're a homeowner or a pro, we've got you covered.
        </p>
        
        <div className="flex flex-col sm:flex-row gap-6 justify-center mb-20">
          {isAuthenticated ? (
            user?.role === 'professional' ? (
              <Link to="/pro/jobs" className="px-12 py-6 rounded-full bg-gradient-to-r from-green-500 to-emerald-600 text-white text-xl hover:shadow-xl transition-all">
                Find Available Jobs
              </Link>
            ) : (
              <Link to="/services" className="px-12 py-6 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-xl hover:shadow-xl transition-all">
                Post a Job
              </Link>
            )
          ) : (
            <>
              <Link to="/register?role=customer" className="px-12 py-6 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-xl hover:shadow-xl transition-all">
                <span className="flex items-center gap-3">
                  I Need Help
                  <ArrowRightIcon className="h-6 w-6 group-hover:translate-x-2 transition-transform" />
                </span>
              </Link>
              <Link to="/register?role=professional" className="px-12 py-6 rounded-full border-2 border-white/30 text-white text-xl hover:border-purple-500 transition-all">
                I'm a Professional
              </Link>
            </>
          )}
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-32">
          {features.map((feature, index) => (
            <div key={index} className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8 hover:border-purple-500/50 transition-all">
              <div className={`inline-flex p-4 rounded-2xl bg-gradient-to-br ${feature.color} mb-6`}>
                <div className="text-white">{feature.icon}</div>
              </div>
              <h3 className="text-2xl font-display mb-4 text-white">{feature.title}</h3>
              <p className="text-white/60">{feature.desc}</p>
            </div>
          ))}
        </div>
        
        <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-12">
          <h2 className="text-4xl font-display mb-6 text-white">Ready to get started?</h2>
          <p className="text-xl text-white/70 mb-8 max-w-2xl mx-auto">
            Join thousands of satisfied customers and professionals.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/register?role=customer" className="px-8 py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white">
              Sign Up as Homeowner
            </Link>
            <Link to="/register?role=professional" className="px-8 py-4 rounded-full border-2 border-white/30 text-white hover:border-purple-500">
              Join as Professional
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Home;
