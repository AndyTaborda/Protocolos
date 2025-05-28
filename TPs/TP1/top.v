module top
#(
    parameter  NB_SW      = 4 ,
    parameter  NB_COUNTER = 16,
    parameter  NB_LEDS    = 4
)
(
    output [NB_LEDS - 1 : 0] o_led  ,
    output [NB_LEDS - 1 : 0] o_led_b,
    output [NB_LEDS - 1 : 0] o_led_g,

    input  [NB_SW   - 1 : 0] i_sw   ,                   //Esto es un puerto
    input                    i_reset,
    input                    clock
);
    
    // Vars
    wire                   connect_count_to_sr;
    wire [NB_LEDS - 1 : 0] connect_led_to_mux ;

    wire [NB_SW   - 1 : 0]  sw_w                   ;    //Esto es un cable
    wire [NB_SW   - 1 : 0]  sw_from_vio            ;
    wire                    reset                  ;
    wire                    reset_from_vio         ;
    wire                    sel_mux                ;

    //Control por VIO
    //assign sw_w  = (sel_mux) ? sw_from_vio     : i_sw    ;
    //assign reset = (sel_mux) ? ~reset_from_vio : ~i_reset;
 


    count
        #(
            .NB_SW      (NB_SW-1   ),
            .NB_COUNTER (NB_COUNTER)
        )
        u_count
            (
                .o_valid(connect_count_to_sr),  
                .i_sw   (i_sw[2:0]          ),
                .i_reset(i_reset            ),
                .clock  (clock              )
            );

    shiftreg 
        #(
            .NB_LEDS (NB_LEDS)
        )
        u_shiftreg
            (
                .o_led  (connect_led_to_mux ),
                .i_valid(connect_count_to_sr),
                .i_reset(i_reset            ),
                .clock  (clock              )
            );


/*    ILA
        u_ILA
            (
            .clk_0    (clock   ),
            .probe0_0 (o_led   ),
            .probe1_0 (o_led_b ),
            .probe2_0 (o_led_g )   
            );
    
    
    VIO
        u_VIO
            (
            .clk_0        (clock         ),
            .probe_in0_0  (o_led         ),
            .probe_in1_0  (o_led_b       ),
            .probe_in2_0  (o_led_g       ),
            
            .probe_out0_0 (sel_mux       ),
            .probe_out1_0 (reset_from_vio),
            .probe_out2_0 (sw_from_vio   )
            );
*/
    assign o_led   = connect_led_to_mux;
    assign o_led_b = (i_sw[3]==1'b0) ? connect_led_to_mux : {NB_LEDS{1'b0}}     ;
    assign o_led_g = (i_sw[3]==1'b1) ? {NB_LEDS{1'b0}}      : connect_led_to_mux;

endmodule
