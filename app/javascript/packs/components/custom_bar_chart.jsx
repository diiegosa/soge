import React, {Fragment} from 'react';
import ReactDOM from 'react-dom';
import Axios from 'axios'
import {
  ResponsiveContainer,BarChart, Bar, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';

export default class CustomBarChart extends React.Component {
    constructor(props) {
        super(props);
       
        this.state = {
            data: [],
            total: 0 
        };
    }

    getDataX() {
      Axios.get(this.props.route )
        .then((response) => {
          let total = 0;
          response.data.result.map( item => { total += item.total });
          this.setState({ data: response.data.result, total: total });
        })
        .catch((error) => {
          console.log(error);
      });
    }
    
    componentDidMount(){
      this.getDataX();
    }

    render() {
      return (
        <ResponsiveContainer width="100%" height={this.props.height}>
          
          <BarChart
            data={this.state.data}
            margin={{
              top: 5, right: 30, left: 20, bottom: 5,
            }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Legend />
            
            {
              this.props.bars.map((bar) => 
                <Bar key={bar.dataKey} dataKey={bar.dataKey} fill={bar.fill} name={bar.name} />
              )
            }
          </BarChart>

        </ResponsiveContainer>
      );
    }
}