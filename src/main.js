import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './plugins/element.js'
import './assets/CSS/global.css'
import './assets/font/iconfont.css'


/**
 * 解决跨域问题，实现了前后端的分离
 */
//导入axios
import axios from "axios";
//挂载axios
Vue.prototype.$http = axios
//设置访问根路径
axios.defaults.baseURL="http://localhost:9000"

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
