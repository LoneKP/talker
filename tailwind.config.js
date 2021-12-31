const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  theme: {
    fontFamily: {
      mono: ['IBM Plex Mono', ...defaultTheme.fontFamily.mono]
    },
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ]
}
