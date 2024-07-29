module blink_led (
    input wire clk_i,
    output reg blink_o
);
    
    reg [25:0] cnt;
    
    always @ (posedge clk_i) begin
        cnt <= cnt + 1;
        blink_o <= cnt[25];
    end
    
endmodule
