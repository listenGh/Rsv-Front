<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>选座管理</el-breadcrumb-item>
            <el-breadcrumb-item>已占座位</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-row :gutter="25">
                <el-col :span="5.2">
                    <el-date-picker
                            v-model="date"
                            type="date"
                            placeholder="选择日期"
                            :picker-options="pickerOptions">
                    </el-date-picker>
                </el-col>
                <el-col :span="5.2">
                    <el-time-picker
                            is-range
                            v-model="times"
                            range-separator="至"
                            start-placeholder="开始时间"
                            end-placeholder="结束时间"
                            placeholder="选择时间范围">
                    </el-time-picker>
                </el-col>
                <el-col :span="5">
                    <el-select v-model="room" filterable placeholder="请选择阅览室">
                        <el-option
                                v-for="item in options"
                                :key="item.name"
                                :label="item.name"
                                :value="item.name">
                        </el-option>
                    </el-select>
                </el-col>

                <el-col :span="4">
                    <el-button type="primary" @click="searchZW()">搜索座位</el-button>
                </el-col>
            </el-row>

            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="用户名" prop="username"></el-table-column>
                <el-table-column label="阅览室" prop="readRoom"></el-table-column>
                <el-table-column label="桌号" prop="num"></el-table-column>
                <el-table-column label="开始时间" prop="startTime"></el-table-column>
                <el-table-column label="结束时间" prop="endTime"></el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="danger" @click="jbb(scope.row.username)">举报</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
        <el-dialog title="举报信息" :visible.sync="dialogFormVisible">
            <el-form :model="JBInfo">
                <el-form-item label="举报人" :label-width="formLabelWidth">
                    <el-input v-model="JBInfo.jBusername" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="被举报人" :label-width="formLabelWidth">
                    <el-input v-model="JBInfo.bJBusername" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="举报内容" :label-width="formLabelWidth">
                    <el-input v-model="JBInfo.content" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="juB()">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "yiZhan",
        created() {
            this.getReadRoom();
            this.initt();
        },
        data() {
            return {
                formLabelWidth:'120px',
                JBInfo:{
                    jBusername:'',
                    bJBusername:'',
                    content:'',
                },
                dialogFormVisible:false,
                pickerOptions: {
                    disabledDate(time) {
                        return (time.getTime() < Date.now());
                    },
                },
                options: [],
                room: '',
                date:'',
                times: [new Date(2016, 10, 11, 0, 0), new Date(2016, 11, 10, 0, 0)],
                positions:[],
            }
        },
        methods: {
            async getReadRoom(){
                const {data: res} = await this.$http.post("getReadRoom");
                this.options = res.listOfReadRoomInfo;
            },
            async initt(){
                console.log(this.room);
                const {data: res} = await this.$http.post("yZJL");
                this.positions = res.listOfZH;
                this.JBInfo.jBusername = window.sessionStorage.getItem("username");
            },
            async searchZW(){
                console.log(this.room);
                const {data: res} = await this.$http.post("searchYZ", {room:this.room,date: this.date,times:this.times});
                this.positions = res.listOfZH;
            },
            jbb(username){
                this.dialogFormVisible = true;
                this.JBInfo.bJBusername = username;
            },
            //举报
            async juB(){
                const {data: res} = await this.$http.get("juB", {params:this.JBInfo});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogFormVisible = false;
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