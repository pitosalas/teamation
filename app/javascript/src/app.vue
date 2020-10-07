<template>
    <div class = "wrapper overflow projects-container" id="project-brainstorm">
        <div class="row project-row">
            <div class="col projects-box">
                <h5 class='project-title'>
                    Add a New Project
                </h5>
                <div class = 'add-project-container'>
                    <div class= 'container project-container project-container-input'>
                        <textarea v-model="messages['projects']" class="form-control editbox editbox-name" placeholder="Project Name"></textarea>
                        <textarea v-model="description['projects']" class="form-control editbox editbox-description" placeholder="Description"></textarea>
                        <div class="row">
                            <div class="container add-projects-button">
                                <button v-on:click = "submitProject('projects', course.id)" class="btn btn-primary addButton addProjectBtn">Add</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col projects-box">
                <h5 class='project-title'>
                    Projects List
                </h5>
                <a v-for="(project, index) in projects" class = 'add-project-container'>
                        <div class="card project-card" style="width: 30rem; height: 20rem">
                            <div class="card-body">
                                <div id="delete-project">
                                    <i class="far fa-trash-alt"></i>
                                </div>
                                <h4 class='project-name-text'>
                                    {{ project.project_name }}
                                </h4>
                                <div class='form-control project-description-text'>
                                    <p>{{ project.description }}</p>
                                </div>
                                <div class="row" id="project-list-buttons">
                                    <div class ="col" id="edit-project">
                                        <i class="fas fa-edit"></i>
                                    </div>
                                    <div class ="col" id="mark-project-active">
                                        <button class="btn btn-primary btn-sm">Mark as Active</button>
                                    </div>
                                    <div class ="col" id="like-project">
                                        <i class="far fa-heart"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
</template>

<script>
export default {
    data: function(){
        return {
            messages: {},
            description: {},
        }
    },

    computed:{
        projects: {
            get(){
                return this.$store.state.projects
            },
            set(value){
                console.log("in vue compute")
                console.log(value)
            }
        },
        course: {
            get(){
                return this.$store.state.course
            }
        }
    },

    methods: {
        submitProject: function(column_str, course_id){
            var data = new FormData
            data.append("project[course_id]", course_id)
            data.append("project[project_name]", this.messages[column_str])
            data.append("project[description]", this.description[column_str])
            Rails.ajax({
                beforeSend: () => true,
                url: "/courses/" + course_id + "/projects",
                type: "POST",
                data: data,
                dataType: "json",
                success: (data) => {
                    this.messages[column_str] = undefined
                    this.description[column_str]= undefined
                }
            })
        }
    }
}
</script>

<style scoped>

</style>