import React, {Fragment} from 'react';
import ReactDOM from 'react-dom';
import Axios from 'axios';
import MaterialTable from 'material-table';

export default class ModalServiceStations extends React.Component {
    constructor(props) {
        super(props);
        
        this.state = {
            columns: [
                { title: '', field: 'name'},
            ],

            data: props.data,
        };

        this.tableRef = React.createRef();
    }
    
    renderTableServiceStations = () => {
        return( 
            <MaterialTable
                title={""}
                columns={this.state.columns}
                data={this.state.data}
                tableRef={this.tableRef}
                options={{
                    toolbarButtonAlignment: "left",
                    search: true,
                    searchFieldAlignment: 'left',
                    header: false,
                    showTitle: false

                    // searchFieldStyle: { textTransform: 'none' }
                }}
                localization={{
                    header: {
                        actions: ""
                    },
                    toolbar: {
                        searchTooltip: "Buscar",
                        searchPlaceholder: "Buscar"
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
                editable={{}}
                actions={[
                    {
                        icon: 'note_add',
                        tooltip: "Acompanhar Ocorrências",
                        onClick: (event, rowData) => {
                            window.location = ("/occurrences/"+rowData.id+"/index/");
                        }
                    }
                ]}
                />
        );
    }


    render(){
        return(
            <div className="modal fade" id="modal-service-stations">
                <div className="modal-dialog">
                    <div className="modal-content">
                        <div className="modal-header">
                            <h4 className="modal-title">Selecione o Posto de Atendimento</h4>
                            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div className="modal-body">
                            {this.renderTableServiceStations()}
                        </div>    
                    </div>
                    
                </div>
                
            </div>
        );
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('modal_service_stations_data_id')
    ReactDOM.render(
        <ModalServiceStations
            eventData={JSON.parse(node.getAttribute('eventData'))}
            data={JSON.parse(node.getAttribute('data'))}
        />,
        document.getElementById('modal_service_stations')
    )
})