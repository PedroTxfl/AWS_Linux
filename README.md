# Atividade de AWS e Linux
## Descrição dos requisitos da atividade:
- ### Na AWS:
  -  Gerar uma chave pública para acesso ao ambiente;
  - Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD);
  - Gerar 1 elastic IP e anexar à instância EC2;
  - Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP).

- ### No linux:
  - Configurar o NFS entregue;
  - Criar um diretorio dentro do filesystem do NFS com seu nome;
  - Subir um apache no servidor - o apache deve estar online e rodando;
  - Criar um script que valide se o serviço esta online e envie o resultado da validação
para o seu diretorio no nfs;
  - O script deve conter - Data HORA + nome do serviço + Status + mensagem
personalizada de ONLINE ou offline;
  - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço
OFFLINE;
  - Preparar a execução automatizada do script a cada 5 minutos.
  - Fazer o versionamento da atividade;
  - Fazer a documentação explicando o processo de instalação do Linux.

------------

# Atividade de AWS e Linux
## Descrição dos requisitos da atividade:
- ### Na AWS:
  -  Gerar uma chave pública para acesso ao ambiente;
  - Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small,
16 GB SSD);
  - Gerar 1 elastic IP e anexar à instância EC2;
  - Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP).

- ### No linux:
  - Configurar o NFS entregue;
  - Criar um diretorio dentro do filesystem do NFS com seu nome;
  - Subir um apache no servidor - o apache deve estar online e rodando;
  - Criar um script que valide se o serviço esta online e envie o resultado da validação
para o seu diretorio no nfs;
  - O script deve conter - Data HORA + nome do serviço + Status + mensagem
personalizada de ONLINE ou offline;
  - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço
OFFLINE;
  - Preparar a execução automatizada do script a cada 5 minutos.
  - Fazer o versionamento da atividade;
  - Fazer a documentação explicando o processo de instalação do Linux.

------------
## Passo a passo para a execução
### Acesse e faça o login em https://console.aws.amazon.com/ .
### Gere um par de chaves
 - Na parte superior clique em "Serviços" e pesquise por EC2.
 - Clicar em "Pares de chaves" e depois em "Criar pares de chaves".
 - Insira um nome para o par de chaves e selecione o formato de arquivo de chave privada como ".ppk", e clique em "Criar pares de chaves".
 - O arquivo .ppk será baixado e você deve guardá-lo em um local seguro.
### Crie a instância
 - No menu lateral esquerdo, clique em "Instâncias.
 - Cliquei em "Executar instâncias".
 - Clique em "adicionar mais tags" e configure as três tags Name, Project e CostCenter inserindo valores e acrescentando o tipo de recurso "Volumes".
 - Configure os itens:
   - AMI - Amazon Linux 2
   - Tipo de instância - t2.micro
   - Par de chaves - Selecione a criada anteriormente
   - Armazenamento - 16 Gib gp2
 - Execute a instância.
### Criando e anexando IP elástico
 - Na lateral esquerda, clique em IPs elásticos.
 - Clique em "Alocar endereço IP elástico.
 - Selecione o ip alocado e clique em "Ações" e depois em "Associar endereço IP elástico".
 - Selecione a instância EC2 criada anteriormente e clicar em "Associar".
### Configurando gateway de internet
 - Em serviços, na parte superior, pesquise por VPC e clique, depois vá em "Gateways da internet" no menu lateral esquerdo.
 - Clique em "Criar gateway da internet".
 - Defina um nome para o gateway e clicar em "Criar gateway de internet".
 - Selecione o gateway criado e clique em "Ações" > "Associar à VPC".
 - Selecione a VPC da instância EC2 criada anteriormente e clique em "Associar".
### Configurando rotas de internet
 - Na parte lateral esquerda, vá em Tabelas de rotas.
 - Selecione a tabela de rotas da VPC.
 - Clique em "Ações" e selecione "Editar rotas".
 - Clique em "Adicionar rota".
 - Configurar da seguinte forma:
    - Destino - 0.0.0.0/0
    - Alvo - Selecione o gateway de internet criado.
  - Clique em "Salvar alterações".
### Configurando grupo e regras de segurança
 - Acesse novamente o serviço EC2.
 - No menu lateral esquerdo, clique "Grupos de segurança".
 - Selecione o grupo de segurança da instância EC2 criada.
 - Clique em "Editar regras de entrada".
 - Configure as regras da seguinte forma: 
 
     Tipo | Protocolo | Intervalo de portas | Origem | Descrição
    ---|---|---|---|---
    SSH | TCP | 22 | 0.0.0.0/0 | SSH
    TCP personalizado | TCP | 80 | 0.0.0.0/0 | HTTP
    TCP personalizado | TCP | 443 | 0.0.0.0/0 | HTTPS
    TCP personalizado | TCP | 111 | 0.0.0.0/0 | RPC
    UDP personalizado | UDP | 111 | 0.0.0.0/0 | RPC
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 | NFS
    UDP personalizado | UDP | 2049 | 0.0.0.0/0 | NFS