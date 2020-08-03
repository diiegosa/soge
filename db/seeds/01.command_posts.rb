puts "Cadastrando Postos De Comando..."
command_posts = 
  [
    {
      description: CommandPost::GET[:PCG][:DESCRIPTION],
      acronym: CommandPost::GET[:PCG][:ACRONYM]
    },
    {
      description: CommandPost::GET[:PCAA][:DESCRIPTION],
      acronym: CommandPost::GET[:PCAA][:ACRONYM]
    },
    {
      description: CommandPost::GET[:PCAB][:DESCRIPTION],
      acronym: CommandPost::GET[:PCAB][:ACRONYM]
    },
    {
      description: CommandPost::GET[:PCAC][:DESCRIPTION],
      acronym: CommandPost::GET[:PCAC][:ACRONYM]
    }
  ]
command_posts.each do |command_post|
  CommandPost.find_or_create_by!(command_post)
end