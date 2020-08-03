import React, {Fragment} from 'react';
import ReactDOM from 'react-dom';
import Axios from 'axios';
import MaterialTable from 'material-table';

export default class ServiceStations extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
            current_service_station_type_id: null,
            columns: [
                { title: 'Tipo', field: 'service_station_type_id',
                    render: rowData => rowData.service_station_type.description,
                    editComponent: props => {
                        return (
                            <select 
                                className={"form-control"}
                                onChange={e => {
                                    this.setState({current_service_station_type_id: e.target.value})
                                    props.onChange(e.target.value)
                                }}
                                defaultValue={props.value}
                            >
                                <option value="">Selecionar...</option>
                                {
                                    this.props.service_station_types.map((service_station_type, index) =>
                                        (<option key={service_station_type.id} value={service_station_type.id}>
                                            {service_station_type.description}
                                        </option>))
                                }
                            </select>
                        );
                    }
                },
                { title: 'Viatura', field: 'service_station_vehicle_type.vehicle_type_id',
                    render: rowData => rowData.service_station_type_id == this.props.vehicle_service_station_type_id && rowData.service_station_vehicle_type ? rowData.service_station_vehicle_type.vehicle_type.description : "----",
                    editComponent: props => {
                        return (this.state.current_service_station_type_id == this.props.vehicle_service_station_type_id || props.rowData.service_station_type_id == this.props.vehicle_service_station_type_id) ? (
                            <select 
                                className={"form-control"}
                                onChange={e => {
                                    props.onChange(e.target.value)
                                }}
                                defaultValue={props.value}
                            >
                                <option value="">Selecionar...</option>
                                {
                                    this.props.vehicle_types.map((vehicle_type, index) =>
                                        (<option key={vehicle_type.id} value={vehicle_type.id} title={vehicle_type.about}>
                                            {vehicle_type.description}
                                        </option>))
                                }
                            </select>) : "----";
                    }
                },
                { title: 'Nome', field: 'description'},
                { title: 'Sigla', field: 'acronym'},
            ].concat(this.generateColumnsWorkShifts()),

            data: props.command_post.service_stations,
        };

        this.tableRef = React.createRef();

    }

    componentDidMount(){
        this.forceUpdateData();
    }

    generateColumnsWorkShifts = () => {
        let columns_work_shifts = [];
        for(let i = 0; i < this.props.event.work_shift_amount; i++)
            columns_work_shifts.push( { title: 'Militares '+(i+1)+'º Turno', field: 'service_station_work_shifts['+i+'].militaries_quantity', type: 'numeric'})
        return columns_work_shifts;
    }

    mergeObjects = (array_objects) => {
        let result = {};
        array_objects.forEach(function(object){
            result = Object.assign(result, object);
        });
        return result;
    }

    //atualiza a relação de alunos
    forceUpdateData = () => {
        Axios.get('/service_stations.json?utf8=✓&q[event_id_eq]=' + this.props.event.id + '&q[command_post_id_eq]=' + this.props.command_post.id).then((response) => {
            this.setState({
                data: response.data
            })
        }).catch(error => {
            console.log(error);
            toastr.error(error);
        });
    }

    //Cadastra um novo aluno.
    createServiceStation = (data) => {
        return new Promise((resolve, reject) => {

            data = Object.assign({
                description: "",
                acronym: "",
                service_station_type_id: "",
                command_post_id: ""
            }, data);
            
            let form = new FormData();
            form.set("service_station[event_id]", this.props.event.id);
            form.set("service_station[command_post_id]", this.props.command_post.id);
            form.set("service_station[service_station_type_id]", data.service_station_type_id);

            form.set("service_station[description]", data.description);
            form.set("service_station[acronym]", data.acronym);

            if(data.service_station_vehicle_type)
                form.set("service_station[service_station_vehicle_type_attributes][vehicle_type_id]", data.service_station_vehicle_type ? data.service_station_vehicle_type.vehicle_type_id : 0);

            this.generateColumnsWorkShifts().forEach(function(object, index){
                form.set("service_station[service_station_work_shifts_attributes]["+(index+1)+"][work_shift]", (index+1) );
                form.set("service_station[service_station_work_shifts_attributes]["+(index+1)+"][militaries_quantity]", data.service_station_work_shifts[index].militaries_quantity );
            });

            Axios.post('/service_stations.json', form).then((response) => {
                toastr.info("Posto de atendimento criado com sucesso!");
                resolve(response);
            }).catch(error => {
                console.error(error);
                if(error.response){
                    error.response.data.map((value, index) => {
                        toastr.error(value);
                    });
                } else {
                    toastr.error(error.message);
                }
                reject(error);
            });
        });    
    }

    updateServiceStation = (data) => {
        return new Promise((resolve, reject) => {

            data = Object.assign({
                description: "",
                acronym: "",
                service_station_type_id: "",
                command_post_id: ""
            }, data);
            
            let form = new FormData();
            form.set("service_station[event_id]", this.props.event.id);
            form.set("service_station[command_post_id]", this.props.command_post.id);
            form.set("service_station[service_station_type_id]", data.service_station_type_id);

            form.set("service_station[description]", data.description);
            form.set("service_station[acronym]", data.acronym);

            if(data.service_station_vehicle_type)
                form.set("service_station[service_station_vehicle_type_attributes][vehicle_type_id]", data.service_station_vehicle_type ? data.service_station_vehicle_type.vehicle_type_id : 0);

            this.generateColumnsWorkShifts().forEach(function(object, index){
                form.set("service_station[service_station_work_shifts_attributes]["+(index+1)+"][id]", data.service_station_work_shifts[index].id ? data.service_station_work_shifts[index].id : '' );
                form.set("service_station[service_station_work_shifts_attributes]["+(index+1)+"][work_shift]", (index+1) );
                form.set("service_station[service_station_work_shifts_attributes]["+(index+1)+"][militaries_quantity]", data.service_station_work_shifts[index].militaries_quantity );
            });

            Axios.put('/service_stations/'+data.id+'.json', form).then((response) => {
                toastr.info("Posto de atendimento atualizado!");
                resolve(response);
            }).catch(error => {
                console.error(error);
                if(error.response){
                    error.response.data.map((value, index) => {
                        toastr.error(value);
                    });
                } else {
                    toastr.error(error.message);
                }
                reject(error);
            });
        });    
    }

    deleteServiceStation = (oldData) => {
        return new Promise((resolve, reject) => {
            Axios.delete('/service_stations/'+oldData.id+'.json').then((response) => {
                response.data == "" ?
                    toastr.info("Posto de atendimento '"+oldData.description+"' excluído com sucesso!") :
                        toastr.error(response.data.error); 
                resolve(response);
            }).catch(error => {
                console.error(error,response);
                if(error.response){
                    error.response.data.map((value, index) => {
                        toastr.error(value);
                    });
                } else {
                    toastr.error(error.message);
                }
                reject(error);
            });
        });
    }


    renderTableServiceStation = () => {
        return( 
            <MaterialTable
                title={"Postos de Atendimento"}
                columns={this.state.columns}
                data={this.state.data}
                tableRef={this.tableRef}
                options={{
                    addRowPosition: "first",
                    toolbarButtonAlignment: "left",
                    actionsColumnIndex: -1 // 0: esquerda // -1: direita
                }}
                localization={{
                    header: {
                        actions: "Ações"
                    },
                    toolbar: {
                        searchTooltip: "Buscar",
                        searchPlaceholder: "Buscar"
                    },
                    body: {
                        editRow: {deleteText: "Tem certeza que deseja excluir este posto de atendimento?"},
                        emptyDataSourceMessage: "Nenhum registro.",
                        addTooltip: "Adicionar",
                        editTooltip: "Editar",
                        deleteTooltip: "Excluir"
                    },
                    pagination: {
                        labelRowsSelect: "Postos de Atendimento",
                        labelRowsPerPage: "Postos de Atendimento por página:",
                        labelDisplayedRows: "{from}-{to} de {count}",
                        firstAriaLabel: "Primeira página",
                        firstTooltip: "Primeira página",
                        previousAriaLabel: "Anterior",
                        previousTooltip: "Anterior",
                        nextAriaLabel: "Próxima",
                        nextTooltip: "Próxima",
                        lastAriaLabel: "Última",
                        lastTooltip: "Última"
                    }
                }}
                editable={{
                    
                    onRowAdd: newData =>  
                        new Promise((resolve, reject) => {
                            this.createServiceStation(newData).then(response => {
                                this.forceUpdateData();
                                resolve();
                            }).catch(error => {
                                reject();
                            })
                        }),
                    onRowUpdate: (newData, oldData) =>
                        new Promise((resolve, reject) => {
                            this.updateServiceStation(newData).then(response => {
                                this.forceUpdateData();
                                resolve();
                            }).catch(error => {
                                reject();
                            })
                        }),
                    onRowDelete: oldData =>
                    new Promise((resolve, reject) => {
                        this.deleteServiceStation(oldData).then(response => {                          
                            this.forceUpdateData();
                            resolve();
                        }).catch(error => {
                            reject();
                        })
                    }),
                }}
                />
        );
    }

    render(){
        return(
            this.renderTableServiceStation()
        );
    }
}