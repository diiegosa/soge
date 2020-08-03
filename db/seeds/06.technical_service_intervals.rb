puts "Cadastrando Períodos de Serviço Técnico..."
technical_service_intervals = [
    {
        description: "PRÉ-CARNAVAL",
        year: 2020
    },
    {
        description: "CARNAVAL",
        year: 2020
    },
    {
        description: "PÓS-CARNAVAL",
        year: 2020
    },
]
technical_service_intervals.each do |technical_service_interval|
  TechnicalServiceInterval.find_or_create_by!(technical_service_interval)
end