--CRIANDO AS TABELAS

create table comprador(  
    CPF varchar(11),
    nome varchar(100),
    socialInsta varchar(100),
    socialFace varchar(100),
    constraint PK_comprador primary key (CPF)
);

create table contatoComprador( 
    CPF varchar(11),
    numeroContato varchar(14),
    constraint PK_contatoComprador primary key (CPF, numeroContato),
    constraint FK_contato_comprador foreign key (CPF) references comprador on delete cascade
);

create table destino(
    ID varchar(11),
    nome varchar(100),
    constraint PK_destino primary key (ID)
);

create table pacote( 
    cod varchar(11),
    dtIda date,
    dtVolta date,
    IDdestino varchar(11) NOT NULL UNIQUE,
    constraint PK_pacote primary key (cod),
    constraint FK_pacote_destino foreign key (IDdestino) references destino on delete cascade
);

create table pacoteNacional( 
    codN varchar(11),
    valorRS number,
    constraint PK_pacoteNacional primary key (codN),
    constraint FK_pacoteNacional_pacote foreign key (codN) references pacote on delete cascade
);


create table pacoteInternacional( 
    codI varchar(11),
    valorUS number,
    constraint PK_pacoteInternacional primary key (codI),
    constraint FK_pacoteInternacional_pacote foreign key (codI) references pacote on delete cascade
);

create table compra(
    codPacote varchar(11),
    CPFcomprador varchar(11),
    dtCompra date NOT NULL,
    constraint PK_compra primary key (codPacote, CPFcomprador),
    constraint FK_compra_pacote foreign key (codPacote) references pacote on delete cascade,
    constraint FK_compra_comprador foreign key (CPFcomprador) references comprador on delete cascade
);

create table seguro( --ok
    ID varchar(11),
    valor number,
    CPFcomprador varchar(11) NOT NULL UNIQUE,
    codPacote varchar(11) NOT NULL UNIQUE,
    constraint PK_seguro primary key (ID),
    constraint FK_seguro_pacote foreign key (codPacote) references pacote on delete cascade,
    constraint FK_seguro_comprador foreign key (CPFcomprador) references comprador on delete cascade
);

create table hotel( --ok
    ID varchar(11),
    IDdestino varchar(11),
    valor number,
    constraint PK_hotel primary key (ID, IDdestino),
    constraint FK_hotel_destino foreign key (IDdestino) references destino on delete cascade
);

create table bonificacao(
    cod varchar(11),
    valor number,
    constraint PK_bonificacao primary key (cod)
);

create table funcionario(
    CPF varchar(11),
    salario number,
    constraint PK_funcionario primary key (CPF)
);

create table contatoFuncionario(
    CPF varchar(11),
    numeroContato varchar(14),
    constraint PK_contatoFuncionario primary key (CPF, numeroContato),
    constraint FK_contato_funcionario foreign key (CPF) references funcionario on delete cascade
);

create table chefe( --nao tenho certeza
    CPFchefe varchar(11),
    constraint PK_chefe primary key (CPFchefe),
    constraint FK_chefe_funcionario foreign key (CPFchefe) references funcionario on delete cascade
);

create table subordinado( --nao tenho certeza
    CPFsubordinado varchar(11),
    CPFchefe varchar(11),
    constraint PK_subordinado primary key (CPFsubordinado),
    constraint FK_subordinado_chefe foreign key (CPFchefe) references chefe on delete cascade,
    constraint FK_subordinado_funcionario foreign key (CPFsubordinado) references funcionario on delete cascade
);

create table vendido(
    codPacote varchar(11),
    CPFfuncionario varchar(11),
    codBonificacao varchar(11),
    constraint PK_vendido primary key (codPacote, CPFfuncionario),
    constraint FK_vendido_pacote foreign key (codPacote) references pacote on delete cascade,
    constraint FK_vendido_funcionario foreign key (CPFfuncionario) references funcionario on delete cascade,
    constraint FK_vendido_bonificacao foreign key (codBonificacao) references bonificacao on delete cascade
);
