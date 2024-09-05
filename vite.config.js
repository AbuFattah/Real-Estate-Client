import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  test: {
    coverage: {
      reporter: ['text', 'json', 'html'], // You can specify different coverage reporters
      include: ['src/**/*.{js,jsx,ts,tsx}'], // Include JS, JSX, TS, and TSX files
      exclude: ['src/**/*.test.{js,jsx,ts,tsx}'], // Exclude test files
    },
  },
})
