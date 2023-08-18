<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import {Link, useForm} from "@inertiajs/vue3";

const props = defineProps({
    note: Object
})

const form = useForm({
    excerpt: props.note.excerpt,
    content: props.note.content
});

const submit = () => {
    form.put( route('notes.update', props.note.id), form );
};
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
                            <h3 class="text-lg text-gray-900">Editar una Nota</h3>

                        </div>
                    </div>
                    <div class="md:col-span-2">
                        <div class="shadow bg-white md:rounded-md p-4">
                            <form @submit.prevent="submit" >
                                <label class="block font-medium text-sm text-gray-700"> Resumen </label>
                                <textarea class="form-input w-full rounded-md shadow-sm" v-model="form.excerpt"></textarea>
                                <label class="block font-medium text-sm text-gray-700"> Contenido </label>
                                <textarea class="form-input w-full rounded-md shadow-sm" v-model="form.content" rows="8" ></textarea>
                                <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-md ">Guardar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

