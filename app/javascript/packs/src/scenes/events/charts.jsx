import React, { Fragment } from 'react';
import ReactDOM from 'react-dom';
import OccurrenceAmountByServiceStation from '../events/charts/occurrence_amount_by_service_station'
import OccurrenceAmountByInterval from '../events/charts/occurrence_amount_by_interval'

export default class Charts extends React.Component {
    constructor(props) {
        super(props);

        this.state = {


        };

    }

    render() {
        return (
            <Fragment>
                <OccurrenceAmountByServiceStation event={this.props.eventData} />

                <OccurrenceAmountByInterval event={this.props.eventData} />
            </Fragment>
        );
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('charts_data_id')
    ReactDOM.render(
        <Charts
            eventData={JSON.parse(node.getAttribute('eventData'))}
        />,
        document.getElementById('charts')
    )
})
