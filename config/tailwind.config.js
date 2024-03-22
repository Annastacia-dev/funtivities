const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        primary: '#5a0a0a',
        secondary: '#f48080'
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        'bagel': ['Bagel Fat One', 'cursive'],
        'balsamiq': ['Balsamiq Sans', 'cursive'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
