module.exports = {
  content: [
    '../lib/*_web/**/*.*ex',
    "./ts/**/*.{js,ts}"
  ],
  safelist: [
    {
      pattern: /bg-(red|blue|green|emerald|purple)-(500|600)/,
      variants: ['hover', 'focus'],
    },
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
