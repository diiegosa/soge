puts "Cadastrando Naturezas De Ocorrências..."
occurrence_natures =  [
                        {
                          description: "VISTORIA TÉCNICA",
                          occurrence_type_id: OccurrenceType.get_operational_technical_services_id
                        },
                        {
                          description: "RECEBIMENTO DENÚNCIA TÉCNICA",
                          occurrence_type_id: OccurrenceType.get_operational_technical_services_id
                        },
                        {
                          description: "ANÁLISE DE PROJETOS DE PCI DE EVENTOS LIGADOS AO CARNAVAL",
                          occurrence_type_id: OccurrenceType.get_technical_services_id
                        },
                        {
                          description: "VISTORIA / FISCALIZAÇÃO TÉCNICA",
                          occurrence_type_id: OccurrenceType.get_technical_services_id
                        },

                        {
                          description: "INCÊNDIO EM ÁREA VERDE",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "INCÊNDIO EM EDIFICAÇÃO-CONCENTRAÇÃO DE PÚBLICO",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "INCÊNDIO EDIFICAÇÃO-RESIDÊNCIA",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "INCÊNDIO EDIFICAÇÃO-COMERCIAL",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "INCÊNDIO EDIFICAÇÃO-OUTROS",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "INCÊNDIO EM MEIO DE TRANSPORTE",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "VAZAMENTO DE PRODUTO PERIGOSO-GLP",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "PRODUTOS PERIGOSOS",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "INCÊNDIO OUTROS-ESPECIFICAR",
                          occurrence_type_id: OccurrenceType.get_fire_services_id
                        },
                        {
                          description: "ABERTURA DE RESIDÊNCIA",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "BUSCA/RESGATE",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "CAPTURA/RESGATE DE ANIMAL",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "DESOBSTRUÇÃO DE VIA",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "RESGATE DE VÍTIMA DE DESABAMENTO",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "RESGATE VÍTIMA-ELEVADOR",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "TENTATIVA DE SUICÍDIO",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "RECUPERAÇÃO DE CADÁVER",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "SALVAMENTO AQUÁTICO-AFOGAMENTO",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "CRIANÇA PERDIDA",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "SALVAMENTO OUTRO-ESPECIFICAR",
                          occurrence_type_id: OccurrenceType.get_rescue_services_id
                        },
                        {
                          description: "ACIDENTE TRÂNSITO-COLISÃO/ABALROAMENTO/CAPOTAMENTO/CHOQUE",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "ACIDENTE TRÂNSITO-ATROPELAMENTO",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "ACIDENTE MOTOCICLÍSTICO",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "LESÃO CORPORAL-AGRESSÃO POR ARMA DE FOGO",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "LESÃO CORPORAL-AGRESSÃO POR ARMA BRANCA",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "LESÃO CORPORAL-AGRESSÃO FÍSICA",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA CLÍNICA-COMA ALCOÓLICO",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA CLÍNICA-INSOLAÇÃO/DESIDRATAÇÃO",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA CLÍNICA-AVC/DESMAIO/SÍNCOPE",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA CLÍNICA-OUTRAS DIVERSAS",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA RESPIRATÓRIA",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA CARDÍACA",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "EMERGÊNCIA OBSTÉTRICA",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "VÍTIMA DE QUEDA",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "QUEIMADURAS",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "CHOQUE ELÉTRICO",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "APH OUTROS-ESPECIFICAR",
                          occurrence_type_id: OccurrenceType.get_pre_hospital_services_id
                        },
                        {
                          description: "PREVENÇÃO DE INCÊNCIO (ATIVAÇÃO DE EQUIPE DE INTERVENÇÃO E/OU UNIDADE TÁTICA)",
                          occurrence_type_id: OccurrenceType.get_prevention_id
                        },
                        {
                          description: "PREVENÇÃO DE APH (ATIVAÇÃO DE PLATAFORMA DE ATENDIMENTO E/OU UNIDADE TÁTICA)",
                          occurrence_type_id: OccurrenceType.get_prevention_id
                        },
                        {
                          description: "PREVENÇÃO DE SALVAMENTO (ATIVAÇÃO DE EQUIPE DE INTERVENÇÃO E/OU UNIDADE TÁTICA)",
                          occurrence_type_id: OccurrenceType.get_prevention_id
                        },
                        {
                          description: "PREVENÇÃO DE SALVAMENTO AQUÁTICO (ATIVAÇÃO DE POSTO DE GVs E/OU EMBARCAÇÕES)",
                          occurrence_type_id: OccurrenceType.get_prevention_id
                        },
                        {
                          description: "PREVENÇÃO ATIVA/REATIVA (ORIENTAÇÃO AO BANHISTA)",
                          occurrence_type_id: OccurrenceType.get_prevention_id
                        }
                      ]
occurrence_natures.each do |occurrence_nature|
  OccurrenceNature.find_or_create_by!(occurrence_nature)
end