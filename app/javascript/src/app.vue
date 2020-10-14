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
                                    <i class="far fa-trash-alt" @click="deleteProject(index, course.id, project.id)"></i>
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
                                        <div v-if="project.is_active == true">
                                            <button class="btn btn-primary btn-sm" @click="markActive(index, course.id, project.id)"> Remove from Active </button>
                                        </div>
                                        <div v-else>
                                            <button class="btn btn-primary btn-sm" @click="markActive(index, course.id, project.id)"> Mark as Active </button>
                                        </div>
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
            description: {}
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
        deleteProject: function(index, course_id, project_id) {
            Rails.ajax({
                beforeSend: () => true,
                url: "/courses/" + course_id + "/projects/" + project_id,
                type: "DELETE",
                dataType: "json",
                success: (data) => {
                    alert("Project is deleted!");
                }
            })
        },
        markActive: function(index, course_id, project_id) {
            var data = new FormData
            console.log(this.$store.state.projects[index].is_active);
            if (this.$store.state.projects[index].is_active == true) {
                console.log(this.$store.state.projects[index].is_active);
                this.$store.state.projects[index].is_active = false;
            } else {
                console.log(this.$store.state.projects[index].is_active);
                this.$store.state.projects[index].is_active = true;
            }
            data.append("project[is_active]", this.$store.state.projects[index].is_active)
            Rails.ajax({
                beforeSend: () => true,
                url: "/courses/" + course_id + "/projects/" + project_id,
                type: "PATCH",
                data: data,
                dataType: "json",
                success: (data) => {
                    if (this.$store.state.projects[index].is_active == true) {
                        alert("Marked as Active");
                    } else {
                        alert("Remove from Active");
                    }
                }
            })
        },
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
                    alert("New Project Added to the Project List!")
                }
            })
        }
    }
}
</script>

<style scoped>

</style>