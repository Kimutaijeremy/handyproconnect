import React, { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { Link } from 'react-router-dom';
import { jobsAPI, quotesAPI, servicesAPI } from '../services/api';
import { 
  UserCircleIcon, WrenchScrewdriverIcon, 
  CurrencyDollarIcon, ClockIcon, CheckCircleIcon,
  PlusIcon, MagnifyingGlassIcon, ChatBubbleLeftRightIcon
} from '@heroicons/react/24/outline';

const Dashboard = () => {
  const { user } = useSelector((state) => state.auth);
  const [jobs, setJobs] = useState([]);
  const [quotes, setQuotes] = useState([]);
  const [services, setServices] = useState([]);
  const [loading, setLoading] = useState(true);
  const [newJob, setNewJob] = useState({
    title: '',
    description: '',
    location: '',
    urgency: 'normal',
    budget_min: '',
    budget_max: '',
    service_id: ''
  });

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      const [jobsData, quotesData, servicesData] = await Promise.all([
        jobsAPI.getJobs(),
        quotesAPI.getQuotes(),
        servicesAPI.getServices()
      ]);
      setJobs(jobsData);
      setQuotes(quotesData);
      setServices(servicesData);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleCreateJob = async (e) => {
    e.preventDefault();
    try {
      await jobsAPI.createJob({
        ...newJob,
        budget_min: newJob.budget_min ? parseFloat(newJob.budget_min) : undefined,
        budget_max: newJob.budget_max ? parseFloat(newJob.budget_max) : undefined,
        service_id: newJob.service_id ? parseInt(newJob.service_id) : undefined
      });
      setNewJob({
        title: '',
        description: '',
        location: '',
        urgency: 'normal',
        budget_min: '',
        budget_max: '',
        service_id: ''
      });
      fetchDashboardData();
    } catch (error) {
      console.error('Error creating job:', error);
    }
  };

  const handleSubmitQuote = async (jobId) => {
    const amount = prompt('Enter your quote amount:');
    const notes = prompt('Enter any notes:');
    if (amount) {
      try {
        await quotesAPI.createQuote(jobId, parseFloat(amount), notes || '');
        fetchDashboardData();
      } catch (error) {
        console.error('Error submitting quote:', error);
      }
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-white">Loading dashboard...</div>
      </div>
    );
  }

  const isProfessional = user?.role === 'professional';
  const myJobs = isProfessional ? jobs : jobs.filter(job => job.customer_id === user?.id);
  const myQuotes = quotes.filter(quote => 
    isProfessional ? quote.professional_id === user?.id : quote.customer_id === user?.id
  );

  return (
    <div className="min-h-screen bg-gray-900">
      <div className="max-w-7xl mx-auto px-6 py-12">
        {/* Dashboard Header */}
        <div className="mb-12">
          <div className="flex items-center justify-between mb-8">
            <div>
              <h1 className="font-display text-4xl text-white mb-2">
                Welcome back, {user?.full_name || user?.email?.split('@')[0]}
              </h1>
              <p className="text-white/60">
                {isProfessional 
                  ? 'Browse available jobs and manage your quotes' 
                  : 'Manage your home projects and get quotes from professionals'
                }
              </p>
            </div>
            <div className="flex items-center gap-4">
              <div className="px-4 py-2 rounded-full bg-purple-500/20 text-purple-300">
                {isProfessional ? 'Professional' : 'Homeowner'}
              </div>
              <div className="w-12 h-12 rounded-full bg-gradient-to-br from-pink-500 to-purple-600 flex items-center justify-center">
                <UserCircleIcon className="h-6 w-6 text-white" />
              </div>
            </div>
          </div>

          {/* Stats Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-white/60 text-sm">Active Jobs</p>
                  <p className="text-3xl font-display text-white mt-2">
                    {myJobs.filter(job => job.status === 'open').length}
                  </p>
                </div>
                <div className="p-3 rounded-xl bg-blue-500/20">
                  <WrenchScrewdriverIcon className="h-6 w-6 text-blue-400" />
                </div>
              </div>
            </div>
            
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-white/60 text-sm">{isProfessional ? 'My Quotes' : 'Received Quotes'}</p>
                  <p className="text-3xl font-display text-white mt-2">{myQuotes.length}</p>
                </div>
                <div className="p-3 rounded-xl bg-green-500/20">
                  <CurrencyDollarIcon className="h-6 w-6 text-green-400" />
                </div>
              </div>
            </div>
            
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-white/60 text-sm">{isProfessional ? 'Completed Jobs' : 'Hired Professionals'}</p>
                  <p className="text-3xl font-display text-white mt-2">
                    {myJobs.filter(job => job.status === 'completed').length}
                  </p>
                </div>
                <div className="p-3 rounded-xl bg-yellow-500/20">
                  <CheckCircleIcon className="h-6 w-6 text-yellow-400" />
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Main Content */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left Column - Job Creation/Professional Job Browsing */}
          <div className="lg:col-span-2 space-y-8">
            {isProfessional ? (
              <>
                {/* Professional: Available Jobs */}
                <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
                  <div className="flex items-center justify-between mb-6">
                    <h2 className="text-2xl font-display text-white">Available Jobs</h2>
                    <Link to="/pro/jobs" className="text-purple-400 hover:text-purple-300 flex items-center gap-2">
                      View all <MagnifyingGlassIcon className="h-4 w-4" />
                    </Link>
                  </div>
                  <div className="space-y-4">
                    {jobs.filter(job => job.status === 'open').slice(0, 3).map(job => (
                      <div key={job.id} className="bg-white/5 rounded-xl p-4 border border-white/10">
                        <div className="flex justify-between items-start">
                          <div>
                            <h3 className="text-white font-medium">{job.title}</h3>
                            <p className="text-white/60 text-sm mt-1">{job.description.substring(0, 100)}...</p>
                            <div className="flex items-center gap-4 mt-3">
                              <span className="text-xs px-2 py-1 rounded-full bg-blue-500/20 text-blue-300">
                                {job.urgency}
                              </span>
                              <span className="text-white/50 text-sm">{job.location}</span>
                            </div>
                          </div>
                          <button
                            onClick={() => handleSubmitQuote(job.id)}
                            className="px-4 py-2 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-sm hover:shadow-xl transition-all"
                          >
                            Submit Quote
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                {/* Professional: My Quotes */}
                <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
                  <h2 className="text-2xl font-display text-white mb-6">My Recent Quotes</h2>
                  <div className="space-y-4">
                    {myQuotes.slice(0, 3).map(quote => (
                      <div key={quote.id} className="bg-white/5 rounded-xl p-4 border border-white/10">
                        <div className="flex justify-between items-center">
                          <div>
                            <h3 className="text-white font-medium">Quote #{quote.id}</h3>
                            <p className="text-white/60 text-sm mt-1">Amount: ${quote.amount}</p>
                            <span className={`text-xs px-2 py-1 rounded-full mt-2 ${
                              quote.status === 'accepted' ? 'bg-green-500/20 text-green-300' :
                              quote.status === 'rejected' ? 'bg-red-500/20 text-red-300' :
                              'bg-yellow-500/20 text-yellow-300'
                            }`}>
                              {quote.status}
                            </span>
                          </div>
                          <ChatBubbleLeftRightIcon className="h-5 w-5 text-white/50" />
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </>
            ) : (
              <>
                {/* Homeowner: Create New Job */}
                <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
                  <h2 className="text-2xl font-display text-white mb-6">Post a New Job</h2>
                  <form onSubmit={handleCreateJob} className="space-y-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                      <div>
                        <label className="text-sm text-white/70 mb-2 block">Job Title</label>
                        <input
                          type="text"
                          value={newJob.title}
                          onChange={(e) => setNewJob({...newJob, title: e.target.value})}
                          className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                          placeholder="e.g., Fix leaking faucet"
                          required
                        />
                      </div>
                      <div>
                        <label className="text-sm text-white/70 mb-2 block">Location</label>
                        <input
                          type="text"
                          value={newJob.location}
                          onChange={(e) => setNewJob({...newJob, location: e.target.value})}
                          className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                          placeholder="e.g., Nairobi, Westlands"
                          required
                        />
                      </div>
                    </div>
                    
                    <div>
                      <label className="text-sm text-white/70 mb-2 block">Description</label>
                      <textarea
                        value={newJob.description}
                        onChange={(e) => setNewJob({...newJob, description: e.target.value})}
                        className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                        rows="3"
                        placeholder="Describe the job in detail..."
                        required
                      />
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                      <div>
                        <label className="text-sm text-white/70 mb-2 block">Urgency</label>
                        <select
                          value={newJob.urgency}
                          onChange={(e) => setNewJob({...newJob, urgency: e.target.value})}
                          className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                        >
                          <option value="low">Low</option>
                          <option value="normal">Normal</option>
                          <option value="urgent">Urgent</option>
                          <option value="emergency">Emergency</option>
                        </select>
                      </div>
                      <div>
                        <label className="text-sm text-white/70 mb-2 block">Min Budget ($)</label>
                        <input
                          type="number"
                          value={newJob.budget_min}
                          onChange={(e) => setNewJob({...newJob, budget_min: e.target.value})}
                          className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                          placeholder="Min"
                        />
                      </div>
                      <div>
                        <label className="text-sm text-white/70 mb-2 block">Max Budget ($)</label>
                        <input
                          type="number"
                          value={newJob.budget_max}
                          onChange={(e) => setNewJob({...newJob, budget_max: e.target.value})}
                          className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                          placeholder="Max"
                        />
                      </div>
                    </div>

                    <div>
                      <label className="text-sm text-white/70 mb-2 block">Service Type</label>
                      <select
                        value={newJob.service_id}
                        onChange={(e) => setNewJob({...newJob, service_id: e.target.value})}
                        className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                      >
                        <option value="">Select a service</option>
                        {services.map(service => (
                          <option key={service.id} value={service.id}>{service.name}</option>
                        ))}
                      </select>
                    </div>

                    <button
                      type="submit"
                      className="w-full py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-lg hover:shadow-xl transition-all"
                    >
                      <PlusIcon className="h-5 w-5 inline mr-2" />
                      Post Job
                    </button>
                  </form>
                </div>

                {/* Homeowner: My Active Jobs */}
                <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
                  <h2 className="text-2xl font-display text-white mb-6">My Active Jobs</h2>
                  <div className="space-y-4">
                    {myJobs.filter(job => job.status === 'open').slice(0, 3).map(job => (
                      <div key={job.id} className="bg-white/5 rounded-xl p-4 border border-white/10">
                        <div className="flex justify-between items-start">
                          <div>
                            <h3 className="text-white font-medium">{job.title}</h3>
                            <p className="text-white/60 text-sm mt-1">{job.description.substring(0, 100)}...</p>
                            <div className="flex items-center gap-4 mt-3">
                              <span className={`text-xs px-2 py-1 rounded-full ${
                                job.urgency === 'emergency' ? 'bg-red-500/20 text-red-300' :
                                job.urgency === 'urgent' ? 'bg-orange-500/20 text-orange-300' :
                                'bg-blue-500/20 text-blue-300'
                              }`}>
                                {job.urgency}
                              </span>
                              <span className="text-white/50 text-sm">{job.location}</span>
                            </div>
                          </div>
                          <div className="text-right">
                            <div className="text-white/60 text-sm">
                              {quotes.filter(q => q.job_id === job.id).length} quotes
                            </div>
                            <Link 
                              to={`/job/${job.id}`}
                              className="text-purple-400 hover:text-purple-300 text-sm mt-2 inline-block"
                            >
                              View details →
                            </Link>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </>
            )}
          </div>

          {/* Right Column - Quick Actions & Recent Activity */}
          <div className="space-y-8">
            {/* Quick Actions */}
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
              <h2 className="text-2xl font-display text-white mb-6">Quick Actions</h2>
              <div className="space-y-4">
                {isProfessional ? (
                  <>
                    <Link to="/pro/jobs" className="flex items-center gap-3 p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors">
                      <MagnifyingGlassIcon className="h-5 w-5 text-purple-400" />
                      <span className="text-white">Browse Available Jobs</span>
                    </Link>
                    <Link to="/quotes" className="flex items-center gap-3 p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors">
                      <CurrencyDollarIcon className="h-5 w-5 text-green-400" />
                      <span className="text-white">Manage My Quotes</span>
                    </Link>
                  </>
                ) : (
                  <>
                    <Link to="/services" className="flex items-center gap-3 p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors">
                      <WrenchScrewdriverIcon className="h-5 w-5 text-blue-400" />
                      <span className="text-white">Browse Services</span>
                    </Link>
                    <Link to="/jobs" className="flex items-center gap-3 p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors">
                      <PlusIcon className="h-5 w-5 text-purple-400" />
                      <span className="text-white">Post New Job</span>
                    </Link>
                  </>
                )}
                <Link to="/profile" className="flex items-center gap-3 p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors">
                  <UserCircleIcon className="h-5 w-5 text-yellow-400" />
                  <span className="text-white">Edit Profile</span>
                </Link>
              </div>
            </div>

            {/* Recent Quotes (for Homeowners) / My Performance (for Professionals) */}
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
              <h2 className="text-2xl font-display text-white mb-6">
                {isProfessional ? 'My Performance' : 'Recent Quotes'}
              </h2>
              {isProfessional ? (
                <div className="space-y-4">
                  <div className="text-center">
                    <div className="text-4xl font-display text-white mb-2">
                      {myQuotes.filter(q => q.status === 'accepted').length}
                    </div>
                    <div className="text-white/60">Accepted Quotes</div>
                  </div>
                  <div className="h-2 bg-white/10 rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-gradient-to-r from-green-500 to-emerald-600"
                      style={{ width: `${(myQuotes.filter(q => q.status === 'accepted').length / Math.max(myQuotes.length, 1)) * 100}%` }}
                    ></div>
                  </div>
                  <div className="text-sm text-white/60 text-center">
                    {myQuotes.filter(q => q.status === 'accepted').length} out of {myQuotes.length} quotes accepted
                  </div>
                </div>
              ) : (
                <div className="space-y-4">
                  {myQuotes.slice(0, 3).map(quote => (
                    <div key={quote.id} className="flex items-center justify-between p-3 rounded-xl bg-white/5">
                      <div>
                        <div className="text-white font-medium">${quote.amount}</div>
                        <div className="text-white/60 text-sm">from {quote.professional_name}</div>
                      </div>
                      <button className="text-sm px-3 py-1 rounded-full bg-purple-500/20 text-purple-300">
                        {quote.status}
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Services List */}
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
              <h2 className="text-2xl font-display text-white mb-6">Services</h2>
              <div className="space-y-3">
                {services.slice(0, 4).map(service => (
                  <div key={service.id} className="flex items-center justify-between p-3 rounded-xl bg-white/5 hover:bg-white/10 transition-colors">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 rounded-lg bg-purple-500/20 flex items-center justify-center">
                        <WrenchScrewdriverIcon className="h-4 w-4 text-purple-400" />
                      </div>
                      <span className="text-white">{service.name}</span>
                    </div>
                    <span className="text-xs px-2 py-1 rounded-full bg-white/10 text-white/60">
                      {service.category}
                    </span>
                  </div>
                ))}
              </div>
              <Link to="/services" className="text-center block mt-6 text-purple-400 hover:text-purple-300">
                View all services →
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
