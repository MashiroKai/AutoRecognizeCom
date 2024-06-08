import chisel3._
import chisel3.util._

class AutoRecognize extends Module { 
val io = IO(new Bundle {
val CMD = Flipped(new DecoupledIO(UInt(8.W))) 
val Feedback = new DecoupledIO(UInt(8.W)) 
})
io.CMD.ready := true.B
val COM = WireDefault("h010100CC".U)
val CMD_Shift = RegInit(0.U(32.W))
val CNT = RegInit(3.U)
val FB = Reg(Vec(4,UInt(8.W)))
    FB(3)   := "hCC".U
    FB(2)   := "h00".U
    FB(1)   := "h10".U
    FB(0)   := "h10".U
val FLAG = RegInit(false.B)
val valid = RegInit(0.B)
val out = RegInit(0.U(8.W))
io.Feedback.valid   := valid
io.Feedback.bits    := out
when(io.CMD.valid){
    CMD_Shift := io.CMD.bits##(CMD_Shift>>8)
}.otherwise{
    CMD_Shift   :=CMD_Shift
}
//shift incoming data
when(CMD_Shift === COM){
    CMD_Shift := 0.U //initial shift register
    FLAG    :=  true.B
}
//data recoginize and start feedback
when(FLAG === true.B&&io.Feedback.ready){
    valid   := true.B
    out    := FB(CNT)
    CNT :=  CNT - 1.U
}.otherwise{
    valid   := false.B
    out    := 0.U
}
//CNT control
when(CNT === 0.U&&io.Feedback.ready){
    CNT === 3.U
    FLAG := false.B
}
}

object AutoRecognize extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new AutoRecognize(), Array("--target-dir","generated"))
}