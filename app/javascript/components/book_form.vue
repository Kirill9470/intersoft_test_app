<template>
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">{{ title }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModal"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3 alert alert-warning" role="alert" v-if="modal_error_info.error">
                        {{modal_error_info.error_message}}
                    </div>

                    <div class="mb-3">
                        <label for="formControlInput3" class="form-label">Название книги</label>
                        <input type="text" v-model="book.name" class="form-control" id="formControlInput1" @input="$emit('update:book', $event.target.value)">
                    </div>
                    <div class="mb-3">
                        <label for="formControlInput2" class="form-label">Фамилия автора</label>
                        <input type="text" v-model="book.surname_author" class="form-control" id="formControlInput2" @input="$emit('update:book', $event.target.value)">
                    </div>
                    <div class="mb-3">
                        <label for="formControlInput3" class="form-label">Имя автора</label>
                        <input type="text" v-model="book.name_author" class="form-control" id="formControlInput3" @input="$emit('update:book', $event.target.value)">
                    </div>
                    <div class="mb-3">
                        <label for="formControlInput4" class="form-label">Год публикации</label>
                        <select class="form-select" aria-label="Default select example" id="formControlInput4" v-model="book.date" @input="$emit('update:book', $event.target.value)">
                            <option v-for="year in years" :value="year">{{ year }}</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" @click="mode == 'create' ? createNewBook() : updateNewBook()">Сохранить</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "books_form",
        props: ['title', 'book', 'determineBooksCollection', 'modal_error_info', 'mode'],
        emits: ['update:book'],
        computed: {
            years() {
                const year = new Date().getFullYear();
                return Array.from({length: year - 1970}, (value, index) => 1971 + index)
            }
        },
        methods: {
            createNewBook() {
                this.axios.post('http://localhost:3000/books', this.book)
                    .then((response) => {
                        this.$parent.getBooks();
                        document.getElementById('closeModal').click();
                    }).catch((error) => {
                        console.log(error);
                        this.modal_error_info.error = true;
                        this.modal_error_info.error_message = error.response.data.error;
                    }
                );
            },
            updateNewBook() {
                this.axios.put('http://localhost:3000/books/' + this.book.id, this.book)
                    .then((response) => {
                        this.$parent.getBooks();
                        document.getElementById('closeModal').click();
                    }).catch((error) => {
                        console.log(error);
                        this.modal_error_info.error = true;
                        this.modal_error_info.error_message = error.response.data.error;
                    }
                );
            }
        }
    }
</script>

<style scoped>

</style>