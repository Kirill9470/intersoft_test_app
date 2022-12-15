<template>
    <div class="container-fluid">
        <div class="row">

            <div class="col-3">
                <DiagramPie :data="diagram_data"/>
            </div>

            <div class="col-9">
                <BooksTable ref="BooksTable"
                            :books="books"
                            :authors="authors"
                            :prependOpenEditModal="prependOpenEditModal"
                            :prependOpenCreateModal="prependOpenCreateModal"
                            :determineBooksCollection="determineBooksCollection"/>
            </div>
        </div>

        <BookForm :title="title_modal"
                  :book="book"
                  :modal_error_info="modal_error_info"
                  :mode="mode"
                  :determineBooksCollection="determineBooksCollection"/>
    </div>
</template>

<script>
    import DiagramPie from './components/books_diagram'
    import BookForm from './components/book_form'
    import BooksTable from './components/books_table'

    export default {
        mounted() {
            this.getBooks()
        },
        components: {
            DiagramPie,
            BookForm,
            BooksTable
        },
        methods: {
            getBooks() {
                this.axios.get('http://localhost:3000/books', { params: this.query }).then((response) => {
                    this.diagram_data = response.data.meta.books_years_info;
                    this.authors = response.data.meta.authors;
                    this.books = response.data.books
                });
            },
            prependOpenCreateModal () {
                this.title_modal = 'Добавить новую книгу';
                this.book = {id: null, name: null, date: null, surname_author: null, name_author: null};
                this.modal_error_info = {error: null, error_message: null};
                this.mode = 'create'
            },
            prependOpenEditModal (data) {
                this.title_modal = data.title;
                this.book = data.book;
                this.modal_error_info = {error: null, error_message: null};
                this.mode = 'edit'
            },
            determineBooksCollection (query) {
                this.query = query;
                this.getBooks()
            }
        },
        data() {
            return {
                diagram_data: [],
                books: [],
                authors: [],
                title_modal: 'Добавить новую книгу',
                book: {id: null, name: null, date: null, surname_author: null, name_author: null},
                query: {name: null, author: null, start_date: null, end_date: null},
                modal_error_info: {error: null, error_message: null},
                mode: 'create'
            }
        }
    }
</script>
