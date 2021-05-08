<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>系统管理</el-breadcrumb-item>
            <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-row :gutter="25">
                <el-col :span="10">
                    <el-input placeholder="请输入搜索内容" v-model="QueryInfo.query" clearable @clear="getUserList">
                        <el-button slot="append" icon="el-icon-search" @click="getUserList"></el-button>
                    </el-input>
                </el-col>

                <el-col :span="4">
                    <el-button type="primary" @click="addDialogVisible = true">添加用户</el-button>
                </el-col>
            </el-row>

            <el-table :data="userList" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="用户名" prop="username"></el-table-column>
                <el-table-column label="密码" prop="password"></el-table-column>
                <el-table-column label="邮箱" prop="email"></el-table-column>
                <el-table-column label="角色" prop="role"></el-table-column>
                <el-table-column label="状态" prop="state">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.state" @change="userStateChanged(scope.row)"></el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">

                        <el-dialog title="更新用户信息" :visible.sync="updateDialogVisible">

                            <el-form :model="updateForm" ref="updateFormRef" :rules="updateFormRules">
                                <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
                                    <el-input v-model="updateForm.username" autocomplete="off" disabled></el-input>
                                </el-form-item>
                                <el-form-item label="密码" :label-width="formLabelWidth" prop="password">
                                    <el-input v-model="updateForm.password" autocomplete="off"
                                              type="password"></el-input>
                                </el-form-item>
                                <el-form-item label="邮箱" :label-width="formLabelWidth" prop="email">
                                    <el-input v-model="updateForm.email" autocomplete="off"></el-input>
                                </el-form-item>
                                <el-form-item label="角色" :label-width="formLabelWidth" prop="role">
                                    <el-input v-model="updateForm.role" autocomplete="off" disabled></el-input>
                                </el-form-item>
                            </el-form>

                            <div slot="footer" class="dialog-footer">
                                <el-button @click="updateDialogVisible = false">取 消</el-button>
                                <el-button type="primary" @click="updateUser()">确 定</el-button>
                            </div>
                        </el-dialog>

                        <el-button size="mini" @click="getUserById(scope.row)">编辑</el-button>

                        <el-button size="mini" type="danger" @click="deleteUser(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>


            <div>
                <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="QueryInfo.pageNum"
                        :page-sizes="[1, 2, 5, 10]"
                        :page-size="QueryInfo.pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total">
                </el-pagination>
            </div>
        </el-card>

        <el-dialog title="添加用户" :visible.sync="addDialogVisible">
            <el-form :model="addForm" ref="addFormRef" :rules="addFormRules">
                <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
                    <el-input v-model="addForm.username" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="密码" :label-width="formLabelWidth" prop="password">
                    <el-input v-model="addForm.password" autocomplete="off" type="password"></el-input>
                </el-form-item>
                <el-form-item label="邮箱" :label-width="formLabelWidth" prop="email">
                    <el-input v-model="addForm.email" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="角色选择" :label-width="formLabelWidth">
                    <el-select v-model="addForm.role" placeholder="请设定角色" prop="role">
                        <el-option label="管理员" value="Admin"></el-option>
                        <el-option label="学生" value="Student"></el-option>
                        <el-option label="教师" value="Teacher"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="addUser">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "UserList",
        created() {
            this.getUserList();
        },
        data() {
            return {
                QueryInfo: {
                    query: '',
                    pageNum: 1,
                    pageSize: 5,
                },
                userList: [],
                total: 0,
                addDialogVisible: false,
                updateDialogVisible: false,
                addForm: {
                    username: '',
                    password: '',
                    email: '',
                    role: null,
                    state: false,
                },
                updateForm: {
                    id:'',
                    username: '',
                    password: '',
                    email: '',
                    role: null,
                    state: false,
                },
                addFormRules: {
                    username: [
                        {required: true, message: '请输入用户名', trigger: 'blur'},
                    ],
                    password: [
                        {required: true, message: '请输入密码', trigger: 'blur'},
                    ],
                    email: [
                        {required: true, message: '请输入邮箱', trigger: 'blur'},
                    ],
                    role: [
                        {required: true, message: '请设定角色', trigger: 'blur'},
                    ],
                },
                updateFormRules: {
                    password: [
                        {required: true, message: '请更改密码', trigger: 'blur'},
                    ],
                    email: [
                        {required: true, message: '请更改邮箱', trigger: 'blur'},
                    ],
                },
                formLabelWidth: '120px',
            }
        },
        methods: {
            async getUserList() {
                const {data: res} = await this.$http.get("allUser", {params: this.QueryInfo});
                this.userList = res.data;
                this.total = res.number;
            },
            handleSizeChange(newSize) {
                this.QueryInfo.pageSize = newSize;
                this.getUserList();
            },
            handleCurrentChange(newPage) {
                this.QueryInfo.pageNum = newPage;
                this.getUserList();
            },
            async userStateChanged(userInfo) {
                // console.log(userInfo.id);
                // console.log(userInfo.state);
                const {data: res} = await this.$http.get("updateUserState", {params: userInfo});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    userInfo.state = !userInfo.state;
                    this.$message.error("操作失败！");
                }
            },
            addUser() {
                this.$refs.addFormRef.validate(async valid => {
                    if (!valid) return;
                    const {data: res} = await this.$http.get("addUser", {params: this.addForm});
                    if (res == "success") {
                        this.$message.success("操作成功！");
                    } else {
                        this.$message.error("操作失败！");
                    }
                    this.addDialogVisible = false;
                    this.getUserList();
                    this.addForm.username = '';
                    this.addForm.password = '';
                    this.addForm.email = '';
                    this.addForm.role = '';
                })
            },

            updateUser(){
                this.$refs.updateFormRef.validate(async valid => {
                    if (!valid) return;
                    const {data: res} = await this.$http.get("updateUser", {params: this.updateForm});
                    if (res == "success") {
                        this.$message.success("操作成功！");
                    } else {
                        this.$message.error("操作失败！");
                    }
                    this.updateDialogVisible = false;
                    this.getUserList();
                    this.$refs.updateFormRef.resetFields();
                })
            },

            async deleteUser(userInfo) {

                const confirmResult = await this.$confirm('此操作将永久删除用户，是否继续？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                }).catch(err => err);
                if (confirmResult != 'confirm') {
                    return this.$message.info('已取消删除');
                }
                const {data: res} = await this.$http.get("deleteUser", {params: userInfo});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.getUserList();
            },
            async getUserById(user){
                this.updateDialogVisible = true;
                // console.log(user.id);
                const {data:res} = await this.$http.get("getUserById", {params: user});
                // console.log(res);
                this.updateForm = res;
                // console.log(this.updateForm);
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