<script setup lang="ts">
import { supabase } from '@/lib/supabaseClient'
import { ref } from 'vue'
const projects = ref([])
;(async () => {
  const { data, error } = await supabase.from('projects').select()
  if (error) {
    console.error('Error fetching projects:', error)
  } else {
    projects.value = data
  }
})()
</script>

<template>
  <main>home Page</main>
  <RouterLink to="/projects">Go to Projects</RouterLink>
  <div v-if="projects">{{ projects }}</div>
</template>
