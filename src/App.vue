<template>
  <main>
    <RouterView />
  </main>
</template>

<script setup lang="ts">
import { supabase } from '@/lib/supabaseClient'

console.log('Supabase client initialized:', supabase)
</script>
