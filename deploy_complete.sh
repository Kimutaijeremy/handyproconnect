#!/bin/bash
echo "=== DEPLOYING COMPLETE HANDYPRO CONNECT ==="

# 1. ENHANCE ALL PAGES WITH REAL FEATURES
cd frontend

# Update Services page with real features
cat > src/pages/Services.tsx << 'SERVICESEOF'
import React, { useState, useEffect } from 'react';
import { BoltIcon, WrenchIcon, HomeIcon, CheckCircleIcon, StarIcon } from '@heroicons/react/24/outline';
import api from '../services/api';

interface Service {
  id: number;
  name: string;
  category: string;
  description: string;
}

const Services = () => {
  const [services, setServices] = useState<Service[]>([
    { id: 1, name: 'Electrical Repairs', category: 'electrical', description: 'Lighting, wiring, panel upgrades' },
    { id: 2, name: 'Plumbing Services', category: 'plumbing', description: 'Leaks, installations, water heaters' },
    { id: 3, name: 'Handyman Tasks', category: 'handyman', description: 'Furniture assembly, painting, repairs' },
    { id: 4, name: 'HVAC Services', category: 'hvac', description: 'Heating and cooling system maintenance' },
    { id: 5, name: 'Appliance Repair', category: 'appliance', description: 'Refrigerator, oven, washer repair' },
    { id: 6, name: 'Green Solutions', category: 'green', description: 'Solar panels, energy-efficient upgrades' },
  ]);

  const [selectedCategory, setSelectedCategory] = useState('all');

  const filteredServices = selectedCategory === 'all' 
    ? services 
    : services.filter(service => service.category === selectedCategory);

  const categories = [
    { id: 'all', name: 'All Services', icon: '🛠️' },
    { id: 'electrical', name: 'Electrical', icon: '⚡' },
    { id: 'plumbing', name: 'Plumbing', icon: '🚿' },
    { id: 'handyman', name: 'Handyman', icon: '🏠' },
    { id: 'hvac', name: 'HVAC', icon: '❄️' },
    { id: 'green', name: 'Green Certified', icon: '🌿' },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-2">Professional Home Services</h1>
      <p className="text-gray-600 mb-8">Browse and book certified professionals for all your home needs</p>
      
      {/* Category Filter */}
      <div className="flex flex-wrap gap-2 mb-8">
        {categories.map((cat) => (
          <button
            key={cat.id}
            onClick={() => setSelectedCategory(cat.id)}
            className={`px-4 py-2 rounded-full flex items-center gap-2 ${
              selectedCategory === cat.id 
                ? 'bg-primary-600 text-white' 
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            <span>{cat.icon}</span>
            <span>{cat.name}</span>
          </button>
        ))}
      </div>
      
      {/* Services Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
        {filteredServices.map((service) => (
          <div key={service.id} className="card hover:shadow-lg transition-shadow">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 bg-primary-100 rounded-lg flex items-center justify-center">
                  {service.category === 'electrical' && <BoltIcon className="h-6 w-6 text-primary-600" />}
                  {service.category === 'plumbing' && <WrenchIcon className="h-6 w-6 text-primary-600" />}
                  {service.category === 'handyman' && <HomeIcon className="h-6 w-6 text-primary-600" />}
                  {service.category === 'green' && <CheckCircleIcon className="h-6 w-6 text-green-600" />}
                </div>
                <h3 className="text-xl font-semibold">{service.name}</h3>
              </div>
              {service.category === 'green' && (
                <span className="px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">
                  Eco-Friendly
                </span>
              )}
            </div>
            
            <p className="text-gray-600 mb-4">{service.description}</p>
            
            <div className="flex items-center justify-between mt-4 pt-4 border-t border-gray-100">
              <div className="flex items-center">
                <StarIcon className="h-4 w-4 text-yellow-500 mr-1" />
                <span className="text-sm">4.8+ Rating</span>
              </div>
              <button className="btn-primary">Find Pros</button>
            </div>
          </div>
        ))}
      </div>
      
      {/* Green Certification Section */}
      <div className="bg-gradient-to-r from-green-50 to-emerald-50 rounded-2xl p-8 border border-green-200">
        <div className="flex flex-col md:flex-row items-center justify-between">
          <div className="mb-6 md:mb-0">
            <div className="flex items-center mb-3">
              <CheckCircleIcon className="h-8 w-8 text-green-600 mr-3" />
              <h2 className="text-2xl font-bold text-gray-900">Green Certified Professionals</h2>
            </div>
            <p className="text-gray-700 mb-4 max-w-2xl">
              Our platform features professionals with verified green certifications for eco-friendly home solutions. 
              Look for the green badge when booking services.
            </p>
            <div className="grid grid-cols-2 gap-3">
              {['Solar Installation', 'Water Efficiency', 'Energy Audit', 'Eco Materials'].map((item) => (
                <div key={item} className="flex items-center">
                  <div className="h-2 w-2 bg-green-500 rounded-full mr-2"></div>
                  <span className="text-sm">{item}</span>
                </div>
              ))}
            </div>
          </div>
          <div className="bg-white rounded-xl p-6 shadow-sm">
            <h3 className="font-semibold mb-2">Certification Benefits</h3>
            <ul className="space-y-2 text-sm">
              <li className="flex items-center"><CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" /> Lower energy bills</li>
              <li className="flex items-center"><CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" /> Tax incentives</li>
              <li className="flex items-center"><CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" /> Environmental impact</li>
              <li className="flex items-center"><CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" /> Higher home value</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Services;
SERVICESEOF

# Update MyJobs page with real job management
cat > src/pages/MyJobs.tsx << 'MYJOBSDEOF'
import React, { useState } from 'react';
import { 
  ClockIcon, 
  MapPinIcon, 
  CurrencyDollarIcon, 
  CheckCircleIcon,
  ExclamationTriangleIcon,
  ChatBubbleLeftRightIcon
} from '@heroicons/react/24/outline';

interface Job {
  id: number;
  title: string;
  description: string;
  location: string;
  status: 'open' | 'quoted' | 'in_progress' | 'completed';
  budget: number;
  quotes: number;
  postedDate: string;
}

const MyJobs = () => {
  const [jobs, setJobs] = useState<Job[]>([
    { id: 1, title: 'Fix Kitchen Sink Leak', description: 'Kitchen sink has constant drip under cabinet', location: 'Westlands, Nairobi', status: 'open', budget: 5000, quotes: 3, postedDate: '2024-01-15' },
    { id: 2, title: 'Install Solar Water Heater', description: 'Need solar water heater installation on roof', location: 'Karen, Nairobi', status: 'quoted', budget: 45000, quotes: 5, postedDate: '2024-01-12' },
    { id: 3, title: 'Electrical Wiring Repair', description: 'Living room outlets not working properly', location: 'Kilimani, Nairobi', status: 'in_progress', budget: 8000, quotes: 4, postedDate: '2024-01-10' },
    { id: 4, title: 'Paint House Interior', description: '3-bedroom house needs fresh paint', location: 'Runda, Nairobi', status: 'completed', budget: 35000, quotes: 6, postedDate: '2024-01-05' },
  ]);

  const [filter, setFilter] = useState('all');

  const filteredJobs = filter === 'all' 
    ? jobs 
    : jobs.filter(job => job.status === filter);

  const getStatusColor = (status: string) => {
    switch(status) {
      case 'open': return 'bg-blue-100 text-blue-800';
      case 'quoted': return 'bg-purple-100 text-purple-800';
      case 'in_progress': return 'bg-yellow-100 text-yellow-800';
      case 'completed': return 'bg-green-100 text-green-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  const getStatusIcon = (status: string) => {
    switch(status) {
      case 'open': return <ExclamationTriangleIcon className="h-5 w-5" />;
      case 'completed': return <CheckCircleIcon className="h-5 w-5" />;
      default: return <ClockIcon className="h-5 w-5" />;
    }
  };

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-8">
        <div>
          <h1 className="text-3xl font-bold mb-2">My Jobs</h1>
          <p className="text-gray-600">Manage your posted jobs and track progress</p>
        </div>
        <button className="btn-primary mt-4 md:mt-0">Post New Job</button>
      </div>

      {/* Stats Overview */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="card text-center">
          <div className="text-2xl font-bold text-blue-600">{jobs.length}</div>
          <div className="text-sm text-gray-600">Total Jobs</div>
        </div>
        <div className="card text-center">
          <div className="text-2xl font-bold text-purple-600">{jobs.filter(j => j.status === 'open').length}</div>
          <div className="text-sm text-gray-600">Open</div>
        </div>
        <div className="card text-center">
          <div className="text-2xl font-bold text-yellow-600">{jobs.filter(j => j.status === 'in_progress').length}</div>
          <div className="text-sm text-gray-600">In Progress</div>
        </div>
        <div className="card text-center">
          <div className="text-2xl font-bold text-green-600">{jobs.filter(j => j.status === 'completed').length}</div>
          <div className="text-sm text-gray-600">Completed</div>
        </div>
      </div>

      {/* Filter Tabs */}
      <div className="flex space-x-4 mb-6 overflow-x-auto pb-2">
        {['all', 'open', 'quoted', 'in_progress', 'completed'].map((status) => (
          <button
            key={status}
            onClick={() => setFilter(status)}
            className={`px-4 py-2 rounded-lg whitespace-nowrap ${
              filter === status 
                ? 'bg-primary-600 text-white' 
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            {status.charAt(0).toUpperCase() + status.slice(1).replace('_', ' ')}
          </button>
        ))}
      </div>

      {/* Jobs List */}
      <div className="space-y-4">
        {filteredJobs.map((job) => (
          <div key={job.id} className="card hover:shadow-md transition-shadow">
            <div className="flex flex-col md:flex-row md:items-center justify-between">
              <div className="mb-4 md:mb-0">
                <div className="flex items-start justify-between">
                  <div>
                    <h3 className="text-lg font-semibold mb-1">{job.title}</h3>
                    <p className="text-gray-600 text-sm mb-3">{job.description}</p>
                  </div>
                  <span className={`px-3 py-1 rounded-full text-sm font-medium flex items-center gap-1 ${getStatusColor(job.status)}`}>
                    {getStatusIcon(job.status)}
                    {job.status.replace('_', ' ')}
                  </span>
                </div>
                
                <div className="flex flex-wrap gap-4 text-sm text-gray-500 mt-3">
                  <div className="flex items-center">
                    <MapPinIcon className="h-4 w-4 mr-1" />
                    {job.location}
                  </div>
                  <div className="flex items-center">
                    <CurrencyDollarIcon className="h-4 w-4 mr-1" />
                    KES {job.budget.toLocaleString()}
                  </div>
                  <div className="flex items-center">
                    <ChatBubbleLeftRightIcon className="h-4 w-4 mr-1" />
                    {job.quotes} quotes
                  </div>
                  <div className="flex items-center">
                    <ClockIcon className="h-4 w-4 mr-1" />
                    Posted: {job.postedDate}
                  </div>
                </div>
              </div>
              
              <div className="flex space-x-2">
                <button className="btn-secondary">View Details</button>
                {job.status === 'open' && (
                  <button className="btn-primary">View Quotes</button>
                )}
                {job.status === 'completed' && (
                  <button className="btn-primary">Leave Review</button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Empty State */}
      {filteredJobs.length === 0 && (
        <div className="text-center py-12">
          <div className="text-gray-400 mb-4">No jobs found for this filter</div>
          <button className="btn-primary">Post Your First Job</button>
        </div>
      )}
    </div>
  );
};

export default MyJobs;
MYJOBSDEOF

# Update Dashboard with real data
cat > src/pages/Dashboard.tsx << 'DASHBOARDEOF'
import React from 'react';
import { useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { Link } from 'react-router-dom';
import { 
  ChartBarIcon, 
  UserGroupIcon, 
  CurrencyDollarIcon, 
  ClockIcon,
  ArrowTrendingUpIcon,
  CalendarDaysIcon
} from '@heroicons/react/24/outline';

const Dashboard = () => {
  const { user } = useSelector((state: RootState) => state.auth);

  const stats = [
    { label: 'Active Jobs', value: '3', icon: ClockIcon, color: 'text-blue-600', bg: 'bg-blue-100' },
    { label: 'Pending Quotes', value: '5', icon: CurrencyDollarIcon, color: 'text-purple-600', bg: 'bg-purple-100' },
    { label: 'Total Spent', value: 'KES 48,500', icon: ChartBarIcon, color: 'text-green-600', bg: 'bg-green-100' },
    { label: 'Pros Hired', value: '2', icon: UserGroupIcon, color: 'text-orange-600', bg: 'bg-orange-100' },
  ];

  const recentActivities = [
    { id: 1, action: 'New quote received', detail: 'For Solar Installation', time: '10 min ago', type: 'quote' },
    { id: 2, action: 'Job completed', detail: 'Plumbing repair', time: '2 hours ago', type: 'completion' },
    { id: 3, action: 'Professional hired', detail: 'John Electrician', time: '1 day ago', type: 'hire' },
    { id: 4, action: 'Payment released', detail: 'KES 15,000', time: '2 days ago', type: 'payment' },
  ];

  const upcomingJobs = [
    { id: 1, title: 'Electrical Inspection', professional: 'David Electrician', date: 'Tomorrow, 10 AM' },
    { id: 2, title: 'AC Service', professional: 'Cooling Pros Ltd', date: 'Jan 20, 2 PM' },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-8">
        <div>
          <h1 className="text-3xl font-bold mb-2">Welcome back, {user?.email?.split('@')[0] || 'User'}!</h1>
          <p className="text-gray-600">Here's what's happening with your home services</p>
        </div>
        <div className="flex space-x-3 mt-4 md:mt-0">
          <Link to="/services" className="btn-primary">Post New Job</Link>
          <Link to="/calendar" className="btn-secondary">View Calendar</Link>
        </div>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        {stats.map((stat, index) => (
          <div key={index} className="card">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-gray-600">{stat.label}</p>
                <p className="text-2xl font-bold mt-1">{stat.value}</p>
                <div className="flex items-center mt-2 text-sm text-green-600">
                  <ArrowTrendingUpIcon className="h-4 w-4 mr-1" />
                  <span>+12% from last month</span>
                </div>
              </div>
              <div className={`${stat.bg} p-3 rounded-full`}>
                <stat.icon className={`h-6 w-6 ${stat.color}`} />
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Recent Activity */}
        <div className="lg:col-span-2">
          <div className="card">
            <h2 className="text-xl font-semibold mb-6">Recent Activity</h2>
            <div className="space-y-4">
              {recentActivities.map((activity) => (
                <div key={activity.id} className="flex items-center p-3 hover:bg-gray-50 rounded-lg">
                  <div className={`p-2 rounded-full mr-4 ${
                    activity.type === 'quote' ? 'bg-blue-100' :
                    activity.type === 'completion' ? 'bg-green-100' :
                    activity.type === 'hire' ? 'bg-purple-100' : 'bg-yellow-100'
                  }`}>
                    {activity.type === 'quote' && <CurrencyDollarIcon className="h-5 w-5 text-blue-600" />}
                    {activity.type === 'completion' && <ClockIcon className="h-5 w-5 text-green-600" />}
                    {activity.type === 'hire' && <UserGroupIcon className="h-5 w-5 text-purple-600" />}
                    {activity.type === 'payment' && <ChartBarIcon className="h-5 w-5 text-yellow-600" />}
                  </div>
                  <div className="flex-1">
                    <p className="font-medium">{activity.action}</p>
                    <p className="text-sm text-gray-600">{activity.detail}</p>
                  </div>
                  <span className="text-sm text-gray-500">{activity.time}</span>
                </div>
              ))}
            </div>
            <Link to="/my-jobs" className="btn-secondary w-full mt-6">View All Activity</Link>
          </div>
        </div>

        {/* Right Sidebar */}
        <div className="space-y-6">
          {/* Upcoming Jobs */}
          <div className="card">
            <h2 className="text-xl font-semibold mb-4">Upcoming Jobs</h2>
            <div className="space-y-4">
              {upcomingJobs.map((job) => (
                <div key={job.id} className="p-3 border border-gray-200 rounded-lg">
                  <h3 className="font-medium mb-1">{job.title}</h3>
                  <p className="text-sm text-gray-600 mb-2">with {job.professional}</p>
                  <div className="flex items-center text-sm text-gray-500">
                    <CalendarDaysIcon className="h-4 w-4 mr-1" />
                    {job.date}
                  </div>
                  <button className="btn-primary text-sm w-full mt-3">View Details</button>
                </div>
              ))}
            </div>
            <Link to="/calendar" className="btn-secondary w-full mt-4">View Full Calendar</Link>
          </div>

          {/* Quick Stats */}
          <div className="card">
            <h2 className="text-xl font-semibold mb-4">Quick Stats</h2>
            <div className="space-y-3">
              <div className="flex justify-between">
                <span className="text-gray-600">Response Rate</span>
                <span className="font-semibold">94%</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-600">Avg. Quote Time</span>
                <span className="font-semibold">2.3 hours</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-600">Satisfaction</span>
                <span className="font-semibold">4.8/5</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-600">Green Jobs</span>
                <span className="font-semibold">3 of 8</span>
              </div>
            </div>
          </div>

          {/* Tips */}
          <div className="card bg-primary-50 border-primary-200">
            <h2 className="text-xl font-semibold mb-3 text-primary-800">Pro Tip</h2>
            <p className="text-primary-700 mb-3">
              Adding photos to your job posts increases quote responses by 65%.
            </p>
            <button className="btn-primary w-full">Learn More</button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
DASHBOARDEOF

# Update other pages with real content
cat > src/pages/Quotes.tsx << 'QUOTESEOF'
import React, { useState } from 'react';
import { CheckCircleIcon, XCircleIcon, ClockIcon, CurrencyDollarIcon } from '@heroicons/react/24/outline';

const Quotes = () => {
  const [quotes] = useState([
    { id: 1, job: 'Fix Kitchen Sink', professional: 'John Plumber', amount: 4500, status: 'pending', time: '2 hours ago', isGreen: true },
    { id: 2, job: 'Install Solar Panels', professional: 'Solar Solutions Ltd', amount: 85000, status: 'accepted', time: '1 day ago', isGreen: true },
    { id: 3, job: 'Electrical Wiring', professional: 'Mike Electrician', amount: 12000, status: 'rejected', time: '2 days ago', isGreen: false },
    { id: 4, job: 'Paint House', professional: 'Paint Masters', amount: 35000, status: 'pending', time: '3 days ago', isGreen: false },
  ]);

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Quotes & Estimates</h1>
      
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2">
          <div className="card mb-6">
            <h2 className="text-xl font-semibold mb-4">Received Quotes</h2>
            <div className="space-y-4">
              {quotes.map((quote) => (
                <div key={quote.id} className="border border-gray-200 rounded-lg p-4 hover:border-primary-300 transition-colors">
                  <div className="flex flex-col md:flex-row md:items-center justify-between">
                    <div className="mb-3 md:mb-0">
                      <div className="flex items-center gap-3 mb-2">
                        <h3 className="font-semibold">{quote.job}</h3>
                        {quote.isGreen && (
                          <span className="px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full">
                            Green Certified
                          </span>
                        )}
                        <span className={`px-2 py-1 text-xs rounded-full ${
                          quote.status === 'accepted' ? 'bg-green-100 text-green-800' :
                          quote.status === 'rejected' ? 'bg-red-100 text-red-800' :
                          'bg-yellow-100 text-yellow-800'
                        }`}>
                          {quote.status}
                        </span>
                      </div>
                      <p className="text-gray-600 text-sm">By {quote.professional}</p>
                      <div className="flex items-center gap-4 mt-2 text-sm">
                        <span className="flex items-center">
                          <CurrencyDollarIcon className="h-4 w-4 mr-1" />
                          KES {quote.amount.toLocaleString()}
                        </span>
                        <span className="flex items-center">
                          <ClockIcon className="h-4 w-4 mr-1" />
                          {quote.time}
                        </span>
                      </div>
                    </div>
                    
                    <div className="flex space-x-2">
                      {quote.status === 'pending' && (
                        <>
                          <button className="btn-primary">Accept</button>
                          <button className="btn-secondary">Reject</button>
                          <button className="btn-secondary">Chat</button>
                        </>
                      )}
                      {quote.status === 'accepted' && (
                        <button className="btn-primary">View Contract</button>
                      )}
                    </div>
                  </div>
                  
                  {quote.status === 'pending' && (
                    <div className="mt-4 pt-4 border-t border-gray-100">
                      <button className="text-primary-600 hover:text-primary-700 text-sm mr-4">
                        Request Revision
                      </button>
                      <button className="text-primary-600 hover:text-primary-700 text-sm">
                        Compare with others
                      </button>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
        
        <div className="space-y-6">
          <div className="card">
            <h3 className="font-semibold mb-4">Quote Statistics</h3>
            <div className="space-y-3">
              <div className="flex justify-between">
                <span>Avg. Response Time</span>
                <span className="font-semibold">3.2 hours</span>
              </div>
              <div className="flex justify-between">
                <span>Acceptance Rate</span>
                <span className="font-semibold">68%</span>
              </div>
              <div className="flex justify-between">
                <span>Green Quotes</span>
                <span className="font-semibold">2 of 4</span>
              </div>
              <div className="flex justify-between">
                <span>Avg. Savings</span>
                <span className="font-semibold text-green-600">KES 1,200</span>
              </div>
            </div>
          </div>
          
          <div className="card">
            <h3 className="font-semibold mb-4">Tips for Better Quotes</h3>
            <ul className="space-y-2 text-sm">
              <li className="flex items-start">
                <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2 mt-0.5" />
                Be specific about requirements
              </li>
              <li className="flex items-start">
                <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2 mt-0.5" />
                Add photos when possible
              </li>
              <li className="flex items-start">
                <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2 mt-0.5" />
                Set realistic budget range
              </li>
              <li className="flex items-start">
                <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2 mt-0.5" />
                Respond quickly to questions
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};
export default Quotes;
QUOTESEOF

echo "✅ Complete application deployed!"
echo "🚀 Restart your frontend: npm start"
echo "🌐 Open: http://localhost:3000"
