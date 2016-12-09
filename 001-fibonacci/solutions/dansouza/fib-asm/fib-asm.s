# gcc -o fib-asm fib-asm.s && ./fib-asm

        # inicia a secao de texto (codigos) do binario
        .text
        .globl  main
        .globl  fib

fib:
        # funcao fib()
        # inicializa a stack com 24 bytes
        pushq   %rbp
        movq    %rsp, %rbp
        pushq   %rbx
        subq    $24, %rsp

        # pega o contador do loop (argumento passado pra funcao) e joga pra -20(%rbp)
        movl    %edi, -20(%rbp)
        # compara <= 1
        cmpl    $1, -20(%rbp)
        # se for <= 1, vai pra menor_igual_um
        jle     .menor_igual_um

.calcula_fib:
        # pega o argumento da fib() e joga em %eax
        movl    -20(%rbp), %eax
        # subtrai um dele
        subl    $1, %eax
        # pega o valor subtraido e joga em %edi pra chamar a funcao fib() denovo com ele como argumento
        movl    %eax, %edi
        # chama a fib denovo, resultado do calculo vai tah em %eax
        call    fib

        # pega o resultado do calculo da primeira fib() e salva em %ebx pra mais tarde...
        movl    %eax, %ebx
        # pega o contador do loop e joga em %eax
        movl    -20(%rbp), %eax
        # dessa vez subtrai 2 dele...
        subl    $2, %eax
        # e joga ele denovo como primeiro argumento pra chamada #2 da fib()
        movl    %eax, %edi
        # chama a fib denovo!
        call    fib
        # adiciona o resultado da primeira chamada da fib() salvo em %ebx com essa ultima chamada,
        # o resultado final ja fica em %eax pronto pra vazar
        addl    %ebx, %eax

.vaza:
        # volta a stack 24 bytes pra traz e retorna da funcao fib()
        addq    $24, %rsp
        popq    %rbx
        popq    %rbp
        ret

.menor_igual_um:
        # joga o primeiro argumento (0 ou 1) pra %eax
        movl -20(%rbp), %eax
        # retorna
        jmp     .vaza

main:
        # configura a stack da main() com 16 bytes
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $16, %rsp

        # inicia contador do loop com 0 em -4(%rbp), os primeiros 4 bytes da stack
        movl    $0, -4(%rbp)
        # inicia o loop
        jmp     .testaloop

.loop:
        # prepara pra chamar a funcao fib:
        # pega o contador do loop e joga ele em %edi pra ser o argumento da fib()
        movl    -4(%rbp), %edi
        # chama a funcao fib
        call    fib

        # salva o retorno da funcao fib() em %edx como argumento pra printf()
        movl    %eax, %edx
        # salva o contador do loop como argumento pra printf()
        movl    -4(%rbp), %esi
        # salva em %rdi o endereco da string de formato
        leaq    .formato(%rip), %rdi
        # limpa retorno da funcao
        movl    $0, %eax
        # chama printf
        call    printf@PLT
        # incrementa o contador do loop
        addl    $1, -4(%rbp)

.testaloop:
        # compara o contador com 40
        cmpl    $45, -4(%rbp)
        # se for menor ou igual que 40, roda uma iteracao do loop
        jle     .loop
        # nao eh menor ou igual, loop chegou no final, vaza
        movl    $0, %eax
        leave
        ret

        # secao de dados read-only
        .section .rodata

.formato:
        # variavel que passamos como argumento pra printf()
        .string "fib(%d)=%d\n"
