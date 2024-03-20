-- Group by/Having 
-- Projetar número de funcionarios que venderam mais que 2 pacotes
select f.nome, count(*)
from funcionario f inner join 
vendido v on v.CPFfuncionario = f.CPF
group by f.nome
having count(*) > 2;

-- Junção interna
-- Pacotes vendidos por funcionarios
select f.nome, v.codPacote
from funcionario f inner join 
vendido v on v.CPFfuncionario = f.cpf;

-- Junção externa
-- Nome dos destinos sem pacote
select d.nome
from destino d full outer JOIN
pacote p on d.ID = p.IDdestino
where d.id is NULL or p.IDdestino is NULL;

-- Semi junção
-- Projetar os nomes dos compradores que compraram algum pacote
select c.nome
from comprador c 
where EXISTS (select *
            from compra o
            where o.CPFcomprador = c.cpf);

-- Anti junção
-- Pacotes que não foram comprados
select p.cod
from pacote p
where NOT EXISTS (select *
                from compra o
                where o.codPacote = p.cod);

-- Subconsulta do tipo escalar
-- Consultar codigo do hotel mais caro
select h.id
from hotel h
where h.valor >= all (select valor 
                        from hotel);


-- Subconsulta do tipo linha
-- projetar dtIDA do pacote que vai para buenos aires
select dtIDA
from pacote
where (dtVolta, IDdestino) = (select p.dtVolta, p.IDdestino
                        from pacote p where p.IDdestino = '0014' and p.dtVolta = TO_DATE('18/03/2025','DD/MM/YYYY'));

-- Subconsulta do tipo tabela
-- nome dos destinos que estao em algum pacote
select d.nome
from destino d
where d.id in (select IDdestino from pacote where d.id=IDdestino);

-- Operação de conjunto
-- pacotes que foram vendidos pelo funcionario '2012' e '2014'
select *
from (select p1.codPacote from vendido p1 where p1.CPFfuncionario = '2012')
INTERSECT 
(select p2.codPacote from vendido p2 where p2.CPFfuncionario = '2014');



--EXTRA
-- Quais pacotes foram vendidos e comprados
select distinct p.cod, comp.nome
from pacote p inner join 
compra c on p.cod = c.codPacote inner join
vendido v on v.codPacote = c.codPacote inner join
comprador comp on comp.CPF = c.CPFcomprador;
