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
 - Clique em "Alocar endereço IP elástico".
 - Configure como quiser ou, neste caso, deixe as opções padrão e clique em "alocar".
 - Selecione o IP Elástico criado e clique em "Ações" e depois em "Associar endereço IP elástico".
 - Selecione a instância EC2 criada anteriormente e clicar em "Associar".
### Criando gateway de internet
 - Em serviços, na parte superior, pesquise por VPC e clique, depois vá em "Gateways da internet" no menu lateral esquerdo.
 - Clique em "Criar gateway da internet".
 - Defina um nome para o gateway e clicar em "Criar gateway de internet".
### Associando gateway de internet
 - No painel de "gateway de internet", selecione o gateway criado e clique em "Ações" > "Associar à VPC".
 - Selecione a vpc Default e finalize.
 
 ### Configurando rotas de internet
 - Continuando no serviço VPC, na lateral esquerda, vá em "Tabelas de rotas".
 - Selecione a tabela de rotas da VPC.
 - Clique em "Ações" e selecione "Editar rotas".
 - Clique em "Adicionar rota".
 - Configurar da seguinte forma:
    - Destino - 0.0.0.0/0
    - Alvo - Selecione o gateway de internet e depois o mesmo que foi criado.
  - Clique em "Salvar alterações".

### Configurando grupo e regras de segurança
 - Acesse novamente o serviço EC2.
 - No menu lateral esquerdo, clique em "Grupos de segurança".
 - Selecione o grupo de segurança da instância EC2 criada.
 - Vá em "Ações" > "Editar regras de entrada".
 - Configure as regras da seguinte forma: 
 
     Tipo | Protocolo | Intervalo de portas | Origem  
    ---|---|---|---
    SSH | TCP | 22 | 0.0.0.0/0 | SSH
    TCP personalizado | TCP | 80 | 0.0.0.0/0  
    TCP personalizado | TCP | 443 | 0.0.0.0/0  
    TCP personalizado | TCP | 111 | 0.0.0.0/0  
    UDP personalizado | UDP | 111 | 0.0.0.0/0 
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 
    UDP personalizado | UDP | 2049 | 0.0.0.0/0  

### Configurando EFS/NFS no console AWS
 - Acesse os serviços e pesquise por EFS, clique no mesmo.
 - Clique em "Criar sistema de arquivos".
 - Dê um nome ao seu EFS e escolha a VPC configurada anteriormente.
 - Selecione o EFS criado e clique em "Visualizar detalhes".
 - Agora, no canto superior direito, clique em "Anexar".
 - Na opção "Usando o cliente NFS:", copie o código.

### Configurando NFS
 - Conecte-se ao seu servidor Amazon Linux 2 usando SSH ou qualquer outra ferramenta de acesso remoto.
 - Atualize os pacotes da sua maquina ```sudo yum -y update```
 - Crie o diretório para o NFS ```sudo mkdir /nfs```
 - Para montar o NFS no diretório, execute o comando copiado do tópico anterior e substitua a última palavra('efs') pelo caminho do diretório que você quer o NFS, neste caso ```/nfs```. Pronto, NFS funcionando.
 - Agora para criar um diretório com seu nome(no meu caso "Pedro"), acesse o diretório e crie-o
 ```cd /nfs```
 ```sudo mkdir pedro```

### Configurando o Apache
 - Ainda no seu terminal da sua instância, Instale o Apache
  ```sudo yum install httpd```
 - Após a instalação, inicie o serviço do Apache 
 ```sudo systemctl start httpd```
 - Agora use o comando para habilitá-lo ```sudo systemctl enable httpd```
 - Verifique se o serviço do Apache está em execução (Se tudo estiver correto, você verá uma mensagem indicando que o serviço está ativo (running)) ```sudo systemctl status httpd``` e então o Apache estará online e em execução, podendo acessá-lo digitando o  IP público do seu servidor na barra de pesquisa do seu navegador. 

### Script para validação do status do Apache
 - No terminal da instância, vá para o seu diretório: ```cd /nfs/pedro```
 - Crie um novo arquivo .sh para implementar o código de validação. Para isso, siga as etapas seguintes.
 - Crie o arquivo ```sudo vi validador_apache.sh```
 - Insira nele o código:
```
#!/bin/bash

   # Diretório de saída
   dir_de_saida="/nfs/pedro"

# Função para verificar o status do Apache e registrar o resultado
validador_apache() {
    apache_status=$(systemctl is-active httpd)

    if [[ $apache_status == "active" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Apache Online - O Apache está em execução." >> "$dir_de_saida/apache_online.txt"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') Apache Offline - O Apache não está em execução." >> "$dir_de_saida/apache_offline.txt"
    fi
}

# Executa a função 
validador_apache
``` 

 - Salve o arquivo.
 - Agora dê permissão de execução ao arquivo ```sudo chmod +x validador_apache.sh```

### Configurando NFS para persistir mesmo após uma reinicialização da EC2
Por padrão, após uma reinicialização da instância, o sistema de arquivos que estava montado na mesma não é remontado automáticamente, mas para que isso mude, devemos seguir os próximos passos.
 - Abra e edite o arquivo '/etc/fstab' usando o comando ```sudo vi /etc/fstab```.
 - No final do arquivo /etc/fstab, adicione uma nova linha com as informações do sistema de arquivos a serem montadas. A sintaxe geral é: 
 ```<endereço_do_servidor>:<caminho_remoto>  <ponto_de_montagem_local>  <tipo_de_sistema_de_arquivos>  <opções_de_montagem>  <dump>  <pass>```
 Neste caso usaremos:
 ```<endereço_do_servidor_nfs>:/nfs  /nfs  nfs  defaults  0  0```
 - Salve o arquivo.
 
### Automatizando a execução do código validador
Para automatizar o processo e o código ser executado a cada 5 minutos devemos utilizar o crontab(agendador de tarefas de sistemas operacionais Linux).
 - Ainda no terminal da instância, edite o crontab ```sudo crontab -e```
 - Agora, adicione no arquivo: ```*/5 * * * * /nfs/pedro/validador_apache.sh```







 
