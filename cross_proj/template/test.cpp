/*Copyright 2021 Tibbo Technology Inc.*/

// #include "global.th"
// #include "pmux/ntios_pmux.h"

// /* FUNCTIONS */
// void debug_print(const string &data) {
//     printf("%s\n", (data.c_str()));
// }

// pl_io_num TBT13_S1_CLK=PL_IO_NUM_36;
// pl_io_num TBT13_S1_DATA=PL_IO_NUM_37;
// byte TBT13_S1_CHANNEL_NUM;


void on_sys_init(){
    // pat.play("R-R-G-G-~", PL_PAT_CANINT);
    // tbt13_init("TBT13_S1",TBT13_S1_DATA,TBT13_S1_CLK, &TBT13_S1_CHANNEL_NUM,YES);

}


void on_sys_timer() {
    // short adc1, adc2, adc3, adc4;
    // tbt13_channel_select(ADC_1,TBT13_S1_CHANNEL_NUM);    //'select the channel
    // tbt13_get_prev(TBT13_S1_CHANNEL_NUM);                //discard first read, can use tbt13_read_prev() or tbt13_read_prev_mv() for that
    // adc1=tbt13_get_prev_mv(TBT13_S1_CHANNEL_NUM);        //now get the data
    // tbt13_channel_select(ADC_2,TBT13_S1_CHANNEL_NUM);    //onto the next channel...
    // tbt13_get_prev(TBT13_S1_CHANNEL_NUM);
    // adc2=tbt13_get_prev_mv(TBT13_S1_CHANNEL_NUM);
    // tbt13_channel_select(ADC_3,TBT13_S1_CHANNEL_NUM);
    // tbt13_get_prev(TBT13_S1_CHANNEL_NUM);
    // adc3=tbt13_get_prev_mv(TBT13_S1_CHANNEL_NUM);
    // tbt13_channel_select(ADC_4,TBT13_S1_CHANNEL_NUM);
    // tbt13_get_prev(TBT13_S1_CHANNEL_NUM);
    // adc4=tbt13_get_prev_mv(TBT13_S1_CHANNEL_NUM);
    // sys.debugprint("CH1:"+stri(adc1)+" CH2:"+stri(adc2)+" CH3:"+stri(adc3)+" CH4:"+stri(adc4)+chr(13)+chr(10));
}

