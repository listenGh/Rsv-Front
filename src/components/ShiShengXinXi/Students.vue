<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>师生信息</el-breadcrumb-item>
            <el-breadcrumb-item>学生信息</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="用户名" prop="username"></el-table-column>
                <el-table-column label="密码" prop="password"></el-table-column>
                <el-table-column label="性别" prop="sex"></el-table-column>
                <el-table-column label="班级" prop="classes"></el-table-column>
                <el-table-column label="邮箱" prop="email"></el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="danger" @click="cli(scope.row.username)">编辑信息</el-button>
                    </template>
                </el-table-column>
            </el-table>


            <el-dialog title="学生信息编辑" :visible.sync="dialogFormVisible">
                <el-form>
                    <el-form-item label="性别" :label-width="formLabelWidth">
                        <el-select v-model="sex" placeholder="请选择性别" >
                            <el-option label="男" value="M"></el-option>
                            <el-option label="女" value="W"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="班级" :label-width="formLabelWidth">
                        <el-input v-model="classes" autocomplete="off" ></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false">取 消</el-button>
                    <el-button type="primary" @click="updateStudent()">确 定</el-button>
                </div>
            </el-dialog>

        </el-card>
    </div>
</template>

<script>
    export default {
        name: "Students",
        created() {
            this.username = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                formLabelWidth:'120px',
                dialogFormVisible:false,
                username:'',
                positions:[],
                sex:'',
                classes:'',
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllStudent");
                this.positions = res.listOfStudents;
            },

            cli(username){
                this.dialogFormVisible = true;
                this.username = username;
            },

            async updateStudent(){
                const {data: res} = await this.$http.post("updateStudent", {username:this.username,sex:this.sex,classes:this.classes});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogFormVisible = false;
                this.initt();
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