# Manual de configuração da **Loja de Aplicativos Web**

Este manual tem como objetivo auxiliar na configuração da máquina servidor do aplicativo.

## Sumário

* [Pré requisitos](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#pr%C3%A9-requisitos)
* [Download pré requisitos](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#download-pr%C3%A9-requisitos)

  * [Eclipse](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#eclipse)
  * [Apache Tomcat v8.0.46](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#apache-tomcat-v8046)
  * [MySQL](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#mysql)
  * [JDK](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#jdk)
  * [Git](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#git)

* [Instalação](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#instala%C3%A7%C3%A3o)

  * [Instalando os pré requisitos](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#instalando-os-pr%C3%A9-requisitos)
  * [Clonando o projeto](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#clonando-o-projeto)

* [Configurações no Eclipse Neon](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#configura%C3%A7%C3%B5es-no-eclipse-neon)

  * [Navegador padrão](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#navegador-padr%C3%A3o)
  * [Configure o Apache Tomcat](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#configure-o-apache-tomcat)
  * [Configure o banco de dados](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#configure-o-banco-de-dados)
  * [Importe o projeto **LojaDeAplicativosWeb**](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#importe-o-projeto-lojadeaplicativosweb)

* [Problemas Conhecidos](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#problemas-conhecidos)

  * [Erro na biblioteca JRE System Library](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#erro-na-biblioteca-jre-system-library)
  * [Erro ao acessar banco de dados](https://gitlab.com/victorlobo/LojaDeAplicativosWeb/blob/master/README.md#erro-ao-acessar-banco-de-dados)


## Pré requisitos

* Eclipse Neon 4.6.0 ou superior
* Apache Tomcat v8.0.x (exlusivamente)
* MySQL
* JDK
* Git

## Download pré requisitos

### Eclipse
* [Windows 32-bit (.zip)](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-win32.zip)
* [Windows 64-bit (.zip)](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-win32-x86_64.zip)
* [Linux 32-bit (.tar.gz)](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk.tar.gz)
* [Linux 64-bit (.tar.gz)](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz)

### Apache Tomcat v8.0.46
* [Windows 32-bit (.zip)](http://ftp.unicamp.br/pub/apache/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46-windows-x86.zip)
* [Windows 64-bit (.zip)](http://ftp.unicamp.br/pub/apache/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46-windows-x64.zip)
* [Linux (zip)](http://ftp.unicamp.br/pub/apache/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46.zip)
* [Linux (.tar.gz)](http://ftp.unicamp.br/pub/apache/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46.tar.gz)

### MySQL
Vá até a página do MySQL Workbench e selecione o download adequado ao seu sistema operacional.

* [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

### JDK
* [Java SE Development Kit](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
> Obs.: Abrir link e aceitar o contrato de licença, depois clicar no link para baixar a versão desejada [Windows x86 (32 bits), Windows x64 (64 bits), Linux x86 (32 bits) ou Linux x64 (64 bits)]

### Git

* [Windows 32-bit (.exe)](https://github.com/git-for-windows/git/releases/download/v2.14.2.windows.1/Git-2.14.2-32-bit.exe)
* [Windows 64-bit (.exe)](https://github.com/git-for-windows/git/releases/download/v2.14.2.windows.1/Git-2.14.2-64-bit.exe)
* [Linux (link)](https://git-scm.com/download/linux)

## Instalação
### Instalando os pré requisitos

> Obs.: Veja a documentação de cada aplicação para realizar sua instalação e configuração corretamente.

### Clonando o projeto

Usando o cmd (no Windows) ou o terminal (no Linux), navegue até a pasta workspace do Eclipse. Caso a pasta não exista, execute o Eclipse para criar a pasta. Será solicitado escolher o local da pasta.
```
cd <pasta_workspace_criada_pelo_eclipse>
```
Clone o projeto do gitlab.
```
git clone https://gitlab.com/victorlobo/LojaDeAplicativosWeb.git
```

## Configurações no Eclipse Neon
### Navegador padrão
Escolha o navegador que deseja utilizar ao rodar a aplicação.

Vá em `Window > Web Browser > [seu_navegador]`.

### Configure o Apache Tomcat

Configure o servidor Apache Tomcat no Eclipse.

1. Vá em `Window > Preferences`.
2. Na janela que se abrir, no menu lateral, vá em `Server > Runtime Environments`.
3. Clique no botão `Add...`.
4. Navegue até `Apache > Apache Tomcat v8.0` e clique em `Next >`.
5. Clique no botão `Browse...` e selecione a pasta onde está instalado o **Apache Tomcat 8** e clique em `OK`.
6. Clique no botão `Finish`.
7. Clique no botão `OK` para fechar a janela **Preferences**.

### Configure o banco de dados

Ao clonar o projeto do Git, uma pasta **BDMySQL** com um arquivo **script-sql.sql** foi clonada.
Utilize o workbench para rodar este arquivo **script-sql.sql** e criar o banco de dados.

### Importe o projeto **LojaDeAplicativosWeb**

1. No Eclipse, clique em `File > Import...`.
2. Navegue até `General > Existing Projects into Workspace` e clique em `Next >`
3. Clique em `Browse...`, selecione o diretório onde o projeto foi clonado e clique em `OK`.
4. Certifique-se de que **LojaDeAplicativosWeb** está selecionado e clique em `Finish`.

---

## Problemas Conhecidos

Uma vez importado o projeto, pode ser necessário realizar alguns ajustes.

### Erro na biblioteca JRE System Library
Caso o sistema apresente erro nesta biblioteca, siga os passos:
1. Em **Project Explorer**, clique com o botão direito do mouse sobre o projeto **LojaDeAplicativosWeb**, clique em `Build Path > Configure Build Path...`.
2. Na aba **Libraries**, clique uma vez na biblioteca **JRE System Library** que está apresentando erro, depois clique em `Edit...`.
3. Na janela que se abrir, em **Alternate JRE**, selecione a JRE que foi instalada como pré requisito deste projeto e depois clique em `Finish` e por fim em `OK`.

### Erro ao acessar banco de dados
É possível que a senha do seu banco de dados não seja a mesma configurada no projeto. Neste caso, siga os passos:

1. Em **Project Explorer**, no projeto **LojaDeAplicativosWeb**, navegue até `Java Resources > src > com.lojaappweb.conn > MySQLConnUtils.java`.
2. Edite o arquivo alterando o parâmetro **password** do método **getMySQLConnection()**.
3. Salve o arquivo.