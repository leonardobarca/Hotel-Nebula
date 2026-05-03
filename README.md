# Hotel Nebula

Modelo de banco de dados relacional para um sistema de gerenciamento hoteleiro.


## Descrição das Entidades

### HOSPEDE
Guarda os dados dos clientes do hotel, como nome, CPF, e-mail e telefone.
Tudo que é necessário para identificar quem vai se hospedar.

### FUNCIONARIO
Guarda os dados dos funcionários do hoetl.
serve para saber quem registrou cada reserva ou realizou cada check-in .

### QUARTO
Representa os quartos do hotel.
Guarda o número, o tipo, o preço da diária e se está disponível ou ocupado.

### RESERVA
Agendamento feito pelo hóspede antes de chegar ao hotel.
Guarda a data de entrada, a data de saída e o valor total da estadia.

### HOSPEDAGEM
Representa a entrada real do hóspede no hotel após o check-in.
Só existe depois que o hóspede chega de verdade, registrando o horário real de entrada e saída.

### PAGAMENTO
Guarda os pagamentos feitos pelo hóspede.
Registra o valor, a forma de pagamento (cartão, pix, dinheiro) e se foi aprovado ou não, junto com nota fsical.

### AVALIACAO
Representa a opinião do hóspede sobre a estadia, feita após o check-out.
O hóspede dá uma nota de 1 a 5 e pode escrever um comentário.

---

## 🔗 Relacionamentos

### HOSPEDE → RESERVA (1:N)
Um hóspede pode fazer várias reservas, mas cada reserva pertence a só um hóspede.

### QUARTO → RESERVA (1:N)
Um quarto pode ser reservado várias vezes em épocas diferentes, mas cada reserva é de um quarto só.

### FUNCIONARIO → RESERVA (1:N)
Um funcionário pode registrar várias reservas, mas cada reserva foi feita por um funcionário só.

### RESERVA → HOSPEDAGEM (1:1)
Cada reserva vira uma hospedagem quando o hóspede faz o check-in.
Uma reserva só pode virar uma hospedagem.

### FUNCIONARIO → HOSPEDAGEM (1:N)
Um funcionário pode fazer o check-in de vários hóspedes, mas cada check-in foi feito por um funcionário só.

### HOSPEDAGEM → PAGAMENTO (1:N)
Uma hospedagem pode ter mais de um pagamento, por exemplo se o hóspede pagar em partes.
Cada pagamento pertence a uma hospedagem só.

### HOSPEDAGEM → AVALIACAO (1:1)
Cada hospedagem pode receber só uma avaliação.
O hóspede não pode avaliar a mesma estadia duas vezes.

### HOSPEDE → AVALIACAO (1:N)
Um hóspede pode fazer várias avaliações ao longo das suas estadias,
mas cada avaliação foi escrita por um hóspede só.
