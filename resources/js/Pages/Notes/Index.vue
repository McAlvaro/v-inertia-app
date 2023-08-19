<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import {Link, useForm, router} from "@inertiajs/vue3";
import { ref, watch } from 'vue';

 defineProps({
    notes: Array
});

const destroy = ( id ) => {
    if( confirm('Esta seguro de eliminar esta Nota ?') ) {

        useForm({}).delete(route('notes.destroy', id));

    }
}

const q = ref('');

watch( q, (value) => {
    router.get(route('notes.index', { q: value }), {}, { preserveState: true });
});

</script>

<template>
    <AppLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                Notas
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="md:grid md:grid-cols-3 md:gap-6">
                    <div class="md:col-span-1">
                        <div class="px-3 sm:px-0">
                            <h3 class="text-lg text-gray-900">Listado de Notas</h3>
                            <p class="text-sm text-gray-600">Toma el registro correcto y ejecuta cualquier función (ver, editar o eliminar)</p>

                        </div>
                    </div>
                    <div class="md:col-span-2">
                        <div class="shadow bg-white md:rounded-md p-4">
                            <div class="flex justify-between">

                                <input type="text" class="form-input rounded-md shadow-md" placeholder="Buscar..." v-model="q">
                                <Link class="bg-blue-500 text-white font-bold px-4 py-2 rounded-md" :href="route('notes.create')" >Crear Nota</Link>

                            </div>
                            <table class="mt-5">
                                <tr v-for="(note) in notes" :key="note.id">
                                    <td class="border px-4 py-2">
                                        {{ note.excerpt }}
                                    </td>
                                    <td class="px-4 py-2">
                                        <Link :href="route('notes.show', note.id)">
                                            <svg class="text-gray-400 hover:text-gray-600 h-4 w-4" fill="currentColor" viewBox="0 -0.4 13.6 13.6" xmlns="http://www.w3.org/2000/svg"><title>show</title><path d="M6.8 10q-1.675 0 -3.025 -0.975 -1.375 -0.975 -2.175 -2.625 0.8 -1.65 2.175 -2.625 1.35 -0.975 3.025 -0.975 1.6 0 3 1.025 1.4 1 2.2 2.575 -0.8 1.575 -2.2 2.6 -1.4 1 -3 1Zm0 -1.2q1 0 1.7 -0.7t0.7 -1.7q0 -1 -0.7 -1.7t-1.7 -0.7q-1 0 -1.7 0.7t-0.7 1.7q0 1 0.7 1.7t1.7 0.7Zm0 -1q-0.575 0 -0.975 -0.4 -0.425 -0.425 -0.425 -1t0.425 -0.975q0.4 -0.425 0.975 -0.425t1 0.425q0.4 0.4 0.4 0.975t-0.4 1q-0.425 0.4 -1 0.4Z"/></svg>
                                        </Link>
                                    </td>
                                    <td class="px-4 py-2">
                                        <Link :href="route('notes.edit', note.id)">
                                            <svg class="text-gray-400 hover:text-gray-600 h-4 w-4" viewBox="0 0 0.6 0.6" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0.525 0.107 0.491 0.073c-0.031 -0.031 -0.079 -0.031 -0.11 0L0.325 0.133l0.143 0.144 0.059 -0.059A0.077 0.077 0 0 0 0.55 0.164c0 -0.02 -0.011 -0.042 -0.025 -0.056Z" fill="#030D45"/><path d="M0.407 0.274 0.294 0.161 0.072 0.384C0.058 0.398 0.05 0.417 0.05 0.44v0.087c0 0.011 0.008 0.023 0.022 0.023h0.09c0.02 0 0.039 -0.008 0.056 -0.023l0.222 -0.223 -0.034 -0.031Z" fill="currentColor"/></svg>
                                        </Link>
                                    </td>
                                    <td class="px-4 py-2">
                                        <button @click.prevent="destroy(note.id)">
                                            <svg class=" text-red-500 hover:text-red-600 h-4 w-4" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1.3 1.3" enable-background="new 0 0 52 52" xml:space="preserve"><g><path d="M1.137 0.25H0.825V0.15c0 -0.055 -0.045 -0.1 -0.1 -0.1h-0.15c-0.055 0 -0.1 0.045 -0.1 0.1v0.1H0.163c-0.02 0 -0.038 0.017 -0.038 0.038v0.075c0 0.02 0.017 0.038 0.038 0.038h0.975c0.02 0 0.038 -0.017 0.038 -0.038v-0.075c0 -0.02 -0.017 -0.038 -0.038 -0.038zM0.575 0.175c0 -0.015 0.01 -0.025 0.025 -0.025h0.1c0.015 0 0.025 0.01 0.025 0.025v0.075h-0.15V0.175z"/><path d="M1.038 0.5h-0.775c-0.02 0 -0.038 0.017 -0.038 0.038V1.125c0 0.07 0.055 0.125 0.125 0.125h0.6c0.07 0 0.125 -0.055 0.125 -0.125V0.537c0 -0.02 -0.017 -0.038 -0.038 -0.038zM0.575 1.05c0 0.015 -0.01 0.025 -0.025 0.025h-0.05c-0.015 0 -0.025 -0.01 -0.025 -0.025V0.7c0 -0.015 0.01 -0.025 0.025 -0.025h0.05c0.015 0 0.025 0.01 0.025 0.025v0.35zm0.25 0c0 0.015 -0.01 0.025 -0.025 0.025h-0.05c-0.015 0 -0.025 -0.01 -0.025 -0.025V0.7c0 -0.015 0.01 -0.025 0.025 -0.025h0.05c0.015 0 0.025 0.01 0.025 0.025v0.35z"/></g></svg>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

