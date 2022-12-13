<template>
    <pie-chart :data="data"></pie-chart>
</template>

<script>
    export default {
        name: "books_page",
        props: ['data'],
        data: function () {
          return {
            message: "Hello Books!"
          }
        }
    }
</script>

<style scoped>

</style>