import { defineConfig } from 'vite'
import tailwindcss from "@tailwindcss/vite";
import path from 'path'

// Determine the Mix environment
const mixEnv = process.env.MIX_ENV || 'dev'

export default defineConfig({
  server: {
    port: 5173,
    strictPort: true,
    cors: { origin: "http://localhost:4000" },
    watch: {
      // Watch the phoenix-colocated directory for changes
      ignored: ['!**/_build/dev/phoenix-colocated/**']
    }
  },
  build: {
    manifest: true,
    rollupOptions: {
      input: ["js/app.js", "css/app.css"],
    },
    outDir: "../priv/static",
    emptyOutDir: true,
  },
  resolve: {
    alias: {
      'phoenix-colocated': path.resolve(__dirname, `../_build/${mixEnv}/phoenix-colocated`),
      '@': path.resolve(__dirname, '.'),
    }
  },
  plugins: [tailwindcss()]
});
