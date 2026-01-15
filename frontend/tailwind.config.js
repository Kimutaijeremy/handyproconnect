/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx}"],
  theme: {
    extend: {
      colors: {
        coral: '#ff6b6b',
        mint: '#4ecdc4',
      },
      fontFamily: {
        'display': ['Inter', 'system-ui'],
      },
    },
  },
  plugins: [],
}
