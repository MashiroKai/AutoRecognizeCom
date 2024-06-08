circuit AutoRecognize :
  module AutoRecognize :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip CMD : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, Feedback : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    io.CMD.ready <= UInt<1>("h1") @[AutoRecognize.scala 9:14]
    wire COM : UInt<25>
    COM <= UInt<25>("h10100cc")
    reg CMD_Shift : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[AutoRecognize.scala 11:24]
    reg CNT : UInt, clock with :
      reset => (reset, UInt<2>("h3")) @[AutoRecognize.scala 12:18]
    reg FB : UInt<8>[4], clock with :
      reset => (UInt<1>("h0"), FB) @[AutoRecognize.scala 13:13]
    FB[3] <= UInt<8>("hcc") @[AutoRecognize.scala 14:13]
    FB[2] <= UInt<1>("h0") @[AutoRecognize.scala 15:13]
    FB[1] <= UInt<5>("h10") @[AutoRecognize.scala 16:13]
    FB[0] <= UInt<5>("h10") @[AutoRecognize.scala 17:13]
    reg FLAG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[AutoRecognize.scala 18:19]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[AutoRecognize.scala 19:20]
    reg out : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[AutoRecognize.scala 20:18]
    io.Feedback.valid <= valid @[AutoRecognize.scala 21:21]
    io.Feedback.bits <= out @[AutoRecognize.scala 22:21]
    when io.CMD.valid : @[AutoRecognize.scala 23:19]
      node _CMD_Shift_T = shr(CMD_Shift, 8) @[AutoRecognize.scala 24:41]
      node _CMD_Shift_T_1 = cat(io.CMD.bits, _CMD_Shift_T) @[AutoRecognize.scala 24:29]
      CMD_Shift <= _CMD_Shift_T_1 @[AutoRecognize.scala 24:15]
    else :
      CMD_Shift <= CMD_Shift @[AutoRecognize.scala 26:17]
    node _T = eq(CMD_Shift, COM) @[AutoRecognize.scala 29:16]
    when _T : @[AutoRecognize.scala 29:24]
      CMD_Shift <= UInt<1>("h0") @[AutoRecognize.scala 30:15]
      FLAG <= UInt<1>("h1") @[AutoRecognize.scala 31:13]
    node _T_1 = eq(FLAG, UInt<1>("h1")) @[AutoRecognize.scala 34:11]
    node _T_2 = and(_T_1, io.Feedback.ready) @[AutoRecognize.scala 34:21]
    when _T_2 : @[AutoRecognize.scala 34:41]
      valid <= UInt<1>("h1") @[AutoRecognize.scala 35:13]
      node _out_T = or(CNT, UInt<2>("h0"))
      node _out_T_1 = bits(_out_T, 1, 0)
      out <= FB[_out_T_1] @[AutoRecognize.scala 36:12]
      node _CNT_T = sub(CNT, UInt<1>("h1")) @[AutoRecognize.scala 37:17]
      node _CNT_T_1 = tail(_CNT_T, 1) @[AutoRecognize.scala 37:17]
      CNT <= _CNT_T_1 @[AutoRecognize.scala 37:9]
    else :
      valid <= UInt<1>("h0") @[AutoRecognize.scala 39:13]
      out <= UInt<1>("h0") @[AutoRecognize.scala 40:12]
    node _T_3 = eq(CNT, UInt<1>("h0")) @[AutoRecognize.scala 43:10]
    node _T_4 = and(_T_3, io.Feedback.ready) @[AutoRecognize.scala 43:17]
    when _T_4 : @[AutoRecognize.scala 43:37]
      node _T_5 = eq(CNT, UInt<2>("h3")) @[AutoRecognize.scala 44:9]
      FLAG <= UInt<1>("h0") @[AutoRecognize.scala 45:10]

