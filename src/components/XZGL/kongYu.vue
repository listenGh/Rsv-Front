<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>选座管理</el-breadcrumb-item>
            <el-breadcrumb-item>空余座位</el-breadcrumb-item>
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
                <el-table-column label="桌号" prop="id"></el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" @click="zyPosition(scope.row.id)">占用</el-button>
                    </template>
                </el-table-column>
            </el-table>

        </el-card>
    </div>
</template>

<script>
    export default {
        name: "kongYu",
        created() {
           this.getReadRoom();
        },
        data() {
            return {
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
            async searchZW(){
                console.log(this.room);
                const {data: res} = await this.$http.post("kongYu", {room:this.room,date: this.date,times:this.times});
                this.positions = res.listOfZH;
            },
            async zyPosition(num){
                console.log("username=="+window.sessionStorage.getItem("username"));
                console.log("num=="+num);
                const {data: res} = await this.$http.post("zyPosition", {username:window.sessionStorage.getItem("username"),num:num,room:this.room,date: this.date,times:this.times});
                if (res == "success") {
                    this.$message.success("操作成功！");
                    const {data: re} = await this.$http.post("kongYu", {room:this.room,date: this.date,times:this.times});
                    this.positions = re.listOfZH;
                } else {
                    this.$message.error("操作失败！");
                }
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