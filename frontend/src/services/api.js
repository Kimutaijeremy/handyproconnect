import axios from 'axios';

const API_URL = 'http://localhost:8000/api/v1';

const api = axios.create({
  baseURL: API_URL,
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

export const authAPI = {
  login: async (email, password) => {
    // FastAPI OAuth2PasswordRequestForm expects form-urlencoded
    const params = new URLSearchParams();
    params.append('username', email);
    params.append('password', password);
    
    const response = await api.post('/auth/login', params, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    });
    return response.data;
  },
  register: async (userData) => {
    const response = await api.post('/auth/register', userData);
    return response.data;
  },
  getProfile: async () => {
    const response = await api.get('/auth/me');
    return response.data;
  },
};

export const jobsAPI = {
  getJobs: async () => {
    const response = await api.get('/jobs/');
    return response.data;
  },
  createJob: async (jobData) => {
    const response = await api.post('/jobs/', jobData);
    return response.data;
  },
  getOpenJobs: async () => {
    const response = await api.get('/jobs/open');
    return response.data;
  },
};

export const quotesAPI = {
  getQuotes: async () => {
    const response = await api.get('/quotes/');
    return response.data;
  },
  createQuote: async (jobId, amount, notes) => {
    const response = await api.post(`/quotes/${jobId}?amount=${amount}&notes=${notes}`);
    return response.data;
  },
};

export const servicesAPI = {
  getServices: async () => {
    const response = await api.get('/services/');
    return response.data;
  },
};

export default api;
