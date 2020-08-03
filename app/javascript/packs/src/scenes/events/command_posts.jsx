import React, {Fragment} from 'react';
import ReactDOM from 'react-dom';
import ServiceStations from './service_stations'

export default class CommandPosts extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    renderTabs = () => {
        return(
            this.props.commandPosts.map((command_post, index) =>
                <li className="nav-item" key={command_post.id}>
                    <a className={"nav-link " + (index == 0 ? 'active' : '') } id={"tab-button-"+command_post.id} data-toggle="pill" href={"#tab-content-"+command_post.id} role="tab" aria-controls={"tab-content-"+command_post.id} aria-selected="true">{command_post.acronym}</a>
                </li>
            )
        );
    }

    renderTabsContent = () => {
        return(
            this.props.commandPosts.map((command_post, index) =>
                <div key={command_post.id} className={"tab-pane fade" + (index == 0 ? 'show active' : '') } id={"tab-content-"+command_post.id} role="tabpanel" aria-labelledby={"tab-button-"+command_post.id}>
                    <ServiceStations
                        event={this.props.eventData}
                        command_post={command_post}
                        service_station_types={this.props.serviceStationTypes}
                        vehicle_types={this.props.vehicleTypes}
                        vehicle_service_station_type_id={this.props.vehicleServiceStationTypeId}
                     />
                </div>
            )
        );
    }

    render() {
        return (
            <div className="card card-primary card-outline card-outline-tabs">
                <div className="card-header p-0 border-bottom-0">
                    <ul className="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                        { this.renderTabs() }
                    </ul>
                </div>

                <div className="card-body">
                    <div className="tab-content" id="custom-tabs-three-tabContent">
                        { this.renderTabsContent() }
                    </div>
                </div>
            </div>
        );
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('command_post_data_id')
    ReactDOM.render(
        <CommandPosts
            eventData={JSON.parse(node.getAttribute('eventData'))}
            commandPosts={JSON.parse(node.getAttribute('commandPosts'))}
            serviceStationTypes={JSON.parse(node.getAttribute('serviceStationTypes'))}
            vehicleTypes={JSON.parse(node.getAttribute('vehicleTypes'))}
            vehicleServiceStationTypeId={JSON.parse(node.getAttribute('vehicleServiceStationTypeId'))}
        />,
        document.getElementById('command_post_tabs')
    )
})
