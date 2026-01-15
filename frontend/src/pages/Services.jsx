import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { 
  BoltIcon, WrenchScrewdriverIcon, 
  HomeIcon, SparklesIcon, CheckCircleIcon,
  ClockIcon, CurrencyDollarIcon, ShieldCheckIcon
} from '@heroicons/react/24/outline';

const Services = () => {
  const { isAuthenticated, user } = useSelector((state) => state.auth);
  const [selectedService, setSelectedService] = useState(null);

  const services = [
    {
      id: 1,
      name: 'Electrical Services',
      category: 'electrical',
      icon: <BoltIcon className="h-8 w-8" />,
      color: 'from-yellow-500 to-orange-400',
      description: 'Professional electrical installations, repairs, and maintenance.',
      features: ['Wiring Installation', 'Lighting Solutions', 'Panel Upgrades', 'Safety Inspections'],
      avgPrice: '$150 - $500',
      time: '2-6 hours',
      professionals: 42
    },
    {
      id: 2,
      name: 'Plumbing',
      category: 'plumbing',
      icon: <WrenchScrewdriverIcon className="h-8 w-8" />,
      color: 'from-blue-500 to-cyan-400',
      description: 'Comprehensive plumbing solutions for homes and businesses.',
      features: ['Leak Repair', 'Pipe Installation', 'Drain Cleaning', 'Fixture Installation'],
      avgPrice: '$100 - $400',
      time: '1-4 hours',
      professionals: 38
    },
    {
      id: 3,
      name: 'Handyman Services',
      category: 'general',
      icon: <HomeIcon className="h-8 w-8" />,
      color: 'from-green-500 to-emerald-400',
      description: 'General home repairs and maintenance tasks.',
      features: ['Furniture Assembly', 'Painting', 'Drywall Repair', 'Minor Installations'],
      avgPrice: '$75 - $300',
      time: '1-3 hours',
      professionals: 56
    },
    {
      id: 4,
      name: 'Green Solutions',
      category: 'green',
      icon: <SparklesIcon className="h-8 w-8" />,
      color: 'from-emerald-500 to-teal-400',
      description: 'Eco-friendly home solutions and sustainable installations.',
      features: ['Solar Installation', 'Energy Audits', 'Water Conservation', 'Green Materials'],
      avgPrice: '$200 - $800',
      time: '3-8 hours',
      professionals: 24
    },
    {
      id: 5,
      name: 'HVAC Services',
      category: 'hvac',
      icon: <BoltIcon className="h-8 w-8" />,
      color: 'from-purple-500 to-pink-400',
      description: 'Heating, ventilation, and air conditioning services.',
      features: ['AC Installation', 'Heater Repair', 'Duct Cleaning', 'System Maintenance'],
      avgPrice: '$250 - $600',
      time: '3-6 hours',
      professionals: 31
    },
    {
      id: 6,
      name: 'Appliance Repair',
      category: 'appliance',
      icon: <WrenchScrewdriverIcon className="h-8 w-8" />,
      color: 'from-red-500 to-orange-400',
      description: 'Repair and maintenance of home appliances.',
      features: ['Refrigerator Repair', 'Washer/Dryer Fix', 'Oven Service', 'Dishwasher Repair'],
      avgPrice: '$100 - $350',
      time: '1-3 hours',
      professionals: 29
    }
  ];

  const testimonials = [
    {
      name: 'Sarah M.',
      role: 'Homeowner',
      text: 'Found a great electrician within minutes. The job was done perfectly!',
      rating: 5
    },
    {
      name: 'John D.',
      role: 'Professional',
      text: 'This platform has helped me grow my business and find reliable clients.',
      rating: 5
    },
    {
      name: 'Lisa R.',
      role: 'Property Manager',
      text: 'Managing multiple properties has never been easier with HandyPro Connect.',
      rating: 4
    }
  ];

  return (
    <div className="min-h-screen bg-gray-900 pt-20 pb-12">
      <div className="max-w-7xl mx-auto px-6">
        {/* Hero Section */}
        <div className="text-center mb-12">
          <h1 className="font-display text-5xl md:text-6xl text-white mb-6">
            Professional <span className="bg-gradient-to-r from-pink-500 to-purple-600 bg-clip-text text-transparent">Home Services</span>
          </h1>
          <p className="text-xl text-white/70 max-w-3xl mx-auto mb-8">
            Connect with certified professionals for all your home service needs. 
            From quick fixes to major renovations, we've got you covered.
          </p>
          {!isAuthenticated && (
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Link to="/register?role=customer" className="px-8 py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white hover:shadow-xl transition-all">
                Get Started as Homeowner
              </Link>
              <Link to="/register?role=professional" className="px-8 py-4 rounded-full border-2 border-white/30 text-white hover:border-purple-500 transition-all">
                Join as Professional
              </Link>
            </div>
          )}
        </div>

        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mb-12">
          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 text-center">
            <div className="text-3xl font-display text-white mb-2">200+</div>
            <div className="text-white/60">Professionals</div>
          </div>
          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 text-center">
            <div className="text-3xl font-display text-white mb-2">500+</div>
            <div className="text-white/60">Jobs Completed</div>
          </div>
          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 text-center">
            <div className="text-3xl font-display text-white mb-2">4.8</div>
            <div className="text-white/60">Avg Rating</div>
          </div>
          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 text-center">
            <div className="text-3xl font-display text-white mb-2">24/7</div>
            <div className="text-white/60">Support</div>
          </div>
        </div>

        {/* Services Grid */}
        <div className="mb-16">
          <h2 className="text-3xl font-display text-white mb-8 text-center">Our Services</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {services.map(service => (
              <div 
                key={service.id}
                className={`bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 hover:border-purple-500/50 transition-all cursor-pointer ${
                  selectedService === service.id ? 'ring-2 ring-purple-500' : ''
                }`}
                onClick={() => setSelectedService(service.id === selectedService ? null : service.id)}
              >
                <div className={`inline-flex p-3 rounded-xl bg-gradient-to-br ${service.color} mb-4`}>
                  <div className="text-white">{service.icon}</div>
                </div>
                <h3 className="text-xl font-display text-white mb-3">{service.name}</h3>
                <p className="text-white/70 mb-4">{service.description}</p>
                
                {selectedService === service.id && (
                  <div className="mt-6 pt-6 border-t border-white/10">
                    <div className="grid grid-cols-2 gap-4 mb-4">
                      <div className="flex items-center gap-2">
                        <CurrencyDollarIcon className="h-4 w-4 text-white/60" />
                        <span className="text-white text-sm">Avg: {service.avgPrice}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <ClockIcon className="h-4 w-4 text-white/60" />
                        <span className="text-white text-sm">{service.time}</span>
                      </div>
                    </div>
                    <div className="mb-4">
                      <div className="text-white/60 text-sm mb-2">Features:</div>
                      <div className="space-y-1">
                        {service.features.map((feature, idx) => (
                          <div key={idx} className="flex items-center gap-2">
                            <CheckCircleIcon className="h-3 w-3 text-green-400" />
                            <span className="text-white text-sm">{feature}</span>
                          </div>
                        ))}
                      </div>
                    </div>
                    <div className="text-white/60 text-sm">
                      {service.professionals} professionals available
                    </div>
                  </div>
                )}

                <div className="mt-6 flex justify-between items-center">
                  <span className="text-xs px-2 py-1 rounded-full bg-white/10 text-white/60">
                    {service.category}
                  </span>
                  {isAuthenticated && (
                    <Link 
                      to="/dashboard"
                      className="text-purple-400 hover:text-purple-300 text-sm"
                    >
                      Post a job →
                    </Link>
                  )}
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* How It Works */}
        <div className="mb-16">
          <h2 className="text-3xl font-display text-white mb-8 text-center">How It Works</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="text-center">
              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-pink-500 to-purple-600 mx-auto mb-6 flex items-center justify-center">
                <div className="text-white font-display text-2xl">1</div>
              </div>
              <h3 className="text-xl font-display text-white mb-3">Post Your Job</h3>
              <p className="text-white/70">
                Describe what you need help with, set your budget, and post your job for free.
              </p>
            </div>
            <div className="text-center">
              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-blue-500 to-cyan-600 mx-auto mb-6 flex items-center justify-center">
                <div className="text-white font-display text-2xl">2</div>
              </div>
              <h3 className="text-xl font-display text-white mb-3">Receive Quotes</h3>
              <p className="text-white/70">
                Get quotes from verified professionals who match your requirements.
              </p>
            </div>
            <div className="text-center">
              <div className="w-16 h-16 rounded-full bg-gradient-to-br from-green-500 to-emerald-600 mx-auto mb-6 flex items-center justify-center">
                <div className="text-white font-display text-2xl">3</div>
              </div>
              <h3 className="text-xl font-display text-white mb-3">Choose & Hire</h3>
              <p className="text-white/70">
                Compare quotes, check reviews, and hire the perfect professional for your job.
              </p>
            </div>
          </div>
        </div>

        {/* Testimonials */}
        <div className="mb-16">
          <h2 className="text-3xl font-display text-white mb-8 text-center">What Our Users Say</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {testimonials.map((testimonial, idx) => (
              <div key={idx} className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
                <div className="flex items-center gap-2 mb-4">
                  {[...Array(5)].map((_, i) => (
                    <div key={i} className={`w-4 h-4 ${i < testimonial.rating ? 'text-yellow-400' : 'text-white/30'}`}>
                      ★
                    </div>
                  ))}
                </div>
                <p className="text-white/80 italic mb-4">"{testimonial.text}"</p>
                <div>
                  <div className="text-white font-medium">{testimonial.name}</div>
                  <div className="text-white/60 text-sm">{testimonial.role}</div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* CTA */}
        <div className="bg-gradient-to-r from-pink-500/20 to-purple-600/20 border border-white/20 rounded-2xl p-12 text-center">
          <h2 className="text-3xl font-display text-white mb-6">Ready to get started?</h2>
          <p className="text-xl text-white/70 mb-8 max-w-2xl mx-auto">
            Join thousands of satisfied homeowners and professionals on HandyPro Connect.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/register?role=customer" className="px-8 py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white hover:shadow-xl transition-all">
              Sign Up as Homeowner
            </Link>
            <Link to="/register?role=professional" className="px-8 py-4 rounded-full border-2 border-white/30 text-white hover:border-purple-500 transition-all">
              Join as Professional
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Services;
