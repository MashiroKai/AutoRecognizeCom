circuit AutoRecognize :
  module AutoRecognize :
    input clock : Clock
    input reset : UInt<1>
    output io_CMD_ready : UInt<1>
    input io_CMD_valid : UInt<1>
    input io_CMD_bits : UInt<8>
    input io_Feedback_ready : UInt<1>
    output io_Feedback_valid : UInt<1>
    output io_Feedback_bits : UInt<8>

    reg CMD_Shift : UInt<32>, clock with :
      reset => (UInt<1>("h0"), CMD_Shift) @[AutoRecognize.scala 11:24]
    reg CNT : UInt<2>, clock with :
      reset => (UInt<1>("h0"), CNT) @[AutoRecognize.scala 12:18]
    reg FB_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), FB_0) @[AutoRecognize.scala 13:13]
    reg FB_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), FB_1) @[AutoRecognize.scala 13:13]
    reg FB_2 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), FB_2) @[AutoRecognize.scala 13:13]
    reg FB_3 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), FB_3) @[AutoRecognize.scala 13:13]
    reg FLAG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), FLAG) @[AutoRecognize.scala 18:19]
    reg valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), valid) @[AutoRecognize.scala 19:20]
    reg out : UInt<8>, clock with :
      reset => (UInt<1>("h0"), out) @[AutoRecognize.scala 20:18]
    node _CMD_Shift_T = shr(CMD_Shift, 8) @[AutoRecognize.scala 24:41]
    node _CMD_Shift_T_1 = cat(io_CMD_bits, _CMD_Shift_T) @[AutoRecognize.scala 24:29]
    node _GEN_0 = mux(io_CMD_valid, _CMD_Shift_T_1, CMD_Shift) @[AutoRecognize.scala 23:19 24:15 26:17]
    node COM = UInt<28>("h82590eb")
    node _T = eq(CMD_Shift, COM) @[AutoRecognize.scala 29:16]
    node _GEN_1 = mux(_T, UInt<1>("h0"), _GEN_0) @[AutoRecognize.scala 29:24 30:15]
    node _GEN_2 = mux(_T, UInt<1>("h1"), FLAG) @[AutoRecognize.scala 29:24 31:13 18:19]
    node _T_1 = eq(FLAG, UInt<1>("h1")) @[AutoRecognize.scala 34:11]
    node _T_2 = and(_T_1, io_Feedback_ready) @[AutoRecognize.scala 34:21]
    node _out_T = or(CNT, UInt<2>("h0"))
    node _out_T_1 = bits(_out_T, 1, 0)
    node _GEN_3 = validif(eq(UInt<1>("h0"), _out_T_1), FB_0) @[AutoRecognize.scala 36:{12,12}]
    node _GEN_4 = mux(eq(UInt<1>("h1"), _out_T_1), FB_1, _GEN_3) @[AutoRecognize.scala 36:{12,12}]
    node _GEN_5 = mux(eq(UInt<2>("h2"), _out_T_1), FB_2, _GEN_4) @[AutoRecognize.scala 36:{12,12}]
    node _GEN_6 = mux(eq(UInt<2>("h3"), _out_T_1), FB_3, _GEN_5) @[AutoRecognize.scala 36:{12,12}]
    node _CNT_T = sub(CNT, UInt<1>("h1")) @[AutoRecognize.scala 37:17]
    node _CNT_T_1 = tail(_CNT_T, 1) @[AutoRecognize.scala 37:17]
    node _out_T_2 = or(CNT, UInt<2>("h0"))
    node _out_T_3 = bits(_out_T_2, 1, 0)
    node _GEN_7 = validif(eq(UInt<1>("h0"), _out_T_3), FB_0) @[AutoRecognize.scala 40:{12,12}]
    node _GEN_8 = mux(eq(UInt<1>("h1"), _out_T_3), FB_1, _GEN_7) @[AutoRecognize.scala 40:{12,12}]
    node _GEN_9 = mux(eq(UInt<2>("h2"), _out_T_3), FB_2, _GEN_8) @[AutoRecognize.scala 40:{12,12}]
    node _GEN_10 = mux(eq(UInt<2>("h3"), _out_T_3), FB_3, _GEN_9) @[AutoRecognize.scala 40:{12,12}]
    node _GEN_11 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[AutoRecognize.scala 34:41 35:13 39:13]
    node _FB_out_T_1 = _GEN_6 @[AutoRecognize.scala 36:12]
    node _FB_out_T_3 = _GEN_10 @[AutoRecognize.scala 40:12]
    node _GEN_12 = mux(_T_2, _FB_out_T_1, _FB_out_T_3) @[AutoRecognize.scala 34:41 36:12 40:12]
    node _GEN_13 = mux(_T_2, _CNT_T_1, CNT) @[AutoRecognize.scala 12:18 34:41 37:9]
    node _T_3 = eq(CNT, UInt<1>("h0")) @[AutoRecognize.scala 43:10]
    node _T_4 = eq(CNT, UInt<2>("h3")) @[AutoRecognize.scala 44:9]
    node _GEN_14 = mux(_T_3, UInt<1>("h0"), _GEN_2) @[AutoRecognize.scala 43:18 45:10]
    io_CMD_ready <= UInt<1>("h1") @[AutoRecognize.scala 9:14]
    io_Feedback_valid <= valid @[AutoRecognize.scala 21:21]
    io_Feedback_bits <= out @[AutoRecognize.scala 22:21]
    CMD_Shift <= mux(reset, UInt<32>("h0"), _GEN_1) @[AutoRecognize.scala 11:{24,24}]
    CNT <= mux(reset, UInt<2>("h3"), _GEN_13) @[AutoRecognize.scala 12:{18,18}]
    FB_0 <= UInt<8>("h25") @[AutoRecognize.scala 17:13]
    FB_1 <= UInt<8>("h8") @[AutoRecognize.scala 16:13]
    FB_2 <= UInt<8>("h90") @[AutoRecognize.scala 15:13]
    FB_3 <= UInt<8>("heb") @[AutoRecognize.scala 14:13]
    FLAG <= mux(reset, UInt<1>("h0"), _GEN_14) @[AutoRecognize.scala 18:{19,19}]
    valid <= mux(reset, UInt<1>("h0"), _GEN_11) @[AutoRecognize.scala 19:{20,20}]
    out <= mux(reset, UInt<8>("h0"), _GEN_12) @[AutoRecognize.scala 20:{18,18}]
