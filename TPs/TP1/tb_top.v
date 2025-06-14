// TB
// Top Level
`define NB_LEDS      4  //Cantidad bits leds
`define NB_COUNT     16 //Cantidad bits contador
`define NB_SW        4  //Cantidad bits switch

`define TEST_5          // Selecciona qué test ejecutar: 1, 2, 3, ...

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

    // =========== TEST 1 ===========
    // Prueba funcionamiento reset
    // ==============================
    `ifdef TEST_1
        integer reset_delay;

        initial begin
            //Arrancan desde t=0
                   i_reset    <= 1'b0  ;  //Reseteado
                   clock      <= 1'b0  ;  //Clock en 0
                   i_sw[0]    <= 1'b0  ;  //Contador deshabilitado
                   i_sw[2:1]  <= 2'h0  ;  //Velocidad R0
                   i_sw[3]    <= 1'b0  ;  //Color azul
                   
            #100   i_reset    <= 1'b1  ;  //Sale de reset
                   i_sw[0]    <= 1'b1  ;  //Contador habilitado

            // Se repite el test 5 veces con tiempos aleatorios
            repeat (5)
                begin
                    //Se espera algunos ciclos para que los LEDs cambien
                    reset_delay = $urandom_range(1, 2000);
                    #reset_delay    i_reset = 1'b0;   //Se resetea
                    #10                           ;   //Se espera a que se aplique el reset
    
                    //Se verifica que los LEDs azules vuelvan a 4'b0001
                    if (o_led !== {{NB_LEDS-1{1'b0}},1'b1})
                    begin
                        $display("=================================================");                
                        $display("TEST 1 FAILED: o_led no se reinició correctamente. Valor: %b", o_led);
                        $display("=================================================");
                        $finish;
                    end
                    else
                    begin
                        $display("Corriendo test...");
                    end
                    #100   
                    @(posedge clock) i_reset    <= 1'b1  ;  //Sale de reset

                end
            $display("=================================================");
            $display("TEST 1 PASSED: Reset correcto, o_led = %b", o_led );
            $display("=================================================");
            #100 $finish;
            
        end
    `endif


    // =========== TEST 2 ===========
    // Prueba funcionamiento de leds
    // ==============================
   `ifdef TEST_2       
        integer delay_led;
  
        initial
        begin
            //Arrancan desde t=0
                   i_reset      <= 1'b0   ;  //Reseteado
                   clock        <= 1'b0   ;  //Clock en 0
                   i_sw[0]      <= 1'b0   ;  //Contador deshabilitado
                   i_sw[2:1]    <= 2'h0   ;  //Velocidad R0
                   i_sw[3]      <= 1'b0   ;  //Color azul
            
            #100   i_reset      <= 1'b1   ;  //Sale de reset
            #100   i_sw[0]      <= 1'b1   ;  //Habilita el contador
                   
            repeat(5)
            begin
                //Prueba en color azul (i_sw[3] = 0)
                //Se espera algunos ciclos para que los LEDs cambien
                delay_led = $urandom_range(1, 2000);
                #delay_led                         ;

                if (o_led_b !== o_led || o_led_g !== {NB_LEDS{1'b0}})
                begin
                    $display("=================================================");
                    $display("ERROR: LEDS no muestran azul correctamente"       );
                    $display("=================================================");
                    $finish;
                end
                else
                begin
                    $display("Corriendo test...");
                end
            
                //Prueba en color verde (i_sw[3] = 1)
                #10   i_sw[3] <= 1'b1;
                #delay_led            ;

                if (o_led_g !== o_led || o_led_b !== {NB_LEDS{1'b0}})
                begin
                    $display("=================================================");
                    $display("ERROR: LEDS no muestran verde correctamente"      );
                    $display("=================================================");
                    $finish;
                end
                else
                begin
                    $display("Corriendo test...");
                end

                #10    i_sw[3] <= 1'b0;  //Vuelve a cambiar a color azul

            end

            $display("=================================================");
            $display("TEST 2 PASSED: Cambio de color correcto"          );
            $display("=================================================");
            #50 $finish;
        end   
    `endif 

    
    // =========== TEST 3 ===========
    // Prueba corrimiento de leds
    // ==============================
    `ifdef TEST_3

        //Define variables auxiliares
        reg [NB_LEDS-1:0] prev_value;
        integer i;

        //Espera un flanco de subida por cada clock
        task wait_n_clocks(input integer n);
            integer k;
            begin
                for (k = 0; k < n; k = k + 1)
                    @(posedge clock);
            end
        endtask

        initial 
        begin
            //Arrancan desde t=0
                   i_reset    = 1'b0  ;  //Reseteado
                   clock      = 1'b0  ;  //Clock en 0
                   i_sw[0]    = 1'b0  ;  //Contador deshabilitado
                   i_sw[2:1]  = 2'h0  ;  //Velocidad R0
                   i_sw[3]    = 1'b1  ;  //Color verde

            #100   i_reset    = 1'b1  ;  //Sale de reset
                   i_sw[0]    = 1'b1  ;  //Habilita el contador
           
            //Espera el primer pulso de "valid" -> R0 = 2**(NB_COUNT - 10)
                   wait_n_clocks(2**(NB_COUNT - 10));
                   prev_value = o_led;

            //Verifica 4 corrimientos simples
            for (i = 0; i < NB_LEDS; i = i + 1)
            begin
                wait_n_clocks(2**(NB_COUNT - 10));  //Espera un nuevo "valid"

                if (o_led == {prev_value[NB_LEDS-2:0], prev_value[NB_LEDS-1]})
                begin
                    $display("Paso %0d OK: %b", i, o_led);
                end 
                
                else
                begin
                    $display("=================================================");
                    $display("ERROR paso %0d", i);
                    $display("Esperado: %b, Recibido: %b",
                            {prev_value[NB_LEDS-2:0], prev_value[NB_LEDS-1]}, o_led);
                    $display("TEST FAILED");
                    $display("=================================================");
                    $finish;
                end
                prev_value = o_led;
            end
            $display("=================================================" );
            $display("TEST 3 PASSED: Corrimiento correcto a velocidad R0");
            $display("=================================================" );
            $finish;
        end
    `endif


    // =========== TEST 4 ===========
    // Prueba funcionamiento i_sw[0]
    // ==============================
    `ifdef TEST_4
        //Crea variable auxiliar
        reg     [NB_LEDS-1:0] val_led ;  
        integer delay_sw              ;

        initial
        begin
            //Arrancan desde t=0
                   i_reset    <= 1'b0  ;  //Reseteado
                   clock      <= 1'b0  ;  //Clock en 0
                   i_sw[0]    <= 1'b0  ;  //Contador deshabilitado
                   i_sw[2:1]  <= 2'h0  ;  //Velocidad R0
                   i_sw[3]    <= 1'b0  ;  //Color azul

            #100   i_reset    <= 1'b1  ;  //Sale de reset
            #100   i_sw[0]    <= 1'b1  ;  //Contador habilitado

            repeat(5)
            begin
                //Espera algunos ciclos
                 delay_sw = $urandom_range(100, 2000);
                #delay_sw                            ;

                    val_led    <= o_led ;  //Guarda el estado de los leds
                    i_sw[0]    <= 1'b0  ;  //Contador deshabilitado
                
                //Espera algunos ciclos
                 delay_sw = $urandom_range(100, 2000);
                #delay_sw 

                if (o_led !== val_led)
                begin
                    $display("=================================================");
                    $display("TEST 4 FAILED: o_led cambió sin enable"           );
                    $display("=================================================");
                    $finish;
                end
                else
                begin
                    $display("Corriendo test..."                                );
                end

                i_sw[0]    <= 1'b1  ;  //Contador habilitado

            end
                $display("=================================================");
                $display("TEST 4 PASSED: i_sw[0] controla el contador"      );
                $display("=================================================");
                $finish;
            
        
            #50 $finish;
        end
    `endif


    // =========== TEST 5 ===========
    // Prueba velocidades contador
    // ==============================
    `ifdef TEST_5
        localparam R0 = 2**(NB_COUNT-10)-1; 
        localparam R1 = 2**(NB_COUNT-11)-1;
        localparam R2 = 2**(NB_COUNT-12)-1;
        localparam R3 = 2**(NB_COUNT-13)-1; 

        //Crea variable auxiliar
        reg [NB_LEDS   - 1 : 0] val_led   ; 
        reg [NB_COUNT  - 1 : 0] count     ;
        reg [NB_COUNT  - 1 : 0] exp_count ;

        initial
        begin
            //Arrancan desde t=0
                   i_reset    <= 1'b0  ;  //Reseteado
                   clock      <= 1'b0  ;  //Clock en 0
                   i_sw[0]    <= 1'b0  ;  //Contador deshabilitado
                   i_sw[2:1]   = 2'b11 ;  //Velocidad R3
                   i_sw[3]    <= 1'b0  ;  //Color azul
                   count       = 1'b0  ;  //Inicializa contador en 0
                   
                   //Setea valor esperado según velocidad seleccionada
                   case (i_sw[2:1])
                        2'b00: exp_count = R0 + 1'b1;
                        2'b01: exp_count = R1 + 1'b1;
                        2'b10: exp_count = R2 + 1'b1;
                        2'b11: exp_count = R3 + 1'b1;
                   endcase

            #100
                   @(posedge clock)   ;  //Espera al flanco del clock
                   i_reset   = 1'b1   ;  //Sale de reset

                   @(posedge clock)   ;  //Espera al flanco del clock
                   i_sw[0]    = 1'b1  ;  //Contador habilitado
                   val_led    = o_led ;  //Guarda estado inicial de o_leds

            
            //Espera a que haya corrimiento
            @(posedge clock)      ;
            while (o_led != {val_led[NB_LEDS-2:0], val_led[NB_LEDS-1]})
            
            //while (o_led == val_led)
            begin
                count = count + 1'b1  ;
                $display("o_led = %h - val_led = %h", o_led, val_led);
                @(posedge clock)      ;
            end

            #1000                     ;
            //Verifica resultado 
            if (count == exp_count)
            begin
                $display("=================================================");
                $display("TEST 5 PASSED: Corrimiento tras %0d ciclos", count);
                $display("=================================================");
                $finish;

            end
            else
            begin
                $display("=================================================");
                $display("TEST 5 FAILED: Esperado %0d ciclos, pero fue %0d", exp_count, count);
                $display("=================================================");
                $finish;
            end
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
