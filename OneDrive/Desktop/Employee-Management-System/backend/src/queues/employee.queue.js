import Bull from "bull"

const employeeQueue = new Bull("employeeQueue", {
  redis: {
    host: "127.0.0.1",
    port: 6379
  }
})

export default employeeQueue
