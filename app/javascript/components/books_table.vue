<template>
    <div>
        <div class="row" style="margin-bottom: 10px">
            <div class="col-12">
                <form class="row g-3">
                    <div class="col-md-3">
                        <label for="formSearchInput1" class="form-label">по названию</label>
                        <input type="text" class="form-control" id="formSearchInput1" v-model="name">
                    </div>
                    <div class="col-md-3">
                        <label for="formSearchInput2" class="form-label">по автору</label>
                        <select class="form-select" aria-label="Default select example" id="formSearchInput2" v-model="author">
                            <option value="Кирилл Сидоров">Кирилл Сидоров</option>
                            <option value="2">One</option>
                            <option value="3">Two</option>
                            <option value="4">Three</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="formSearchInput3" class="form-label">с</label>

                        <select class="form-select" aria-label="Default select example" id="formSearchInput3" v-model="start_date">
                            <option v-for="year in years" :value="year">{{ year }}</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <label for="formSearchInput4" class="form-label">по</label>

                        <select class="form-select" aria-label="Default select example" id="formSearchInput4" v-model="end_date">
                            <option v-for="year in years" :value="year">{{ year }}</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <div style="position: relative;width: 100%;height: 100%;">
                            <button type="button" class="btn btn-primary" style="position: absolute;top: 45%;" @click="searchBooks">Поиск</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="table-responsive">
                    <table class="table table-striped table-sm">
                        <thead>
                        <tr>
                            <th scope="col">Название</th>
                            <th scope="col">Автор</th>
                            <th scope="col">Дата публикации</th>
                            <th scope="col">Действия</th>
                        </tr>
                        </thead>
                        <tbody>

                        <tr v-for="book in books" :key="book.id">
                            <td style="vertical-align: middle;">{{book.name}}</td>
                            <td style="vertical-align: middle;">{{book.author}}</td>
                            <td style="vertical-align: middle;">{{book.date}}</td>
                            <td>
                                <button type="button" class="btn btn-link" style="padding-left: 0" data-bs-toggle="modal" data-bs-target="#exampleModal" @click="openEditModal(book)">Редактировать</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" @click="prependCreateModal">Добавить</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "books_table",
        props: ['books', 'prependOpenEditModal', 'prependOpenCreateModal', 'determineBooksCollection'],
        methods: {
            openEditModal(book){
                let authorFullName = book.author.split(' ');

                this.prependOpenEditModal({
                    title: 'Редактировать книгу ' + book.name,
                    book: {id: book.id, name: book.name, date: book.date, name_author: authorFullName[0], surname_author: authorFullName[1]}
                })
            },
            prependCreateModal(){
                this.prependOpenCreateModal()
            },
            searchBooks(){
                let query = {name: this.name, author: this.author, start_date: this.start_date, end_date: this.end_date};
                this.determineBooksCollection(query)
            }
        },
        computed : {
            years () {
                const year = new Date().getFullYear();
                return Array.from({length: year - 1970}, (value, index) => 1971 + index)
            }
        },
        data: function () {
            return {
                name: null,
                author: null,
                start_date: null,
                end_date: null
            }
        }
    }
</script>

<style scoped>

</style>