%use smartalign
alignmode p6

section .text
global lfsr_64
lfsr_64:
;; We use the primitive polynomial
;;     x^64 + x^63 + x^58 + x^55 + x^50 + x^49 + x^46 + x^45 + x^44 +
;;     x^39 + x^32 + x^30 + x^21 + x^20 + x^18 + x^16 + x^15 + x^14 +
;;     x^13 + x^10 + x^8 + x^6 + x^5 + x^4 + x^2 + x + 1
;; to construct a 64-bit LFSR.
;; Alternative: x^64 + x^4 + x^3 + x + 1.
        push    rdx
        push    rcx
        push    rsi
        mov     rdx, 0x848670814035E577
        mov     cl, 0x41
.loop:
        dec     cl
        mov     rax, rdx
        and     rax, rdi
        mov     esi, eax
        shr     rax, 0x20
        xor     eax, esi
        mov     si, ax
        shr     eax, 0x10
        xor     ax, si
        xor     al, ah
        test    al, al
        jp      .L1
        stc
.L1:
        rcr     rdi, 1
        test    cl, cl
        jnz     .loop
        pop     rsi
        pop     rcx
        pop     rdx
        mov     rax, rdi
        ret
