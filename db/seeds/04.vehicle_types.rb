puts "Cadastrando Tipos De Viaturas..."
vehicle_types = [
                  {
                    description: "AUTO APOIO MECÂNICO",
                    acronym: "AAM",
                    about: "Veículo do grupo VS3, Veículo montado sobre chassis de caminhão leve ou pesado, dotado de guincho, e/ou plataforma para reboque, destinado ao serviço administrativo de apoio mecânico."
                  },
                  {
                    description: "AUTO ATAQUE RÁPIDO",
                    acronym: "AAR",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão leve, dotado de bomba de incêndio de alta pressão e baixa vazão e tanque de água de pequena capacidade, destinado ao transporte da guarnição e equipamentos específicos para o serviço operacional de combate a incêndio."
                  },
                  {
                    description: "AUTO BOMBA TANQUE",
                    acronym: "ABT",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão pesado, dotado de bomba de incêndio de alta pressão e vazão e tanque de água de média capacidade, destinado ao transporte da guarnição e equipamentos específicos para o serviço operacional de combate a incêndio."
                  },
                  {
                    description: "AUTO BUSCA E SALVAMENTO AQUÁTICO",
                    acronym: "ABSA",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão leve ou camionete, destinado ao transporte da guarnição e equipamentos específicos para serviço operacional de busca, salvamento aquático e operações de mergulho."
                  },
                  {
                    description: "AUTO BUSCA E SALVAMENTO COM CÃES",
                    acronym: "ABSC",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão leve ou camionete, destinado ao transporte da guarnição com compartimento para transporte de cães e equipamentos específicos para serviço operacional de busca e salvamento."
                  },
                  {
                    description: "AUTO BUSCA E SALVAMENTO LEVE",
                    acronym: "ABSL",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão leve ou camionete, destinado ao transporte da guarnição e equipamentos específicos para serviço operacional de busca, salvamento e resgate leve."
                  },
                  {
                    description: "AUTO BUSCA E SALVAMENTO PESADO",
                    acronym: "ABSP",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão leve ou camionete, destinado ao transporte da guarnição e equipamentos específicos para serviço operacional de busca, salvamento e resgate pesado."
                  },
                  {
                    description: "AUTO COMANDO OPERACIONAL",
                    acronym: "ACO",
                    about: "Veículo do grupo VS2, montado sobre camioneta com tração 4x4, destinado ao transporte do comandante operacional e sua guarnição, além de equipamentos operacionais específicos."
                  },
                  {
                    description: "AUTO ESCADA",
                    acronym: "AE",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão extrapesado, dotada de escada elevatória, destinado ao transporte da guarnição e equipamentos específicos para o serviço operacional de combate a incêndio e salvamento."
                  },
                  {
                    description: "AUTO PLATAFORMA",
                    acronym: "AP",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão pesado, dotada de plataforma elevatória, destinado ao transporte da guarnição e equipamentos específicos para o serviço operacional de combate a incêndio e salvamento."
                  },
                  {
                    description: "AUTO PREVENÇÃO DE PRAIA",
                    acronym: "APP",
                    about: "Veículo do grupo VS2, tipo quadricíclo destinado ao transporte de militares e equipamentos específicos para o serviço operacional de fiscalização e apoio ao serviço de prevenção em praias."
                  },
                  {
                    description: "AUTO PREVENÇÃO SOCIAL",
                    acronym: "APS",
                    about: "Veículo do grupo VS1, de qualquer dos tipos em uso no CBMPE, destinado ao transporte de militares para o desempenho de atividades de cunho educativo desenvolvidas pelo setor de Comunicação Social da Corporação."
                  },
                  {
                    description: "AUTO RESGATE",
                    acronym: "AR",
                    about: "Veículo do grupo VS2, montado furgão monobloco, destinado ao transporte da guarnição e equipamentos específicos para serviço operacional de resgate e atendimento pré-hospitalar, em especial ao suporte básico de vida."
                  },
                  {
                    description: "AUTO SERVIÇO DE INTELIGÊNCIA",
                    acronym: "ASI",
                    about: "Veículo do grupo VS2, do tipo auto passeio destinado ao transporte de militares do CBMPE no desempenho de atividades investigativas sigilosas de cunho velado."
                  },
                  {
                    description: "AUTO SERVIÇO DE VISTORIA/1",
                    acronym: "ASV/1",
                    about: "Veículo do grupo VS2, do tipo auto passeio destinado ao transporte de guarnição e equipamentos específicos para o serviço operacional de vistorias técnicas."
                  },
                  {
                    description: "AUTO SERVIÇO DE VISTORIA/2",
                    acronym: "ASV/2",
                    about: "Veículo do grupo VS2, do tipo pick-up destinado ao transporte de guarnição e equipamentos específicos para o serviço operacional de vistorias técnicas."
                  },
                  {
                    description: "AUTO SUPORTE AVANÇADO",
                    acronym: "ASA",
                    about: "Veículo do grupo VS2, montado furgão monobloco, destinado ao transporte da guarnição e equipamentos específicos para serviço operacional de resgate e atendimento pré-hospitalar, em especial ao suporte básico de vida."
                  },
                  {
                    description: "AUTO TANQUE/1",
                    acronym: "AT/1",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão pesado, dotado de bomba de incêndio de alta pressão e vazão, possuindo reservatório (tanque) de água de alta capacidade, destinado ao transporte água, da guarnição e equipamentos específicos para o serviço operacional de combate a incêndio."
                  },
                  {
                    description: "AUTO TANQUE/2",
                    acronym: "AT/2",
                    about: "Veículo do grupo VS2, montado sobre chassis de caminhão extrapesado (cavalo mecânico) com semi-reboques, dotado ou não de bomba de incêndio de alta pressão e vazão, possuindo reservatório (tanque) de água de alta capacidade, destinado ao destinado ao transporte água, da guarnição e equipamentos específicos para o serviço operacional de combate a incêndio."
                  },
                  {
                    description: "AUTO TRANSPORTE DE COMBUSTÍVEL",
                    acronym: "ATC",
                    about: "Veículo do grupo VS3, não dotado de motor para propulsão própria, rebocável por outro veículo, em conformidade com a legislação em vigor, destinado ao transporte, armazenamento e distribuição de combustíveis, exclusivamente, para os motores de popa e equipamentos moto mecanizados do CBMPE."
                  },
                  {
                    description: "AUTO TRANSPORTE DE MATERIAL",
                    acronym: "ATM",
                    about: "Veículo do grupo VS3, do tipo utilitário pick-up ou VAN ou caminhão, destinado exclusivamente ao transporte de materiais, equipamentos e cargas."
                  },
                  {
                    description: "AUTO TRANSPORTE DE PESSOAL/1",
                    acronym: "ATP/1",
                    about: "Veículo do grupo VS1, do tipo auto passeio destinado ao transporte de pessoal, para os deslocamentos decorrentes do exercício de atividades externas."
                  },
                  {
                    description: "AUTO TRANSPORTE DE PESSOAL/2",
                    acronym: "ATP/2",
                    about: "Veículo do grupo VS1, do tipo transporte coletivo (ônibus, microônibus, Van), devidamente caracterizado, destinado ao transporte de pessoal, em serviço administrativo, para a realização de atividades externas."
                  },
                  {
                    description: "BARCO DE SALVAMENTO EM ALUMÍNIO",
                    acronym: "BSA",
                    about: "Veículo do grupo VS2, embarcação tipo barco confeccionado em alumínio, destinado ao serviço operacional de salvamento aquático."
                  },
                  {
                    description: "BOTE INFLÁVEL DE SALVAMENTO",
                    acronym: "BIS",
                    about: "Veículo do grupo VS2, embarcação tipo bote inflável, destinado ao serviço operacional de fiscalização e salvamento aquático."
                  },
                  {
                    description: "LANCHA DE SALVAMENTO AQUÁTICO",
                    acronym: "LSA",
                    about: "Veículo do grupo VS2, embarcação tipo lancha, destinado ao serviço operacional de fiscalização e salvamento aquático."
                  },
                  {
                    description: "MOTO ADMINISTRATIVO",
                    acronym: "MA",
                    about: "Veículo do grupo VS1, tipo motocicleta destinado ao transporte pessoal no serviço administrativo externo."
                  },
                  {
                    description: "MOTO DE SALVAMENTO AQUÁTICO",
                    acronym: "MSA",
                    about: "Veículo do grupo VS2, embarcação tipo moto-aquática, destinado ao serviço operacional de fiscalização e salvamento aquático."
                  },
                  {
                    description: "MOTO RESGATE",
                    acronym: "MR",
                    about: "Veículo do grupo VS2, tipo motocicleta destinado ao transporte do socorrista e equipamentos específicos para o serviço operacional de resgate e atendimento pré-hospitalar de vítimas de acidentes."
                  },
                  {
                    description: "MOTO SERVIÇO DE INTELIGÊNCIA",
                    acronym: "MSI",
                    about: "Veículo do grupo VS2, do tipo motocicleta destinado ao transporte de militares do CBMPE no desempenho de atividades investigativas sigilosas de cunho velado."
                  },
                  {
                    description: "MOTO VISTORIA",
                    acronym: "MV",
                    about: "Veículo do grupo VS2, tipo motocicleta destinado ao transporte do vistoriador para o serviço de vistoria técnica e fiscalização."
                  },
                  {
                    description: "REBOQUE",
                    acronym: "RBQ",
                    about: "Veículo do grupo VS3, não dotado de motor para propulsão própria, rebocável por outro veículo, destinado ao transporte de embarcações, equipamentos motomecanizados ou trailer e transporte de animais."
                  }
                ]
vehicle_types.each do |vehicle_type|
  VehicleType.find_or_create_by!(vehicle_type)
end