import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { jobsAPI, quotesAPI } from '../services/api';
import { 
  ArrowLeftIcon, MapPinIcon, ClockIcon, 
  UserCircleIcon, CurrencyDollarIcon,
  ChatBubbleLeftRightIcon, CheckCircleIcon,
  XCircleIcon
} from '@heroicons/react/24/outline';

const JobDetails = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useSelector((state) => state.auth);
  const [job, setJob] = useState(null);
  const [quotes, setQuotes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [newQuote, setNewQuote] = useState({ amount: '', notes: '' });

  useEffect(() => {
    fetchJobDetails();
  }, [id]);

  const fetchJobDetails = async () => {
    try {
      setLoading(true);
      const jobData = await jobsAPI.getJobs();
      const foundJob = jobData.find(j => j.id === parseInt(id));
      if (foundJob) {
        setJob(foundJob);
        
        // In a real app, we would have a specific endpoint for job quotes
        const quotesData = await quotesAPI.getQuotes();
        setQuotes(quotesData.filter(q => q.job_id === parseInt(id)));
      }
    } catch (error) {
      console.error('Error fetching job details:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmitQuote = async (e) => {
    e.preventDefault();
    if (!newQuote.amount) {
      alert('Please enter an amount');
      return;
    }
    
    try {
      await quotesAPI.createQuote(
        parseInt(id), 
        parseFloat(newQuote.amount), 
        newQuote.notes
      );
      setNewQuote({ amount: '', notes: '' });
      fetchJobDetails();
    } catch (error) {
      console.error('Error submitting quote:', error);
      alert('Failed to submit quote');
    }
  };

  const handleAcceptQuote = async (quoteId) => {
    if (window.confirm('Are you sure you want to accept this quote?')) {
      alert('Quote accepted! (In a real app, this would update the quote status)');
      fetchJobDetails();
    }
  };

  const handleRejectQuote = async (quoteId) => {
    if (window.confirm('Are you sure you want to reject this quote?')) {
      alert('Quote rejected! (In a real app, this would update the quote status)');
      fetchJobDetails();
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-white">Loading job details...</div>
      </div>
    );
  }

  if (!job) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-white">Job not found</div>
      </div>
    );
  }

  const isOwner = job.customer_id === user?.id;
  const isProfessional = user?.role === 'professional';
  const canSubmitQuote = isProfessional && !isOwner && job.status === 'open';

  return (
    <div className="min-h-screen bg-gray-900 pt-20 pb-12">
      <div className="max-w-6xl mx-auto px-6">
        {/* Back Button */}
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-white/60 hover:text-white mb-8"
        >
          <ArrowLeftIcon className="h-4 w-4" />
          Back
        </button>

        {/* Job Header */}
        <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8 mb-8">
          <div className="flex justify-between items-start mb-6">
            <div>
              <h1 className="font-display text-3xl text-white mb-2">{job.title}</h1>
              <div className="flex items-center gap-4">
                <span className={`px-3 py-1 rounded-full text-sm ${
                  job.urgency === 'emergency' ? 'bg-red-500/20 text-red-300' :
                  job.urgency === 'urgent' ? 'bg-orange-500/20 text-orange-300' :
                  'bg-blue-500/20 text-blue-300'
                }`}>
                  {job.urgency.charAt(0).toUpperCase() + job.urgency.slice(1)}
                </span>
                <span className={`px-3 py-1 rounded-full text-sm ${
                  job.status === 'open' ? 'bg-green-500/20 text-green-300' :
                  job.status === 'in_progress' ? 'bg-yellow-500/20 text-yellow-300' :
                  'bg-gray-500/20 text-gray-300'
                }`}>
                  {job.status.charAt(0).toUpperCase() + job.status.slice(1)}
                </span>
              </div>
            </div>
            
            <div className="text-right">
              <div className="text-2xl font-display text-white">
                ${job.budget_min || '?'} - ${job.budget_max || '?'}
              </div>
              <div className="text-white/60 text-sm">Budget Range</div>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div className="flex items-center gap-3">
              <div className="p-3 rounded-xl bg-white/10">
                <MapPinIcon className="h-5 w-5 text-white/60" />
              </div>
              <div>
                <div className="text-white/60 text-sm">Location</div>
                <div className="text-white">{job.location}</div>
              </div>
            </div>

            <div className="flex items-center gap-3">
              <div className="p-3 rounded-xl bg-white/10">
                <ClockIcon className="h-5 w-5 text-white/60" />
              </div>
              <div>
                <div className="text-white/60 text-sm">Posted</div>
                <div className="text-white">
                  {new Date(job.created_at).toLocaleDateString()}
                </div>
              </div>
            </div>

            <div className="flex items-center gap-3">
              <div className="p-3 rounded-xl bg-white/10">
                <UserCircleIcon className="h-5 w-5 text-white/60" />
              </div>
              <div>
                <div className="text-white/60 text-sm">Posted By</div>
                <div className="text-white">{job.customer_name}</div>
              </div>
            </div>
          </div>

          <div className="mb-6">
            <h2 className="text-xl font-display text-white mb-4">Job Description</h2>
            <p className="text-white/70 whitespace-pre-line">{job.description}</p>
          </div>

          {job.service_id && (
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-purple-500/20 text-purple-300">
              <span>Service ID: {job.service_id}</span>
            </div>
          )}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left Column - Quote Submission (for professionals) */}
          {canSubmitQuote && (
            <div className="lg:col-span-2">
              <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
                <h2 className="text-2xl font-display text-white mb-6">Submit a Quote</h2>
                <form onSubmit={handleSubmitQuote} className="space-y-6">
                  <div>
                    <label className="text-sm text-white/70 mb-2 block">Quote Amount ($)</label>
                    <input
                      type="number"
                      value={newQuote.amount}
                      onChange={(e) => setNewQuote({...newQuote, amount: e.target.value})}
                      className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                      placeholder="Enter your quote amount"
                      step="0.01"
                      required
                    />
                    <div className="text-white/50 text-sm mt-2">
                      Budget range: ${job.budget_min || 'Not specified'} - ${job.budget_max || 'Not specified'}
                    </div>
                  </div>

                  <div>
                    <label className="text-sm text-white/70 mb-2 block">Notes (Optional)</label>
                    <textarea
                      value={newQuote.notes}
                      onChange={(e) => setNewQuote({...newQuote, notes: e.target.value})}
                      className="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white focus:border-purple-500 focus:ring-0"
                      rows="4"
                      placeholder="Add any notes about your quote, timeline, or approach..."
                    />
                  </div>

                  <button
                    type="submit"
                    className="w-full py-4 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 text-white text-lg hover:shadow-xl transition-all"
                  >
                    Submit Quote
                  </button>
                </form>
              </div>
            </div>
          )}

          {/* Right Column - Quotes List */}
          <div className={canSubmitQuote ? 'lg:col-span-1' : 'lg:col-span-3'}>
            <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8">
              <div className="flex items-center justify-between mb-6">
                <h2 className="text-2xl font-display text-white">Quotes</h2>
                <div className="text-white/60">{quotes.length} submitted</div>
              </div>

              {quotes.length === 0 ? (
                <div className="text-center py-8">
                  <ChatBubbleLeftRightIcon className="h-12 w-12 text-white/30 mx-auto mb-4" />
                  <div className="text-white/60">No quotes submitted yet</div>
                  {!isOwner && !isProfessional && (
                    <div className="text-white/50 text-sm mt-2">
                      Be the first to submit a quote!
                    </div>
                  )}
                </div>
              ) : (
                <div className="space-y-4">
                  {quotes.map(quote => (
                    <div key={quote.id} className="bg-white/5 rounded-xl p-4 border border-white/10">
                      <div className="flex justify-between items-start mb-3">
                        <div>
                          <div className="text-white font-medium">${quote.amount}</div>
                          <div className="text-white/60 text-sm">by {quote.professional_name}</div>
                        </div>
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          quote.status === 'accepted' ? 'bg-green-500/20 text-green-300' :
                          quote.status === 'rejected' ? 'bg-red-500/20 text-red-300' :
                          'bg-yellow-500/20 text-yellow-300'
                        }`}>
                          {quote.status}
                        </span>
                      </div>
                      
                      {quote.notes && (
                        <p className="text-white/70 text-sm mb-3">{quote.notes}</p>
                      )}
                      
                      <div className="text-white/50 text-xs">
                        Submitted {new Date(quote.created_at).toLocaleDateString()}
                      </div>

                      {isOwner && quote.status === 'pending' && (
                        <div className="flex gap-2 mt-3">
                          <button
                            onClick={() => handleAcceptQuote(quote.id)}
                            className="flex-1 py-2 rounded-lg bg-green-500/20 text-green-300 hover:bg-green-500/30 transition-colors text-sm"
                          >
                            <CheckCircleIcon className="h-4 w-4 inline mr-1" />
                            Accept
                          </button>
                          <button
                            onClick={() => handleRejectQuote(quote.id)}
                            className="flex-1 py-2 rounded-lg bg-red-500/20 text-red-300 hover:bg-red-500/30 transition-colors text-sm"
                          >
                            <XCircleIcon className="h-4 w-4 inline mr-1" />
                            Reject
                          </button>
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Job Actions (for owner) */}
            {isOwner && (
              <div className="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl p-8 mt-8">
                <h2 className="text-2xl font-display text-white mb-6">Job Actions</h2>
                <div className="space-y-4">
                  <button className="w-full py-3 rounded-xl bg-gradient-to-r from-green-500 to-emerald-600 text-white hover:shadow-xl transition-all">
                    Mark as Completed
                  </button>
                  <button className="w-full py-3 rounded-xl border border-white/20 text-white hover:border-red-500 hover:text-red-300 transition-colors">
                    Cancel Job
                  </button>
                  <button className="w-full py-3 rounded-xl border border-white/20 text-white hover:border-purple-500 transition-colors">
                    Edit Job Details
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default JobDetails;
