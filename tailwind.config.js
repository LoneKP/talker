const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  theme: {
    fontFamily: {
      mono: ['IBM Plex Mono', ...defaultTheme.fontFamily.mono]
    },
    extend: {
      colors: {
        "blue": "#312783",
        "blue-dark": "#2B2272",
        "blue-darker": "#261E68",
        "red": "#A92F3E",
        "green": "#027540",
        "green-dark": "#026336",
        "green-darker": "#01542E",
        "beige": "#FDF4DD"
      }
    }
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ]
}
