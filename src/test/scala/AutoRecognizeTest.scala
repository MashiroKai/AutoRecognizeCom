import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ARCTest extends AnyFlatSpec with ChiselScalatestTester {
"Waveform" should "pass" in 
{ test(new AutoRecognize)
.withAnnotations(Seq(WriteVcdAnnotation)) { dut => 
dut.clock.step(2)
dut.io.CMD.valid.poke(true.B)
dut.io.CMD.bits.poke("hEB".U)
dut.clock.step()
dut.io.CMD.valid.poke(false.B)
dut.clock.step(2)
//
dut.io.CMD.valid.poke(true.B)
dut.io.CMD.bits.poke("h90".U)
dut.clock.step()
dut.io.CMD.valid.poke(false.B)
dut.clock.step(2)
//
dut.io.CMD.valid.poke(true.B)
dut.io.CMD.bits.poke("h25".U)
dut.clock.step()
dut.io.CMD.valid.poke(false.B)
dut.clock.step(2)
//
dut.io.CMD.valid.poke(true.B)
dut.io.CMD.bits.poke("h08".U)
dut.clock.step()
dut.io.CMD.valid.poke(false.B)

dut.io.Feedback.ready.poke(true.B)
dut.clock.step(1)
dut.io.Feedback.ready.poke(false.B)
dut.clock.step(5)
dut.io.Feedback.ready.poke(true.B)
dut.clock.step(10)
} }
}