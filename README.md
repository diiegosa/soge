<h1 align="center">Sistema Operacional para Grandes Eventos (SOGE)</h1>
<p align="justify">
O sistema em questão foi desenvolvido para o Corpo de Bombeiros e faz a gestão dos grandes eventos em três frentes: 
  <ul>
    <li>
      <b>Serviços técnicos</b>, que se referem às vistorias e análise da estrutura do evento. Dentro deste universo, há a opção da gerencia dos serviços e também a opção da geração do cartaz com o QRCODE que indicará o status da regularização do evento.
    </li>
    <li>
      <b>Serviços operacionais</b>, que lidam com a atuação dos bombeiros durante o evento. Nesse caso o sistema leva em consideração os bombeiros envolvidos e as intervenções realizadas.
    </li>
    <li>
      <b>Relatórios e gráficos</b>. O sistema possui vários gráficos indicando qual o status do evento em tempo real e permite a geração de relatórios, tanto em pdf quanto em excel. 
    </li>
  </ul>
  Para além do exposto, o SOGE possui o módulo de gestão do usuário e dos perfis de acesso que orientam a renderização das telas e o acesso às funcionalidades do sistema. 
</p> 
<hr />

<h3 align="center">Algumas tecnologias e libs utilizadas</h3>  


- [Ruby on Rails](https://rubyonrails.org/): Framework base para criação/gestão do projeto.
- [React](https://reactjs.org/): Biblioteca JavaScript para algumas interfaces do sistema.
- [Postgres](https://www.postgresql.org/): Banco de dados utilizado.
- [AdminLTE 3](https://adminlte.io/docs/3.0/): Template baseado em Bootstrap.
- [gem 'devise'](https://rubygems.org/gems/devise/versions/4.2.0?locale=pt-BR): Solução para a autenticação e gestão do usuário.
- [gem 'cancancan'](https://rubygems.org/gems/cancancan/versions/1.15.0?locale=pt-BR): Gerencia as autorizações e permissões dos usuários.
- [gem 'ransack'](https://rubygems.org/gems/ransack): Solução para realização de buscas.
- [gem 'wicked_pdf'](https://rubygems.org/gems/wicked_pdf/): Gem usada para criação dos arquivos PDF.
- [gem 'caxlsx'](https://rubygems.org/gems/caxlsx_rails): Gem usada para criação dos arquivos EXCEL.
- [gem 'rqrcode'](https://rubygems.org/gems/caxlsx_rails): Solução para gerar os QRCODEs.
