<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>个人信息</el-breadcrumb-item>
            <el-breadcrumb-item>个人信息管理</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-table :data="positions" border stripe>
                <!--                <el-table-column type="index"></el-table-column>-->
                <el-table-column label="用户名" prop="username"></el-table-column>
                <el-table-column label="密码" prop="password"></el-table-column>
                <el-table-column label="性别" prop="sex"></el-table-column>
                <el-table-column label="邮箱" prop="email"></el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="danger" @click="cli(scope.row)">更改</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>

        <el-dialog title="个人信息编辑" :visible.sync="dialogVisible">
            <el-form>
                <el-form-item label="性别" :label-width="formLabelWidth">
                    <el-select v-model="sex" placeholder="请选择性别" >
                        <el-option label="男" value="M"></el-option>
                        <el-option label="女" value="W"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="密码" :label-width="formLabelWidth">
                    <el-input v-model="password" autocomplete="off" ></el-input>
                </el-form-item>
                <el-form-item label="邮箱" :label-width="formLabelWidth">
                    <el-input v-model="email" autocomplete="off" ></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="updateTeacher()">确 定</el-button>
            </div>
        </el-dialog>


    </div>
</template>

<script>
    export default {
        name: "personalInfoManaOfTeacher",
        created() {
            this.username = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                gridData:[],
                dialogFormVisible:false,
                dialogVisible:false,
                bJBusername:'',
                formLabelWidth:'120px',
                positions:[],
                username:'',
                password:'',
                sex:'',
                XueYuan:'',
                email:'',
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getOneTeacher",{username:window.sessionStorage.getItem("username")});
                this.positions = res.listOfStudents;
            },
            async updateTeacher(){
                const {data: res} = await this.$http.post("updateTeacherPersonal", {username:this.username,sex:this.sex,email:this.email,password:this.password});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogVisible = false;
                this.initt();
            },
            cli(res){
                this.email = res.email;
                this.sex = res.sex;
                this.XueYuan = res.XueYuan;
                this.password = res.password;
                this.dialogVisible = true;
            },
        }
    }
</script>

<style lang="less" scoped>

    .el-breadcrumb {
        margin-bottom: 16px;
        font-size: 12px;
    }
</style>