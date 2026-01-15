import React, { useState, useEffect } from 'react';
import { useSelector } from 'react-redux';
import { jobsAPI, quotesAPI } from '../services/api';
import { 
  MagnifyingGlassIcon, FunnelIcon, 
  CurrencyDollarIcon, MapPinIcon, ClockIcon,
  FireIcon, CheckCircleIcon
} from '@heroicons/react/24/outline';

const ProJobs = () => {
  const { user } = useSelector((state) => state.auth);
  const [jobs, setJobs] = useState([]);
  const [filteredJobs, setFilteredJobs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [filters, setFilters] = useState({
    urgency: 'all',
    service: 'all',
    minBudget: '',
    maxBudget: ''
  });

  useEffect(() => {
    fetchOpenJobs();
  }, []);

  useEffect(() => {
    filterJobs();
  }, [jobs, searchTerm, filters]);

  const fetchOpenJobs = async () => {
    try {
      setLoading(true);
      const data = await jobsAPI.getOpenJobs();
      setJobs(data);
      setFilteredJobs(data);
    } catch (error) {
      console.error('Error fetching open jobs:', error);
    } finally {
      setLoading(false);
    }
  };

  const filterJobs = () => {
    let filtered = [...jobs];

    // Search filter
    if (searchTerm) {
      filtered = filtered.filter(job =>
        job.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        job.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
        job.location.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }

    // Urgency filter
    if (filters.urgency !== 'all') {
      filtered = filtered.filter(job => job.urgency === filters.urgency);
    }

    // Service filter
    if (filters.service !== 'all') {
      filtered = filtered.filter(job => job.service_id === parseInt(filters.service));
    }

    // Budget filters
    if (filters.minBudget) {
      filtered = filtered.filter(job => 
        job.budget_min >= parseFloat(filters.minBudget) ||
        (job.budget_max && job.budget_max >= parseFloat(filters.minBudget))
      );
    }

    if (filters.maxBudget) {
      filtered = filtered.filter(job => 
        (job.budget_max && job.budget_max <= parseFloat(filters.maxBudget)) ||
        (job.budget_min && job.budget_min <= parseFloat(filters.maxBudget))
      );
    }

    setFilteredJobs(filtered);
  };

  const handleSubmitQuote = async (jobId) => {
    const amount = prompt('Enter your quote amount:');
    const notes = prompt('Enter any notes:');
    if (amount) {
      try {
        await quotesAPI.createQuote(jobId, parseFloat(amount), notes || '');
        alert('Quote submitted successfully!');
      } catch (error) {
        console.error('Error submitting quote:', error);
        alert('Failed to submit quote');
      }
    }
  };

  const getUrgencyColor = (urgency) => {
    switch (urgency) {
      case 'emergency': return 'bg-red-500/20 text-red-300 border-red-500/30';
      case 'urgent': return 'bg-orange-500/20 text-orange-300 border-orange-500/30';
      case 'normal': return 'bg-blue-500/20 text-blue-300 border-blue-500/30';
      default: return 'bg-gray-500/20 text-gray-300 border-gray-500/30';
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-white">Loading available jobs...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 pt-20 pb-12">
      <div className="max-w-7xl mx-auto px-6">
        {/* Header */}
        <div className="mb-8">
          <h1 className="font-display text-4xl text-white mb-3">Find Available Jobs</h1>
          <p className="text-white/60">
            Browse and bid on jobs that match your skills and expertise
          </p>
        </div>

        {/* Search and Filter Bar */}
        <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 mb-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-4">
            {/* Search */}
            <div className="lg:col-span-4">
              <div className="relative">
                <MagnifyingGlassIcon className="absolute left-4 top-1/2 transform -translate-y-1/2 h-5 w-5 text-white/50" />
                <input
                  type="text"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="w-full bg-white/10 border border-white/20 rounded-xl pl-12 pr-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                  placeholder="Search jobs by title, description, or location"
                />
              </div>
            </div>

            {/* Filters */}
            <div className="lg:col-span-8 grid grid-cols-1 md:grid-cols-4 gap-4">
              <div>
                <select
                  value={filters.urgency}
                  onChange={(e) => setFilters({...filters, urgency: e.target.value})}
                  className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                >
                  <option value="all">All Urgency</option>
                  <option value="emergency">Emergency</option>
                  <option value="urgent">Urgent</option>
                  <option value="normal">Normal</option>
                  <option value="low">Low</option>
                </select>
              </div>

              <div>
                <select
                  value={filters.service}
                  onChange={(e) => setFilters({...filters, service: e.target.value})}
                  className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                >
                  <option value="all">All Services</option>
                  <option value="1">Electrical</option>
                  <option value="2">Plumbing</option>
                  <option value="3">Handyman</option>
                  <option value="4">Green Solutions</option>
                </select>
              </div>

              <div>
                <input
                  type="number"
                  value={filters.minBudget}
                  onChange={(e) => setFilters({...filters, minBudget: e.target.value})}
                  className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                  placeholder="Min Budget"
                />
              </div>

              <div>
                <input
                  type="number"
                  value={filters.maxBudget}
                  onChange={(e) => setFilters({...filters, maxBudget: e.target.value})}
                  className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                  placeholder="Max Budget"
                />
              </div>
            </div>
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-white/60 text-sm">Available Jobs</p>
                <p className="text-3xl font-display text-white mt-2">{filteredJobs.length}</p>
              </div>
              <div className="p-3 rounded-xl bg-blue-500/20">
                <MagnifyingGlassIcon className="h-6 w-6 text-blue-400" />
              </div>
            </div>
          </div>

          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-white/60 text-sm">Emergency Jobs</p>
                <p className="text-3xl font-display text-white mt-2">
                  {jobs.filter(job => job.urgency === 'emergency').length}
                </p>
              </div>
              <div className="p-3 rounded-xl bg-red-500/20">
                <FireIcon className="h-6 w-6 text-red-400" />
              </div>
            </div>
          </div>

          <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-white/60 text-sm">Total Jobs</p>
                <p className="text-3xl font-display text-white mt-2">{jobs.length}</p>
              </div>
              <div className="p-3 rounded-xl bg-green-500/20">
                <CheckCircleIcon className="h-6 w-6 text-green-400" />
              </div>
            </div>
          </div>
        </div>

        {/* Jobs Grid */}
        {filteredJobs.length === 0 ? (
          <div className="text-center py-12">
            <div className="text-white/60 mb-4">No jobs found matching your criteria</div>
            <button 
              onClick={() => {
                setSearchTerm('');
                setFilters({
                  urgency: 'all',
                  service: 'all',
                  minBudget: '',
                  maxBudget: ''
                });
              }}
              className="text-purple-400 hover:text-purple-300"
            >
              Clear all filters
            </button>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredJobs.map(job => (
              <div key={job.id} className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6 hover:border-purple-500/50 transition-all">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="text-xl font-display text-white mb-2">{job.title}</h3>
                    <div className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-xs border ${getUrgencyColor(job.urgency)}`}>
                      {job.urgency === 'emergency' && <FireIcon className="h-3 w-3" />}
                      {job.urgency.charAt(0).toUpperCase() + job.urgency.slice(1)}
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-white font-medium">
                      ${job.budget_min || '?'} - ${job.budget_max || '?'}
                    </div>
                    <div className="text-white/60 text-sm">Budget</div>
                  </div>
                </div>

                <p className="text-white/70 mb-6 line-clamp-3">{job.description}</p>

                <div className="space-y-3 mb-6">
                  <div className="flex items-center gap-2 text-white/60">
                    <MapPinIcon className="h-4 w-4" />
                    <span className="text-sm">{job.location}</span>
                  </div>
                  <div className="flex items-center gap-2 text-white/60">
                    <ClockIcon className="h-4 w-4" />
                    <span className="text-sm">Posted {new Date(job.created_at).toLocaleDateString()}</span>
                  </div>
                  <div className="flex items-center gap-2 text-white/60">
                    <CurrencyDollarIcon className="h-4 w-4" />
                    <span className="text-sm">By {job.customer_name}</span>
                  </div>
                </div>

                <div className="flex gap-3">
                  <button
                    onClick={() => handleSubmitQuote(job.id)}
                    className="flex-1 py-3 rounded-xl bg-gradient-to-r from-pink-500 to-purple-600 text-white hover:shadow-xl transition-all"
                  >
                    Submit Quote
                  </button>
                  <button className="px-4 py-3 rounded-xl border border-white/20 text-white hover:border-purple-500 transition-colors">
                    Save
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default ProJobs;
