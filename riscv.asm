.text	# 0x00000000 
.globl _start
_start:
    # Get the base address of the frame buffer.
    # The linker script (riscv.ld) places .data at 0x200.
    la   s0, frame_buffer    # s0 = 0x200

    # Set s1 to be our loop counter.
    # We only have 128 words of video RAM (RAM[128] to RAM[255])
    li   s1, 128

    # Load t0 with a color. 0x0C0C0C0C = Green
    li   t0, 0x0C0C0C0C

fill_loop:
    # Store the color word at the current address
    sw   t0, 0(s0)

    # Move to the next word
    addi s0, s0, 4

    # Decrement counter
    addi s1, s1, -1

    # Loop if counter is not zero
    bnez s1, fill_loop

end:
    # Trap the program in an infinite loop
    j end
	
.data	# 0x00000200 
frame_buffer: 
    # This label just marks the start of the video memory at 0x200.
	.space 512 # Reserve the 512 bytes given by riscv.ld