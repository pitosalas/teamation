document.addEventListener("turbolinks:load", function(){
    window.store = new Vuex.Store({
        state: {
            projects:[],
            course: [],
        },
        mutations: {
            addCard(state, data) {
                state.projects.push(data)
            }
        }
    })
});

document.addEventListener("turbolinks:load", function(){
    var element = document.querySelector('#boards');
    if(element != undefined){
        window.store.state.projects = JSON.parse(element.dataset.projects)
        console.log(window.store.state.projects)
        window.store.state.course = JSON.parse(element.dataset.course)
        const app = new Vue({
            el: element,
            store: window.store,
            template: "<App/>",
            components: { App }
        });
    }
});