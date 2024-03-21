-- Group by/Having 
-- Projetar os funcionarios que venderam mais que 2 pacotes e quantos pacotes venderam
select f.nome, count(*)
from funcionario f inner join 
vendido v on v.CPFfuncionario = f.CPF
group by f.nome
having count(*) > 2;

-- Junção interna
-- Pacotes vendidos por funcionarios e quais funcionarios os venderam
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
-- Consultar codigo do hotel mais barato
select h.id
from hotel h
where h.valor = (select MIN(valor)
                        from hotel);


-- Subconsulta do tipo linha
--projetar funcionar com maior salário que é chefiado pelo funcionário de CPF 2001
select nome,CPF,salario
from funcionario
where (chefe, salario) = (select f.chefe, max(f.salario)
    					  from funcionario f
    					  where f.chefe = '2001'
						  group by f.chefe);

-- Subconsulta do tipo tabela
-- cpf de cada chefe e nome de seu funcionario mais bem pago
select chefe, nome
from funcionario
where (chefe,salario) in (select f.chefe, max(f.salario)
    						from funcionario f
    						group by f.chefe)
order by chefe;

-- Operação de conjunto
-- pacotes que foram vendidos pelo funcionario '2012' e '2014'
select *
from (select p1.codPacote from vendido p1 where p1.CPFfuncionario = '2012')
INTERSECT 
(select p2.codPacote from vendido p2 where p2.CPFfuncionario = '2014');


