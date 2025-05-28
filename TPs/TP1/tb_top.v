// TB
// Top Level
`define NB_LEDS      4  //Cantidad bits leds
`define NB_COUNT     16 //Cantidad bits contador
`define NB_SW        4  //Cantidad bits switch


//Unidad de tiempo/presición
`timescale 1ns/100ps

module tb_top();    //No tienen puertos

   parameter NB_LEDS  = `NB_LEDS    ;
   parameter NB_COUNT = `NB_COUNT   ;
   parameter NB_SW    = `NB_SW      ;

   wire [NB_LEDS - 1 : 0] o_led   ;
   wire [NB_LEDS - 1 : 0] o_led_b ;
   wire [NB_LEDS - 1 : 0] o_led_g ;

   reg  [NB_SW  - 1 : 0] i_sw     ;
   reg                   i_reset  ;
   reg                   clock    ;

   `ifdef TEST_1            // Prueba funcionamiento de leds azules
        initial
        begin
            //Arrancan desde t=0
                   i_reset    = 1'b0  ;  //Reseteado
                   clock      = 1'b0  ;  //Clock en 0
                   i_sw[0]    = 1'b0  ;  //Contador deshabilitado
                   i_sw[2:1]  = 2'h0  ;  //Velocidad R0
                   i_sw[3]    = 1'b0  ;  //Color azul

            #100   i_reset    = 1'b1   ;  //Sale de reset
            #100   i_sw[0]    = 1'b1   ;  //Habilita el contador
            
            #10000 i_sw[2:1]  = 2'h1   ;  //Velocidad R1
            #10000 i_sw[2:1]  = 2'h2   ;  //Velocidad R2

            #10000 i_reset    = 1'b0   ;  //Se resetea
            #1000  i_reset    = 1'b1   ;  //Sale de reset
            #10000 i_sw[2:1]  = 2'h3   ;  //Velocidad R3
            #500   i_sw[0]    = 1'b1   ;  //Habilita el contador


            #1000  i_sw[0]    = 1'b0   ;  //Deshabilito contador
            #500   i_sw[0]    = 1'b1   ;  //Habilito contador

                $display("TEST PASSED");
            #50 $finish                ;    
            //Si no se coloca $finish, la simulación corre 
            //indefinidamente con el último estado de las variables
        end
    `endif

   `ifdef TEST_2            // Prueba funcionamiento de leds verdes
        reg [NB_LED - 1:0] led_value;
        reg state_checker           ;
    
        wire check;
    
        initial
        begin
            //Arrancan desde t=0
                   i_reset       = 1'b0   ;  //Reseteado
                   clock         = 1'b0   ;  //Clock en 0
                   i_sw[0]       = 1'b0   ;  //Contador deshabilitado
                   i_sw[2:1]     = 2'h0   ;  //Velocidad R0
                   i_sw[3]       = 1'b1   ;  //Color verde
                   state_checker = 1'b0   ;  //Inicializa en 0

            #100   i_reset       = 1'b1   ;  //Sale de reset
            #100   i_sw[0]       = 1'b1   ;  //Habilita el contador
                   
            #10000 i_sw[2:1]     = 2'h1   ;  //Velocidad R1
            #10000 i_sw[2:1]     = 2'h2   ;  //Velocidad R2
            #10000 i_sw[2:1]     = 2'h3   ;  //Velocidad R3

            #1000  i_reset       = 1'b0   ;  //Reseteado
                   i_sw[0]       = 1'b1   ;  //Habilita el contador
                   state_checker = i_sw[3];  //Guarda el valor de i_sw[3]
                                            
            #1000  i_sw[0]       = 1'b0   ;  //Deshabilito contador
            #500   i_sw[0]       = 1'b1   ;  //Habilito contador

                $display("TEST PASSED");
            #50 $finish                ;    
        end

        assign check = state_checker;
        
        always@(posedge check)
        begin
            $display("ERROR en la simulacion: led cambia de color cunado no debe");
            $display("TEST FAILED");
            $finish();
        end
    
    `endif 



  //Swiching: periodo de 10 ns ___---___---___
   always #5 clock = ~clock;

//Se instancia el módulo
top
  #(
    .NB_LEDS    (NB_LEDS ),
    .NB_COUNTER (NB_COUNT),
    .NB_SW      (NB_SW)      
    )

  u_top
    (
    .o_led  (o_led  ),
    .o_led_b(o_led_b),
    .o_led_g(o_led_g),

    .i_sw   (i_sw   ),
    .i_reset(i_reset),
    .clock  (clock  )
     );

     

endmodule 
