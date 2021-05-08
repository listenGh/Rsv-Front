<template>
    <div class="login_container">

        <div class="login_box">

            <div class="avatar_box">
                <img src="../assets/logo.png" alt/>
            </div>

            <el-form ref="loginFormRef" :rules="loginRules" :model="loginForm" class="login_form" label-width="0">

                <el-form-item prop="username">
                    <el-input placeholder="username" v-model="loginForm.username"
                              prefix-icon="iconfont icon-yonghu"></el-input>
                </el-form-item>

                <el-form-item prop="password">
                    <el-input type="password" placeholder="password" v-model="loginForm.password"
                              prefix-icon="iconfont icon-mima"></el-input>
                </el-form-item>

                <el-form-item class="btns">
                    <el-button type="primary" @click="login()">提交</el-button>
                    <el-button type="info" @click="resetLoginForm()">重置</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Login",
        data() {
            return {
                loginForm: {
                    username: "",
                    password: "",
                },
                loginRules: {
                    username: [
                        {required: true, message: '用户名必填', trigger: 'blur'},
                    ],
                    password: [
                        {required: true, message: '密码必填', trigger: 'blur'},
                    ]
                },
            }
        },

        methods: {
            resetLoginForm() {
                this.loginForm.username = '',
                    this.loginForm.password = ''
            },
            login() {
                this.$refs.loginFormRef.validate(async valid => {
                    if (!valid) return;
                    const {data: res} = await this.$http.post("login", this.loginForm);
                    if (res.flag == "ok") {
                        this.$message.success("操作成功！");
                        window.sessionStorage.setItem("username", res.user.username);
                        window.sessionStorage.setItem("user", res.user);
                        window.sessionStorage.setItem("role", res.user.role);
                        if (res.user.role == "Admin") {
                            this.$router.push({path: "/homeOfAdmin"});
                        } else if (res.user.role == "Student") {
                            this.$router.push({path: "/homeOfStudent"});
                        } else {
                            this.$router.push({path: "/homeOfTeacher"});
                        }

                    } else {
                        this.$message.error("操作失败！");
                    }
                })
            }
        }
    }
</script>

<style lang="less" scoped>
    .login_container {
        background-color: #2b4b6b;
        height: 100%;
    }

    .login_box {
        width: 450px;
        height: 300px;
        background-color: #fff;
        border-radius: 3px;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);

        .avatar_box {
            width: 130px;
            height: 130px;
            border: 1px solid #eee;
            border-radius: 50%;
            padding: 5px;
            box-shadow: 0 0 2px #ddd;
            position: absolute;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #0ee;

            img {
                width: 100%;
                height: 100%;
                border-radius: 50%;
                background-color: #eee;
            }
        }
    }

    .btns {
        /*display: flex;*/
        /*justify-content: flex-start;*/
        position: absolute;
        left: 150px;
        top: 130px;
    }

    .login_form {
        position: absolute;
        width: 100%;
        bottom: 90px;
        padding: 0 100px;
        box-sizing: border-box;
    }

</style>