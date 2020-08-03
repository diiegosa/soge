import React, {Fragment} from 'react';
import ReactDOM from 'react-dom';
import Axios from 'axios';

export default class Fields extends React.Component {
    static intervalSelectText = { occurrenceNatureSelect: 'Selecione a Natureza...', default: 'Selecione...', loading: 'Carregando...' };
    constructor(props) {
        super(props);
       
        this.state = {
            intervalSelectDisable: true, 
            intervalSelectAvailableIntervals: [],
            intervalSelectText: Fields.intervalSelectText.occurrenceNatureSelect
        }
    }

    componentDidMount = () => { if (this.isEdit()) { this.getAvailableIntervals(this.props.occurrence.occurrence_nature_id) }}

    isEdit = () => { return this.props.occurrence.id != null }

    onChangeOccurrenceNature = (e) => {
        this.props.occurrence.interval = 0
        this.getAvailableIntervals(e.target.value);
    }

    getAvailableIntervals = (occurrence_nature_id) => {
        this.setState({intervalSelectAvailableIntervals: [], intervalSelectDisable: true, intervalSelectText: Fields.intervalSelectText.loading })
        Axios.get('/' + this.props.serviceStationId + '/get_available_intervals/' + occurrence_nature_id).then(response => {
            this.setState({ 
                intervalSelectDisable: false, 
                intervalSelectAvailableIntervals: response.data.available_intervals,
                intervalSelectText: Fields.intervalSelectText.default
            })
        }).catch(error => {
            console.log(error);
        });
    }

    isSelected = (intervalValue) => { return this.props.occurrence.interval == intervalValue }

    isDisabled = (interval) => { return interval.disabled && !this.isSelected(interval.value) }

    renderTitleOption = (interval) => { return this.isDisabled(interval) ? "Você pode clicar em Voltar e editar o registro desta ocorrência" : "" }

    renderDescriptionOption = (interval) => {
        return this.isDisabled(interval) ? interval.description + " (já existe ocorrência cadastrada para este intervalo)" : interval.description
    }

    renderOption = () => {
        return (
            this.state.intervalSelectAvailableIntervals.map((interval, key) => {
                return  <option selected={this.isSelected(interval.value)} title={this.renderTitleOption(interval)} key={key} disabled={this.isDisabled(interval)} value={interval.value}>
                            {this.renderDescriptionOption(interval)} 
                        </option>
            })
        )
    }

    render() {
        return (
            <div className="row">
                <div className="form-group col-sm-6">
                    <label className="control-label text-right">Natureza da ocorrência</label>
                    <select defaultValue={this.props.occurrence.occurrence_nature_id} className="form-control selectpicker" data-live-search="true" name="occurrence[occurrence_nature_id]" onChange={this.onChangeOccurrenceNature} required="required">
                        <option value="">Selecionar...</option>
                        {
                            this.props.occurrenceNatures.map(function (nature) {
                                return <option key={nature.value} value={nature.value}>{nature.description}</option>
                            })
                        }
                    </select>
                </div>
                <div className="form-group col-sm-2">
                    <label className="control-label text-right">Quantidade</label>
                    <input className="form-control" defaultValue={this.props.occurrence.amount} step="1" required="required" min="1" type="number" name="occurrence[amount]"></input>    
                </div>
                <div className="form-group col-sm-4">
                    <label className="control-label text-right">Intervalo</label>
                    <select defaultValue={this.props.occurrence.interval} className="form-control" name="occurrence[interval]" disabled={this.state.intervalSelectDisable} required="required">
                        <option value="">{this.state.intervalSelectText}</option>
                        { this.renderOption() }
                    </select>
                </div>
            </div>
        );
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('occurrence_fields_id')
    ReactDOM.render(
        <Fields 
            serviceStationId={JSON.parse(node.getAttribute('service_station_id'))} 
            occurrenceNatures= {JSON.parse(node.getAttribute('occurrence_natures'))}
            occurrence={JSON.parse(node.getAttribute('occurrence'))}
        />,
        document.getElementById('occurrence_fields')
    )
})