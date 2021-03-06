import React, {Fragment} from 'react';
import ReactDOM from 'react-dom';
import CustomBarChart from '../../../../components/custom_bar_chart';

export default class OccurrenceAmountByInterval extends React.Component {
    constructor(props) {
        super(props);
       
        this.state = {
        };
    }
    
    render() {
        return (
          <div className="row">
            <div className="col-12">
              <div className="card">
                  <div className="card-header border-0">
                    <div className="d-flex justify-content-between">
                      <h3 className="card-title">Ocorrências por Intervalo de Lançamento</h3>
                    </div>
                  </div>
                  <div className="card-body">
                    <CustomBarChart
                      route={"/events/"+this.props.event.id+"/occurrence_amount_by_interval"}
                      height={400}
                      bars={[
                        {dataKey: "amount", fill: "#8884d8", name: "Ocorrências"}
                      ]}
                    />
                  </div>
                </div>
            </div>
          </div>
        );
    }
}